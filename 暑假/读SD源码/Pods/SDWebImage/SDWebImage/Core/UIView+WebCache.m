/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
#import "SDWebImageError.h"
#import "SDInternalMacros.h"
#import "SDWebImageTransitionInternal.h"

const int64_t SDWebImageProgressUnitCountUnknown = 1LL;

@implementation UIView (WebCache)

- (nullable NSURL *)sd_imageURL {
    return objc_getAssociatedObject(self, @selector(sd_imageURL));
}

- (void)setSd_imageURL:(NSURL * _Nullable)sd_imageURL {
    objc_setAssociatedObject(self, @selector(sd_imageURL), sd_imageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nullable NSString *)sd_latestOperationKey {
    return objc_getAssociatedObject(self, @selector(sd_latestOperationKey));
}

- (void)setSd_latestOperationKey:(NSString * _Nullable)sd_latestOperationKey {
    objc_setAssociatedObject(self, @selector(sd_latestOperationKey), sd_latestOperationKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSProgress *)sd_imageProgress {
    NSProgress *progress = objc_getAssociatedObject(self, @selector(sd_imageProgress));
    if (!progress) {
        progress = [[NSProgress alloc] initWithParent:nil userInfo:nil];
        self.sd_imageProgress = progress;
    }
    return progress;
}

- (void)setSd_imageProgress:(NSProgress *)sd_imageProgress {
    objc_setAssociatedObject(self, @selector(sd_imageProgress), sd_imageProgress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//核心方法一
- (void)sd_internalSetImageWithURL:(nullable NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholder
                           options:(SDWebImageOptions)options
                           context:(nullable SDWebImageContext *)context
                     setImageBlock:(nullable SDSetImageBlock)setImageBlock
                          progress:(nullable SDImageLoaderProgressBlock)progressBlock
                         completed:(nullable SDInternalCompletionBlock)completedBlock {
    //检查 context 是否为空：
    if (context) {
        //复制 context 以避免修改（保证不可变性），防止其内容被意外修改，从而确保线程安全和稳定性。
        context = [context copy];
    } else {
        //如果 context 为空，代码会创建一个新的空字典（NSDictionary）。
        //这个空字典将作为默认的 context，以避免后续操作中 context 为空导致的潜在错误。
        context = [NSDictionary dictionary];
    }
    
// 取消重复操作
    NSString *validOperationKey = context[SDWebImageContextSetImageOperationKey];//从上下文中获取操作的标识符（validOperationKey），如果没有，就继续生成一个唯一标识符。
    if (!validOperationKey) { //如果上下文中没有标识符，那么通过当前类名生成一个默认的标识符，并更新到上下文中。
        
        validOperationKey = NSStringFromClass([self class]);
        SDWebImageMutableContext *mutableContext = [context mutableCopy];
        mutableContext[SDWebImageContextSetImageOperationKey] = validOperationKey;
        context = [mutableContext copy];
    }
    self.sd_latestOperationKey = validOperationKey; //把这个标识符存储到当前对象的属性 sd_latestOperationKey 中，方便后续使用。
    [self sd_cancelImageLoadOperationWithKey:validOperationKey]; //这一步是核心所在，通过调用 sd_cancelImageLoadOperationWithKey: 方法，用当前的标识符去查找是否有相同标识符的加载操作正在进行。
    //如果找到，就取消它，确保不会有多个相同的加载操作在同一个图片控件上进行。
    
//初始化SDWebImageManager
    self.sd_imageURL = url; // 将传入的图片 URL 赋值给当前对象的 sd_imageURL 属性，以便后续操作能够访问到该 URL
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock cacheType:SDImageCacheTypeNone imageURL:url];
        });
    }

//根据给定的 URL 异步加载图片，并在不同阶段处理进度更新、加载完成的回调、占位图设置、动画过渡等操作
    if (url) { //// 如果URL存在，则进行图片加载操作
        // 1. 检查并初始化进度对象与加载指示器
        NSProgress *imageProgress = objc_getAssociatedObject(self, @selector(sd_imageProgress)); //通过 objc_getAssociatedObject 获取与当前对象关联的 NSProgress 对象（用于跟踪加载进度）。
        if (imageProgress) { //如果进度对象存在
            imageProgress.totalUnitCount = 0; // 将总进度单位数置为0
            imageProgress.completedUnitCount = 0; // 将已完成的单位数置为0
        }
        
        //如果项目是 iOS 或 macOS 环境，调用 sd_startImageIndicator
#if SD_UIKIT || SD_MAC
        ///启动图片加载指示器（例如加载动画）
        [self sd_startImageIndicator]; // 启动与当前对象关联的加载指示器
        id<SDWebImageIndicator> imageIndicator = self.sd_imageIndicator; //获取并保存指示器实例 imageIndicator，后续可能用于更新进度显示。

#endif
        //2. 获取并配置图片管理器
        SDWebImageManager *manager = context[SDWebImageContextCustomManager]; //尝试从 context 中获取一个自定义的 SDWebImageManager 实例。
        if (!manager) { // 如果没有自定义的SDWebImageManager
            manager = [SDWebImageManager sharedManager]; // 使用SDWebImageManager的共享实例
        } else {
            //如果使用了自定义管理器，为了避免循环引用（manager -> loader -> operation -> context -> manager），将其从context中移除
            // 代码会复制 context 为可变字典，并将其中的自定义管理器引用移除，最后再将字典复制回不可变状态。
            SDWebImageMutableContext *mutableContext = [context mutableCopy]; // 将context复制为可变字典
            mutableContext[SDWebImageContextCustomManager] = nil;  // 将自定义管理器置为nil，移除引用
            context = [mutableContext copy]; // 将可变字典再复制回不可变字典
        }
        
        //3. 定义并组合进度回调，用于在图片加载过程中更新进度
        SDImageLoaderProgressBlock combinedProgressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            if (imageProgress) {  // 如果进度对象存在
                imageProgress.totalUnitCount = expectedSize; //设置总进度单位数
                imageProgress.completedUnitCount = receivedSize; // 更新已完成的单位数
            }
        //在 iOS 或 macOS 环境中，如果 imageIndicator 存在并支持更新进度，则在主线程中更新进度显示。
#if SD_UIKIT || SD_MAC
            if ([imageIndicator respondsToSelector:@selector(updateIndicatorProgress:)]) { // 如果加载指示器支持进度更新
                double progress = 0; // 初始化进度为0
                if (expectedSize != 0) { // 如果期望的大小不为0
                    progress = (double)receivedSize / expectedSize; // 计算进度百分比
                }
                progress = MAX(MIN(progress, 1), 0); // 确保进度在0到1之间
                dispatch_async(dispatch_get_main_queue(), ^{ // 在主线程上更新UI
                    [imageIndicator updateIndicatorProgress:progress]; // 更新加载指示器的进度
                });
            }
#endif
            if (progressBlock) { // 如果外部提供了进度回调
                progressBlock(receivedSize, expectedSize, targetURL); // 调用外部进度回调，传递当前的进度数据
            }
        };
        
        // 4. 启动图片加载操作
        // 使用 @weakify来避免block中的循环引用
        @weakify(self);
//这是核心方法，需要进去详细研究
        id <SDWebImageOperation> operation = [manager loadImageWithURL:url options:options context:context progress:combinedProgressBlock completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            @strongify(self); //使用 @strongify来确保self在block中仍然有效
            
            if (!self) { return; } // 如果self已被释放，则直接返回
            
            // 如果进度未更新但加载已完成且没有错误，将进度标记为完成状态
            if (imageProgress && finished && !error && imageProgress.totalUnitCount == 0 && imageProgress.completedUnitCount == 0) {
                
                imageProgress.totalUnitCount = SDWebImageProgressUnitCountUnknown;  // 标记总进度单位数为未知
                imageProgress.completedUnitCount = SDWebImageProgressUnitCountUnknown; // 标记已完成的单位数为未知
            }
            
        // 5. 处理加载完成或失败后的回调
    //在 iOS 或 macOS 环境中
#if SD_UIKIT || SD_MAC
            // 如果加载已完成，停止加载指示器（隐藏加载动画）
            if (finished) {
                [self sd_stopImageIndicator]; // 停止加载指示器
            }
#endif
            //根据加载选项 options（外部传进来的参数） 决定 是否需要调用完成回调 completedBlock。（这个也是外部传进来的block）
            BOOL shouldCallCompletedBlock = finished || (options & SDWebImageAvoidAutoSetImage);
            // 判断是否不应自动设置图片
            BOOL shouldNotSetImage = ((image && (options & SDWebImageAvoidAutoSetImage)) ||
                                      (!image && !(options & SDWebImageDelayPlaceholder)));
            // 定义一个无参block，用于在主线程上调用完成回调并设置图片
            SDWebImageNoParamsBlock callCompletedBlockClojure = ^{
                if (!self) { return; } // 如果self已被释放，则直接返回
                if (!shouldNotSetImage) { // 如果应该设置图片
                    [self sd_setNeedsLayout];  // 触发布局更新
                }
                if (completedBlock && shouldCallCompletedBlock) { // 如果需要调用完成回调
                    completedBlock(image, data, error, cacheType, finished, url); // 调用完成回调
                }
            };
            
            //情况1：获得图片但设置了SDWebImageAvoidAutoSetImage标志，或者未获得图片且未设置SDWebImageDelayPlaceholder标志，也就是应该自动设置图片
            if (shouldNotSetImage) {
                dispatch_main_async_safe(callCompletedBlockClojure);  // 在主线程上执行完成回调并返回
                return;
            }
            
        //6. 设置最终图片并执行完成回调
            UIImage *targetImage = nil; // 初始化目标图片为空
            NSData *targetData = nil; // 初始化目标图片数据为空
            if (image) { // 如果成功加载了图片
                // 情况2a：获得图片且未设置SDWebImageAvoidAutoSetImage标志
                targetImage = image; // 将加载的图片设置为目标图片
                targetData = data; // 将加载的图片数据设置为目标数据
            } else if (options & SDWebImageDelayPlaceholder) { // 如果未加载到图片且设置了SDWebImageDelayPlaceholder标志
                // 情况2b：未获得图片且设置了SDWebImageDelayPlaceholder标志
                targetImage = placeholder; // 将占位图设置为目标图片
                targetData = nil;  // 目标数据为空
            }
            
#if SD_UIKIT || SD_MAC
            // 检查是否需要使用图片过渡动画
            SDWebImageTransition *transition = nil; // 初始化过渡动画为空
            BOOL shouldUseTransition = NO; // 默认不使用过渡动画
            if (options & SDWebImageForceTransition) { // 如果设置了强制使用过渡动画标志
                // Always
                shouldUseTransition = YES; // 使用过渡动画
            } else if (cacheType == SDImageCacheTypeNone) { // 如果图片是从网络加载的
                // From network
                shouldUseTransition = YES; // 使用过渡动画
            } else {
                // From disk (and, user don't use sync query)
                if (cacheType == SDImageCacheTypeMemory) { // 如果图片是从缓存加载的
                    shouldUseTransition = NO; // 不使用过渡动画
                } else if (cacheType == SDImageCacheTypeDisk) { // 如果图片是从磁盘缓存加载的
                    if (options & SDWebImageQueryMemoryDataSync || options & SDWebImageQueryDiskDataSync) { // 如果是同步查询
                        shouldUseTransition = NO;  // 不使用过渡动画
                    } else {
                        shouldUseTransition = YES; // 使用过渡动画
                    }
                } else {
                    // 如果缓存类型无效，默认不使用过渡动画
                    shouldUseTransition = NO;
                }
            }
            if (finished && shouldUseTransition) { // 如果加载完成且需要使用过渡动画
                transition = self.sd_imageTransition; // 获取设置的过渡动画
            }
#endif
            
            dispatch_main_async_safe(^{ // 在主线程上更新UI
                
#if SD_UIKIT || SD_MAC
                // 设置最终图片，并可能使用过渡动画
                [self sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock transition:transition cacheType:cacheType imageURL:imageURL];
#else
                // 设置最终图片，不使用过渡动画
                [self sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock cacheType:cacheType imageURL:imageURL];
#endif
                // 执行完成回调
                callCompletedBlockClojure();
            });
        }];
        // 保存图片加载操作 （这里要点进去看）
        [self sd_setImageLoadOperation:operation forKey:validOperationKey];
    // 7. 处理 URL 为 nil 的情况
    } else { // 如果URL为空
        
#if SD_UIKIT || SD_MAC
        [self sd_stopImageIndicator]; // 停止加载指示器
#endif
        dispatch_main_async_safe(^{ // 在主线程上处理URL为空的情况
            if (completedBlock) { // 如果有完成回调
                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorInvalidURL userInfo:@{NSLocalizedDescriptionKey : @"Image url is nil"}]; // 创建错误对象
                completedBlock(nil, nil, error, SDImageCacheTypeNone, YES, url); // 调用完成回调，传递错误信息
            }
        });
    }
}

- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:self.sd_latestOperationKey];
    self.sd_latestOperationKey = nil;
}

- (void)sd_setImage:(UIImage *)image imageData:(NSData *)imageData basedOnClassOrViaCustomSetImageBlock:(SDSetImageBlock)setImageBlock cacheType:(SDImageCacheType)cacheType imageURL:(NSURL *)imageURL {
#if SD_UIKIT || SD_MAC
    [self sd_setImage:image imageData:imageData basedOnClassOrViaCustomSetImageBlock:setImageBlock transition:nil cacheType:cacheType imageURL:imageURL];
#else
    // watchOS does not support view transition. Simplify the logic
    if (setImageBlock) {
        setImageBlock(image, imageData, cacheType, imageURL);
    } else if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self;
        [imageView setImage:image];
    }
#endif
}

#if SD_UIKIT || SD_MAC
- (void)sd_setImage:(UIImage *)image imageData:(NSData *)imageData basedOnClassOrViaCustomSetImageBlock:(SDSetImageBlock)setImageBlock transition:(SDWebImageTransition *)transition cacheType:(SDImageCacheType)cacheType imageURL:(NSURL *)imageURL {
    UIView *view = self;
    SDSetImageBlock finalSetImageBlock;
    if (setImageBlock) {
        finalSetImageBlock = setImageBlock;
    } else if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view;
        finalSetImageBlock = ^(UIImage *setImage, NSData *setImageData, SDImageCacheType setCacheType, NSURL *setImageURL) {
            imageView.image = setImage;
        };
    }
#if SD_UIKIT
    else if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        finalSetImageBlock = ^(UIImage *setImage, NSData *setImageData, SDImageCacheType setCacheType, NSURL *setImageURL) {
            [button setImage:setImage forState:UIControlStateNormal];
        };
    }
#endif
#if SD_MAC
    else if ([view isKindOfClass:[NSButton class]]) {
        NSButton *button = (NSButton *)view;
        finalSetImageBlock = ^(UIImage *setImage, NSData *setImageData, SDImageCacheType setCacheType, NSURL *setImageURL) {
            button.image = setImage;
        };
    }
#endif
    
    if (transition) {
        NSString *originalOperationKey = view.sd_latestOperationKey;

#if SD_UIKIT
        [UIView transitionWithView:view duration:0 options:0 animations:^{
            if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                return;
            }
            // 0 duration to let UIKit render placeholder and prepares block
            if (transition.prepares) {
                transition.prepares(view, image, imageData, cacheType, imageURL);
            }
        } completion:^(BOOL finished) {
            [UIView transitionWithView:view duration:transition.duration options:transition.animationOptions animations:^{
                if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                    return;
                }
                if (finalSetImageBlock && !transition.avoidAutoSetImage) {
                    finalSetImageBlock(image, imageData, cacheType, imageURL);
                }
                if (transition.animations) {
                    transition.animations(view, image);
                }
            } completion:^(BOOL finished) {
                if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                    return;
                }
                if (transition.completion) {
                    transition.completion(finished);
                }
            }];
        }];
#elif SD_MAC
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull prepareContext) {
            if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                return;
            }
            // 0 duration to let AppKit render placeholder and prepares block
            prepareContext.duration = 0;
            if (transition.prepares) {
                transition.prepares(view, image, imageData, cacheType, imageURL);
            }
        } completionHandler:^{
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
                if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                    return;
                }
                context.duration = transition.duration;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                CAMediaTimingFunction *timingFunction = transition.timingFunction;
#pragma clang diagnostic pop
                if (!timingFunction) {
                    timingFunction = SDTimingFunctionFromAnimationOptions(transition.animationOptions);
                }
                context.timingFunction = timingFunction;
                context.allowsImplicitAnimation = SD_OPTIONS_CONTAINS(transition.animationOptions, SDWebImageAnimationOptionAllowsImplicitAnimation);
                if (finalSetImageBlock && !transition.avoidAutoSetImage) {
                    finalSetImageBlock(image, imageData, cacheType, imageURL);
                }
                CATransition *trans = SDTransitionFromAnimationOptions(transition.animationOptions);
                if (trans) {
                    [view.layer addAnimation:trans forKey:kCATransition];
                }
                if (transition.animations) {
                    transition.animations(view, image);
                }
            } completionHandler:^{
                if (!view.sd_latestOperationKey || ![originalOperationKey isEqualToString:view.sd_latestOperationKey]) {
                    return;
                }
                if (transition.completion) {
                    transition.completion(YES);
                }
            }];
        }];
#endif
    } else {
        if (finalSetImageBlock) {
            finalSetImageBlock(image, imageData, cacheType, imageURL);
        }
    }
}
#endif

- (void)sd_setNeedsLayout {
#if SD_UIKIT
    [self setNeedsLayout];
#elif SD_MAC
    [self setNeedsLayout:YES];
#elif SD_WATCH
    // Do nothing because WatchKit automatically layout the view after property change
#endif
}

#if SD_UIKIT || SD_MAC

#pragma mark - Image Transition
- (SDWebImageTransition *)sd_imageTransition {
    return objc_getAssociatedObject(self, @selector(sd_imageTransition));
}

- (void)setSd_imageTransition:(SDWebImageTransition *)sd_imageTransition {
    objc_setAssociatedObject(self, @selector(sd_imageTransition), sd_imageTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Indicator
- (id<SDWebImageIndicator>)sd_imageIndicator {
    return objc_getAssociatedObject(self, @selector(sd_imageIndicator));
}

- (void)setSd_imageIndicator:(id<SDWebImageIndicator>)sd_imageIndicator {
    // Remove the old indicator view
    id<SDWebImageIndicator> previousIndicator = self.sd_imageIndicator;
    [previousIndicator.indicatorView removeFromSuperview];
    
    objc_setAssociatedObject(self, @selector(sd_imageIndicator), sd_imageIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Add the new indicator view
    UIView *view = sd_imageIndicator.indicatorView;
    if (CGRectEqualToRect(view.frame, CGRectZero)) {
        view.frame = self.bounds;
    }
    // Center the indicator view
#if SD_MAC
    [view setFrameOrigin:CGPointMake(round((NSWidth(self.bounds) - NSWidth(view.frame)) / 2), round((NSHeight(self.bounds) - NSHeight(view.frame)) / 2))];
#else
    view.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
#endif
    view.hidden = NO;
    [self addSubview:view];
}

- (void)sd_startImageIndicator {
    id<SDWebImageIndicator> imageIndicator = self.sd_imageIndicator;
    if (!imageIndicator) {
        return;
    }
    dispatch_main_async_safe(^{
        [imageIndicator startAnimatingIndicator];
    });
}

- (void)sd_stopImageIndicator {
    id<SDWebImageIndicator> imageIndicator = self.sd_imageIndicator;
    if (!imageIndicator) {
        return;
    }
    dispatch_main_async_safe(^{
        [imageIndicator stopAnimatingIndicator];
    });
}

#endif

@end
