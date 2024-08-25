/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "UIImage+Metadata.h"
#import "SDAssociatedObject.h"
#import "SDWebImageError.h"
#import "SDInternalMacros.h"

static id<SDImageCache> _defaultImageCache;
static id<SDImageLoader> _defaultImageLoader;

@interface SDWebImageCombinedOperation ()

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (strong, nonatomic, readwrite, nullable) id<SDWebImageOperation> loaderOperation;
@property (strong, nonatomic, readwrite, nullable) id<SDWebImageOperation> cacheOperation;
@property (weak, nonatomic, nullable) SDWebImageManager *manager;

@end

//这个类要学
//SDWebImageManager同时管理SDImageCache和SDWebImageDownloader两个类，它是这一层的老大哥。在下载任务开始的时候，SDWebImageManager首先访问SDImageCache来查询是否存在缓存，如果有缓存，直接返回缓存的图片。如果没有缓存，就命令SDWebImageDownloader来下载图片，下载成功后，存入缓存，显示图片。以上是SDWebImageManager大致的工作流程。

@interface SDWebImageManager ()

@property (strong, nonatomic, readwrite, nonnull) SDImageCache *imageCache; //图像缓存对象，负责管理图片的内存和磁盘缓存。SDImageCache` 是 SDWebImage 框架中的核心类，用于处理图片的缓存逻辑。
@property (strong, nonatomic, readwrite, nonnull) id<SDImageLoader> imageLoader; //像加载器对象，负责实际的图片下载或加载操作。这个对象遵循 `SDImageLoader` 协议，可以是网络下载器或者其他自定义的图片加载器。
@property (strong, nonatomic, nonnull) NSMutableSet<NSURL *> *failedURLs; //存储加载失败的 URL 集合。 当某个 URL 的图片加载失败时，会将该 URL 添加到这个集合中，以避免再次尝试加载相同的 URL。
@property (strong, nonatomic, nonnull) dispatch_semaphore_t failedURLsLock; // 访问 `failedURLs` 集合时使用的锁，以确保线程安全。由于多个线程可能同时访问或修改 `failedURLs`，因此需要一个信号量锁来防止竞态条件。
@property (strong, nonatomic, nonnull) NSMutableSet<SDWebImageCombinedOperation *> *runningOperations; //存储当前正在运行的图片加载操作集合。每个图片加载操作（`SDWebImageCombinedOperation`）在启动时都会被添加到这个集合中，以便管理和跟踪正在进行的操作。
@property (strong, nonatomic, nonnull) dispatch_semaphore_t runningOperationsLock; //访问 `runningOperations` 集合时使用的锁，以确保线程安全。由于多个线程可能同时访问或修改 `runningOperations`，因此需要一个信号量锁来防止竞态条件。

@end

@implementation SDWebImageManager

+ (id<SDImageCache>)defaultImageCache {
    return _defaultImageCache;
}

+ (void)setDefaultImageCache:(id<SDImageCache>)defaultImageCache {
    if (defaultImageCache && ![defaultImageCache conformsToProtocol:@protocol(SDImageCache)]) {
        return;
    }
    _defaultImageCache = defaultImageCache;
}

+ (id<SDImageLoader>)defaultImageLoader {
    return _defaultImageLoader;
}

+ (void)setDefaultImageLoader:(id<SDImageLoader>)defaultImageLoader {
    if (defaultImageLoader && ![defaultImageLoader conformsToProtocol:@protocol(SDImageLoader)]) {
        return;
    }
    _defaultImageLoader = defaultImageLoader;
}

+ (nonnull instancetype)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (nonnull instancetype)init {
    id<SDImageCache> cache = [[self class] defaultImageCache];
    if (!cache) {
        cache = [SDImageCache sharedImageCache];
    }
    id<SDImageLoader> loader = [[self class] defaultImageLoader];
    if (!loader) {
        loader = [SDWebImageDownloader sharedDownloader];
    }
    return [self initWithCache:cache loader:loader];
}

- (nonnull instancetype)initWithCache:(nonnull id<SDImageCache>)cache loader:(nonnull id<SDImageLoader>)loader {
    if ((self = [super init])) {
        _imageCache = cache;
        _imageLoader = loader;
        _failedURLs = [NSMutableSet new];
        _failedURLsLock = dispatch_semaphore_create(1);
        _runningOperations = [NSMutableSet new];
        _runningOperationsLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (nullable NSString *)cacheKeyForURL:(nullable NSURL *)url {
    if (!url) {
        return @"";
    }
    
    NSString *key;
    // Cache Key Filter
    id<SDWebImageCacheKeyFilter> cacheKeyFilter = self.cacheKeyFilter;
    if (cacheKeyFilter) {
        key = [cacheKeyFilter cacheKeyForURL:url];
    } else {
        key = url.absoluteString;
    }
    
    return key;
}

- (nullable NSString *)cacheKeyForURL:(nullable NSURL *)url context:(nullable SDWebImageContext *)context {
    if (!url) {
        return @"";
    }
    
    NSString *key;
    // Cache Key Filter
    id<SDWebImageCacheKeyFilter> cacheKeyFilter = self.cacheKeyFilter;
    if (context[SDWebImageContextCacheKeyFilter]) {
        cacheKeyFilter = context[SDWebImageContextCacheKeyFilter];
    }
    if (cacheKeyFilter) {
        key = [cacheKeyFilter cacheKeyForURL:url];
    } else {
        key = url.absoluteString;
    }
    
    // Thumbnail Key Appending
    NSValue *thumbnailSizeValue = context[SDWebImageContextImageThumbnailPixelSize];
    if (thumbnailSizeValue != nil) {
        CGSize thumbnailSize = CGSizeZero;
#if SD_MAC
        thumbnailSize = thumbnailSizeValue.sizeValue;
#else
        thumbnailSize = thumbnailSizeValue.CGSizeValue;
#endif
        BOOL preserveAspectRatio = YES;
        NSNumber *preserveAspectRatioValue = context[SDWebImageContextImagePreserveAspectRatio];
        if (preserveAspectRatioValue != nil) {
            preserveAspectRatio = preserveAspectRatioValue.boolValue;
        }
        key = SDThumbnailedKeyForKey(key, thumbnailSize, preserveAspectRatio);
    }
    
    // Transformer Key Appending
    id<SDImageTransformer> transformer = self.transformer;
    if (context[SDWebImageContextImageTransformer]) {
        transformer = context[SDWebImageContextImageTransformer];
        if (![transformer conformsToProtocol:@protocol(SDImageTransformer)]) {
            transformer = nil;
        }
    }
    if (transformer) {
        key = SDTransformedKeyForKey(key, transformer.transformerKey);
    }
    
    return key;
}

- (SDWebImageCombinedOperation *)loadImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDInternalCompletionBlock)completedBlock {
    return [self loadImageWithURL:url options:options context:nil progress:progressBlock completed:completedBlock];
}

//核心方法二
//这段代码的作用是通过 SDWebImageManager 来加载图片。
//它负责处理从网络或缓存中加载图片的整个流程，并将结果通过回调返回。
- (SDWebImageCombinedOperation *)loadImageWithURL:(nullable NSURL *)url
                                          options:(SDWebImageOptions)options
                                          context:(nullable SDWebImageContext *)context
                                         progress:(nullable SDImageLoaderProgressBlock)progressBlock
                                        completed:(nonnull SDInternalCompletionBlock)completedBlock {
    // 断言：如果没有提供完成回调，那么调用此方法是没有意义的
    NSAssert(completedBlock != nil, @"If you mean to prefetch the image, use -[SDWebImagePrefetcher prefetchURLs] instead");

    // 很常见的错误是传入 NSString 对象而不是 NSURL 对象作为 URL。由于某些奇怪的原因，Xcode 不会对此类型不匹配抛出任何警告。
        // 这里通过允许将 NSString 传递为 URL 来防止此类错误。
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }

    // 防止由于参数类型错误（例如传递 NSNull 而不是 NSURL）导致的应用崩溃
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }

    SDWebImageCombinedOperation *operation = [SDWebImageCombinedOperation new];  // 创建一个新的 SDWebImageCombinedOperation 对象，用于管理加载操作
    operation.manager = self; // 将当前的 SDWebImageManager 实例赋给 operation 的 manager 属性

    BOOL isFailedUrl = NO; // 初始化标志，表示 URL 是否在失败列表中
    if (url) { // 如果 URL 存在
        SD_LOCK(self.failedURLsLock); // 加锁，确保在多线程环境下访问 _failedURLs 是安全的
        isFailedUrl = [self.failedURLs containsObject:url]; // 检查 URL 是否在失败列表中
        SD_UNLOCK(self.failedURLsLock);  // 解锁
    }
    
    // 如果 URL 字符串为空，或者 URL 在失败列表中且未设置 SDWebImageRetryFailed 选项 （检查给定的 URL 是否曾经加载失败过，或者是否被列入“黑名单”。是就报错）
    if (url.absoluteString.length == 0 || (!(options & SDWebImageRetryFailed) && isFailedUrl)) {
        // 根据情况设置错误描述
        NSString *description = isFailedUrl ? @"Image url is blacklisted" : @"Image url is nil";
        // 根据情况设置错误代码
        NSInteger code = isFailedUrl ? SDWebImageErrorBlackListed : SDWebImageErrorInvalidURL;
        // 调用完成回调并传递错误信息
        [self callCompletionBlockForOperation:operation completion:completedBlock error:[NSError errorWithDomain:SDWebImageErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : description}] url:url];
        // 返回 operation，操作结束
        return operation;
    }
    //如果前面URL的错误判断已经结束，那么我们这个时候就获取到了正确的URL，再通过URL获取到其对应的key

    SD_LOCK(self.runningOperationsLock); // 加锁，确保在多线程环境下访问 _runningOperations 是安全的
    [self.runningOperations addObject:operation]; // 将新的 operation 添加到正在运行的操作列表中
    SD_UNLOCK(self.runningOperationsLock); // 解锁
    
    // （这个方法点进去）预处理 options 和 context 参数，以决定最终的加载管理器结果
    SDWebImageOptionsResult *result = [self processedResultForURL:url options:options context:context];
    
    // 开始加载图片，首先从缓存中加载
// 这是核心方法（点进去看）
    [self callCacheProcessForOperation:operation url:url options:result.options context:result.context progress:progressBlock completed:completedBlock];

    return operation;
}

- (void)cancelAll {
    SD_LOCK(self.runningOperationsLock);
    NSSet<SDWebImageCombinedOperation *> *copiedOperations = [self.runningOperations copy];
    SD_UNLOCK(self.runningOperationsLock);
    [copiedOperations makeObjectsPerformSelector:@selector(cancel)]; // This will call `safelyRemoveOperationFromRunning:` and remove from the array
}

- (BOOL)isRunning {
    BOOL isRunning = NO;
    SD_LOCK(self.runningOperationsLock);
    isRunning = (self.runningOperations.count > 0);
    SD_UNLOCK(self.runningOperationsLock);
    return isRunning;
}

- (void)removeFailedURL:(NSURL *)url {
    if (!url) {
        return;
    }
    SD_LOCK(self.failedURLsLock);
    [self.failedURLs removeObject:url];
    SD_UNLOCK(self.failedURLsLock);
}

- (void)removeAllFailedURLs {
    SD_LOCK(self.failedURLsLock);
    [self.failedURLs removeAllObjects];
    SD_UNLOCK(self.failedURLsLock);
}

#pragma mark - Private

//核心代码三
//这段代码的主要作用是处理图片加载过程中与缓存相关的操作。它负责查询缓存中是否已经有对应的图片或数据，
//如果有，则可以直接使用缓存中的数据而不需要重新下载。如果缓存中没有找到图片，或者决定不查询缓存，则继续执行下载流程。
// 这是一个实例方法，负责处理图片加载时的缓存查询操作。
- (void)callCacheProcessForOperation:(nonnull SDWebImageCombinedOperation *)operation
                                 url:(nonnull NSURL *)url
                             options:(SDWebImageOptions)options
                             context:(nullable SDWebImageContext *)context
                            progress:(nullable SDImageLoaderProgressBlock)progressBlock
                           completed:(nullable SDInternalCompletionBlock)completedBlock {
    // 获取要使用的图像缓存对象
    id<SDImageCache> imageCache;
    if ([context[SDWebImageContextImageCache] conformsToProtocol:@protocol(SDImageCache)]) { // 如果上下文中指定了自定义的图像缓存对象，并且它符合 SDImageCache 协议
        imageCache = context[SDWebImageContextImageCache]; // 使用上下文中的自定义缓存对象
    } else {
        imageCache = self.imageCache; // 否则使用默认的缓存对象
    }
    
    // 获取要查询的缓存类型
    SDImageCacheType queryCacheType = SDImageCacheTypeAll; // 默认查询所有类型的缓存
    if (context[SDWebImageContextQueryCacheType]) { // 如果上下文中指定了缓存类型
        queryCacheType = [context[SDWebImageContextQueryCacheType] integerValue];  // 使用指定的缓存类型
    }
    
    // 检查是否需要查询缓存
    BOOL shouldQueryCache = !SD_OPTIONS_CONTAINS(options, SDWebImageFromLoaderOnly); // 如果没有设置从加载器直接加载选项（表示只从网络加载），则应该查询缓存
    if (shouldQueryCache) { // 如果需要查询缓存
        NSString *key = [self cacheKeyForURL:url context:context]; // 生成用于缓存查询的 key
        @weakify(operation);
        operation.cacheOperation = [imageCache queryImageForKey:key options:options context:context cacheType:queryCacheType completion:^(UIImage * _Nullable cachedImage, NSData * _Nullable cachedData, SDImageCacheType cacheType) { // 异步查询缓存
            @strongify(operation); // 在 block 内部恢复强引用，确保 operation 在此范围内不会被释放
            if (!operation || operation.isCancelled) { // 如果 operation 已经被取消
                // 图片加载操作被用户取消
                [self callCompletionBlockForOperation:operation completion:completedBlock error:[NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorCancelled userInfo:@{NSLocalizedDescriptionKey : @"Operation cancelled by user during querying the cache"}] url:url]; // 调用完成回调并传递取消错误信息
                [self safelyRemoveOperationFromRunning:operation]; // 从运行中的操作列表中安全移除当前操作
                return;
            } else if (context[SDWebImageContextImageTransformer] && !cachedImage) { // 如果指定了图像转换器并且缓存中没有图像
                // 有机会查询原始缓存而不是直接下载
                [self callOriginalCacheProcessForOperation:operation url:url options:options context:context progress:progressBlock completed:completedBlock]; // 调用原始缓存处理流程
                return;
            }
            
            // 继续下载流程
            [self callDownloadProcessForOperation:operation url:url options:options context:context cachedImage:cachedImage cachedData:cachedData cacheType:cacheType progress:progressBlock completed:completedBlock]; // 如果缓存中有图像或数据，继续下载流程
        }];
    } else {// 如果不查询缓存
        // 继续下载流程
        [self callDownloadProcessForOperation:operation url:url options:options context:context cachedImage:nil cachedData:nil cacheType:SDImageCacheTypeNone progress:progressBlock completed:completedBlock]; // 直接跳过缓存，开始下载流程
    }
}

// Query original cache process
- (void)callOriginalCacheProcessForOperation:(nonnull SDWebImageCombinedOperation *)operation
                                         url:(nonnull NSURL *)url
                                     options:(SDWebImageOptions)options
                                     context:(nullable SDWebImageContext *)context
                                    progress:(nullable SDImageLoaderProgressBlock)progressBlock
                                   completed:(nullable SDInternalCompletionBlock)completedBlock {
    // Grab the image cache to use
    id<SDImageCache> imageCache;
    if ([context[SDWebImageContextImageCache] conformsToProtocol:@protocol(SDImageCache)]) {
        imageCache = context[SDWebImageContextImageCache];
    } else {
        imageCache = self.imageCache;
    }
    
    // Get the original query cache type
    SDImageCacheType originalQueryCacheType = SDImageCacheTypeNone;
    if (context[SDWebImageContextOriginalQueryCacheType]) {
        originalQueryCacheType = [context[SDWebImageContextOriginalQueryCacheType] integerValue];
    }
    
    // Check whether we should query original cache
    BOOL shouldQueryOriginalCache = (originalQueryCacheType != SDImageCacheTypeNone);
    if (shouldQueryOriginalCache) {
        // Change originContext to mutable
        SDWebImageMutableContext * __block originContext;
        if (context) {
            originContext = [context mutableCopy];
        } else {
            originContext = [NSMutableDictionary dictionary];
        }
        
        // Disable transformer for cache key generation
        id<SDImageTransformer> transformer = originContext[SDWebImageContextImageTransformer];
        originContext[SDWebImageContextImageTransformer] = [NSNull null];
        
        NSString *key = [self cacheKeyForURL:url context:originContext];
        @weakify(operation);
        operation.cacheOperation = [imageCache queryImageForKey:key options:options context:context cacheType:originalQueryCacheType completion:^(UIImage * _Nullable cachedImage, NSData * _Nullable cachedData, SDImageCacheType cacheType) {
            @strongify(operation);
            if (!operation || operation.isCancelled) {
                // Image combined operation cancelled by user
                [self callCompletionBlockForOperation:operation completion:completedBlock error:[NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorCancelled userInfo:@{NSLocalizedDescriptionKey : @"Operation cancelled by user during querying the cache"}] url:url];
                [self safelyRemoveOperationFromRunning:operation];
                return;
            }
            
            // Add original transformer
            if (transformer) {
                originContext[SDWebImageContextImageTransformer] = transformer;
            }
            
            // Use the store cache process instead of downloading, and ignore .refreshCached option for now
            [self callStoreCacheProcessForOperation:operation url:url options:options context:context downloadedImage:cachedImage downloadedData:cachedData finished:YES progress:progressBlock completed:completedBlock];
            
            [self safelyRemoveOperationFromRunning:operation];
        }];
    } else {
        // Continue download process
        [self callDownloadProcessForOperation:operation url:url options:options context:context cachedImage:nil cachedData:nil cacheType:originalQueryCacheType progress:progressBlock completed:completedBlock];
    }
}

// Download process
//核心方法五（真正开始下载了）
//这段代码是 SDWebImageManager 类的内部方法，用于处理图像下载的实际过程。它会根据传入的 URL、选项、上下文以及缓存状态来决定是否需要从网络下载图像，并处理下载的整个流程。最终，它会通过回调将结果（图像、错误信息等）返回给调用方。
- (void)callDownloadProcessForOperation:(nonnull SDWebImageCombinedOperation *)operation //用于管理和跟踪当前图片加载操作。
                                    url:(nonnull NSURL *)url //是图片资源的地址。
                                options:(SDWebImageOptions)options //控制下载行为的选项。
                                context:(SDWebImageContext *)context //提供了额外的配置信息。
                            cachedImage:(nullable UIImage *)cachedImage //已缓存的图片
                             cachedData:(nullable NSData *)cachedData //已缓存的数据
                              cacheType:(SDImageCacheType)cacheType //指示缓存的类型。
                               progress:(nullable SDImageLoaderProgressBlock)progressBlock //回调用于报告下载进度。
                              completed:(nullable SDInternalCompletionBlock)completedBlock {
    // 获取用于加载图像的图像加载器对象
    id<SDImageLoader> imageLoader;
    if ([context[SDWebImageContextImageLoader] conformsToProtocol:@protocol(SDImageLoader)]) {
        imageLoader = context[SDWebImageContextImageLoader];
    } else {
        imageLoader = self.imageLoader;
    }
    
    // 检查是否应该从网络下载图像
    BOOL shouldDownload = !SD_OPTIONS_CONTAINS(options, SDWebImageFromCacheOnly); // 如果不强制只从缓存加载，则允许下载
    shouldDownload &= (!cachedImage || options & SDWebImageRefreshCached); //如果没有缓存图像，或者设置了刷新缓存选项，则允许下载
    shouldDownload &= (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)] || [self.delegate imageManager:self shouldDownloadImageForURL:url]); // 如果没有代理，或者代理允许下载，则允许下载
    shouldDownload &= [imageLoader canRequestImageForURL:url]; // 如果图像加载器支持请求该 URL，则允许下载
    if (shouldDownload) {
        if (cachedImage && options & SDWebImageRefreshCached) {
            // 如果在缓存中找到了图像并且设置了 SDWebImageRefreshCached 选项，则通知关于缓存图像的情况
            // 并尝试重新下载它，以便 NSURLCache 有机会从服务器刷新。
            [self callCompletionBlockForOperation:operation completion:completedBlock image:cachedImage data:cachedData error:nil cacheType:cacheType finished:YES url:url];
            // 将缓存的图像传递给图像加载器。图像加载器应检查远程图像是否等于缓存的图像。
            SDWebImageMutableContext *mutableContext;
            if (context) {
                mutableContext = [context mutableCopy];
            } else {
                mutableContext = [NSMutableDictionary dictionary];
            }
            mutableContext[SDWebImageContextLoaderCachedImage] = cachedImage; //将缓存的图像添加到上下文中
            context = [mutableContext copy];
        }
        
        @weakify(operation); // 弱引用 operation 以避免循环引用
        operation.loaderOperation = [imageLoader requestImageWithURL:url options:options context:context progress:progressBlock completed:^(UIImage *downloadedImage, NSData *downloadedData, NSError *error, BOOL finished) {
            @strongify(operation); // 在 block 内部使用强引用来确保 operation 不会被提前释放
            if (!operation || operation.isCancelled) {
                // 如果操作已取消，调用完成回调并传递取消错误信息
                [self callCompletionBlockForOperation:operation completion:completedBlock error:[NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorCancelled userInfo:@{NSLocalizedDescriptionKey : @"Operation cancelled by user during sending the request"}] url:url];
            } else if (cachedImage && options & SDWebImageRefreshCached && [error.domain isEqualToString:SDWebImageErrorDomain] && error.code == SDWebImageErrorCacheNotModified) {
                // 如果刷新缓存命中 NSURLCache 缓存，不调用完成回调
            } else if ([error.domain isEqualToString:SDWebImageErrorDomain] && error.code == SDWebImageErrorCancelled) {
                // 在发送请求之前由用户取消的下载操作，不阻止失败的 URL
                [self callCompletionBlockForOperation:operation completion:completedBlock error:error url:url];
            } else if (error) {
                // 如果出现错误，调用完成回调并传递错误信息
                [self callCompletionBlockForOperation:operation completion:completedBlock error:error url:url];
                BOOL shouldBlockFailedURL = [self shouldBlockFailedURLWithURL:url error:error options:options context:context];
                
                if (shouldBlockFailedURL) {
                    SD_LOCK(self.failedURLsLock);
                    [self.failedURLs addObject:url]; // 将 URL 添加到失败的 URL 列表中
                    SD_UNLOCK(self.failedURLsLock);
                }
            } else {
                if ((options & SDWebImageRetryFailed)) {
                    SD_LOCK(self.failedURLsLock);
                    [self.failedURLs removeObject:url]; // 从失败的 URL 列表中移除该 URL
                    SD_UNLOCK(self.failedURLsLock);
                }
                // 继续存储缓存过程
                [self callStoreCacheProcessForOperation:operation url:url options:options context:context downloadedImage:downloadedImage downloadedData:downloadedData finished:finished progress:progressBlock completed:completedBlock];
            }
            // 如果操作已完成，从运行中的操作列表中安全移除该操作
            if (finished) {
                [self safelyRemoveOperationFromRunning:operation];
            }
        }];
    } else if (cachedImage) { //存在缓存图片
        // 如果不应该下载且缓存中已有图像，则直接调用完成回调并返回缓存图像
        [self callCompletionBlockForOperation:operation completion:completedBlock image:cachedImage data:cachedData error:nil cacheType:cacheType finished:YES url:url];
        //删去当前的的下载操作（线程安全）
        [self safelyRemoveOperationFromRunning:operation];
    } else {//没有缓存的图片，而且下载被代理终止了
        // 如果缓存中没有图像且代理不允许下载，调用完成回调并传递 nil 图像
        [self callCompletionBlockForOperation:operation completion:completedBlock image:nil data:nil error:nil cacheType:SDImageCacheTypeNone finished:YES url:url];
        //删去当前的下载操作
        [self safelyRemoveOperationFromRunning:operation];
    }
}

// Store cache process
- (void)callStoreCacheProcessForOperation:(nonnull SDWebImageCombinedOperation *)operation
                                      url:(nonnull NSURL *)url
                                  options:(SDWebImageOptions)options
                                  context:(SDWebImageContext *)context
                          downloadedImage:(nullable UIImage *)downloadedImage
                           downloadedData:(nullable NSData *)downloadedData
                                 finished:(BOOL)finished
                                 progress:(nullable SDImageLoaderProgressBlock)progressBlock
                                completed:(nullable SDInternalCompletionBlock)completedBlock {
    // the target image store cache type
    SDImageCacheType storeCacheType = SDImageCacheTypeAll;
    if (context[SDWebImageContextStoreCacheType]) {
        storeCacheType = [context[SDWebImageContextStoreCacheType] integerValue];
    }
    // the original store image cache type
    SDImageCacheType originalStoreCacheType = SDImageCacheTypeNone;
    if (context[SDWebImageContextOriginalStoreCacheType]) {
        originalStoreCacheType = [context[SDWebImageContextOriginalStoreCacheType] integerValue];
    }
    // origin cache key
    SDWebImageMutableContext *originContext = [context mutableCopy];
    // disable transformer for cache key generation
    originContext[SDWebImageContextImageTransformer] = [NSNull null];
    NSString *key = [self cacheKeyForURL:url context:originContext];
    id<SDImageTransformer> transformer = context[SDWebImageContextImageTransformer];
    if (![transformer conformsToProtocol:@protocol(SDImageTransformer)]) {
        transformer = nil;
    }
    id<SDWebImageCacheSerializer> cacheSerializer = context[SDWebImageContextCacheSerializer];
    
    BOOL shouldTransformImage = downloadedImage && transformer;
    shouldTransformImage = shouldTransformImage && (!downloadedImage.sd_isAnimated || (options & SDWebImageTransformAnimatedImage));
    shouldTransformImage = shouldTransformImage && (!downloadedImage.sd_isVector || (options & SDWebImageTransformVectorImage));
    BOOL shouldCacheOriginal = downloadedImage && finished;
    
    // if available, store original image to cache
    if (shouldCacheOriginal) {
        // normally use the store cache type, but if target image is transformed, use original store cache type instead
        SDImageCacheType targetStoreCacheType = shouldTransformImage ? originalStoreCacheType : storeCacheType;
        if (cacheSerializer && (targetStoreCacheType == SDImageCacheTypeDisk || targetStoreCacheType == SDImageCacheTypeAll)) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                @autoreleasepool {
                    NSData *cacheData = [cacheSerializer cacheDataWithImage:downloadedImage originalData:downloadedData imageURL:url];
                    [self storeImage:downloadedImage imageData:cacheData forKey:key cacheType:targetStoreCacheType options:options context:context completion:^{
                        // Continue transform process
                        [self callTransformProcessForOperation:operation url:url options:options context:context originalImage:downloadedImage originalData:downloadedData finished:finished progress:progressBlock completed:completedBlock];
                    }];
                }
            });
        } else {
            [self storeImage:downloadedImage imageData:downloadedData forKey:key cacheType:targetStoreCacheType options:options context:context completion:^{
                // Continue transform process
                [self callTransformProcessForOperation:operation url:url options:options context:context originalImage:downloadedImage originalData:downloadedData finished:finished progress:progressBlock completed:completedBlock];
            }];
        }
    } else {
        // Continue transform process
        [self callTransformProcessForOperation:operation url:url options:options context:context originalImage:downloadedImage originalData:downloadedData finished:finished progress:progressBlock completed:completedBlock];
    }
}

// Transform process
- (void)callTransformProcessForOperation:(nonnull SDWebImageCombinedOperation *)operation
                                     url:(nonnull NSURL *)url
                                 options:(SDWebImageOptions)options
                                 context:(SDWebImageContext *)context
                           originalImage:(nullable UIImage *)originalImage
                            originalData:(nullable NSData *)originalData
                                finished:(BOOL)finished
                                progress:(nullable SDImageLoaderProgressBlock)progressBlock
                               completed:(nullable SDInternalCompletionBlock)completedBlock {
    // the target image store cache type
    SDImageCacheType storeCacheType = SDImageCacheTypeAll;
    if (context[SDWebImageContextStoreCacheType]) {
        storeCacheType = [context[SDWebImageContextStoreCacheType] integerValue];
    }
    // transformed cache key
    NSString *key = [self cacheKeyForURL:url context:context];
    id<SDImageTransformer> transformer = context[SDWebImageContextImageTransformer];
    if (![transformer conformsToProtocol:@protocol(SDImageTransformer)]) {
        transformer = nil;
    }
    id<SDWebImageCacheSerializer> cacheSerializer = context[SDWebImageContextCacheSerializer];
    
    BOOL shouldTransformImage = originalImage && transformer;
    shouldTransformImage = shouldTransformImage && (!originalImage.sd_isAnimated || (options & SDWebImageTransformAnimatedImage));
    shouldTransformImage = shouldTransformImage && (!originalImage.sd_isVector || (options & SDWebImageTransformVectorImage));
    // if available, store transformed image to cache
    if (shouldTransformImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            @autoreleasepool {
                UIImage *transformedImage = [transformer transformedImageWithImage:originalImage forKey:key];
                if (transformedImage && finished) {
                    BOOL imageWasTransformed = ![transformedImage isEqual:originalImage];
                    NSData *cacheData;
                    // pass nil if the image was transformed, so we can recalculate the data from the image
                    if (cacheSerializer && (storeCacheType == SDImageCacheTypeDisk || storeCacheType == SDImageCacheTypeAll)) {
                        cacheData = [cacheSerializer cacheDataWithImage:transformedImage originalData:(imageWasTransformed ? nil : originalData) imageURL:url];
                    } else {
                        cacheData = (imageWasTransformed ? nil : originalData);
                    }
                    [self storeImage:transformedImage imageData:cacheData forKey:key cacheType:storeCacheType options:options context:context completion:^{
                        [self callCompletionBlockForOperation:operation completion:completedBlock image:transformedImage data:originalData error:nil cacheType:SDImageCacheTypeNone finished:finished url:url];
                    }];
                } else {
                    [self callCompletionBlockForOperation:operation completion:completedBlock image:transformedImage data:originalData error:nil cacheType:SDImageCacheTypeNone finished:finished url:url];
                }
            }
        });
    } else {
        [self callCompletionBlockForOperation:operation completion:completedBlock image:originalImage data:originalData error:nil cacheType:SDImageCacheTypeNone finished:finished url:url];
    }
}

#pragma mark - Helper

- (void)safelyRemoveOperationFromRunning:(nullable SDWebImageCombinedOperation*)operation {
    if (!operation) {
        return;
    }
    SD_LOCK(self.runningOperationsLock);
    [self.runningOperations removeObject:operation];
    SD_UNLOCK(self.runningOperationsLock);
}

- (void)storeImage:(nullable UIImage *)image
         imageData:(nullable NSData *)data
            forKey:(nullable NSString *)key
         cacheType:(SDImageCacheType)cacheType
           options:(SDWebImageOptions)options
           context:(nullable SDWebImageContext *)context
        completion:(nullable SDWebImageNoParamsBlock)completion {
    id<SDImageCache> imageCache;
    if ([context[SDWebImageContextImageCache] conformsToProtocol:@protocol(SDImageCache)]) {
        imageCache = context[SDWebImageContextImageCache];
    } else {
        imageCache = self.imageCache;
    }
    BOOL waitStoreCache = SD_OPTIONS_CONTAINS(options, SDWebImageWaitStoreCache);
    // Check whether we should wait the store cache finished. If not, callback immediately
    [imageCache storeImage:image imageData:data forKey:key cacheType:cacheType completion:^{
        if (waitStoreCache) {
            if (completion) {
                completion();
            }
        }
    }];
    if (!waitStoreCache) {
        if (completion) {
            completion();
        }
    }
}

- (void)callCompletionBlockForOperation:(nullable SDWebImageCombinedOperation*)operation
                             completion:(nullable SDInternalCompletionBlock)completionBlock
                                  error:(nullable NSError *)error
                                    url:(nullable NSURL *)url {
    [self callCompletionBlockForOperation:operation completion:completionBlock image:nil data:nil error:error cacheType:SDImageCacheTypeNone finished:YES url:url];
}

- (void)callCompletionBlockForOperation:(nullable SDWebImageCombinedOperation*)operation
                             completion:(nullable SDInternalCompletionBlock)completionBlock
                                  image:(nullable UIImage *)image
                                   data:(nullable NSData *)data
                                  error:(nullable NSError *)error
                              cacheType:(SDImageCacheType)cacheType
                               finished:(BOOL)finished
                                    url:(nullable NSURL *)url {
    dispatch_main_async_safe(^{
        if (completionBlock) {
            completionBlock(image, data, error, cacheType, finished, url);
        }
    });
}

- (BOOL)shouldBlockFailedURLWithURL:(nonnull NSURL *)url
                              error:(nonnull NSError *)error
                            options:(SDWebImageOptions)options
                            context:(nullable SDWebImageContext *)context {
    id<SDImageLoader> imageLoader;
    if ([context[SDWebImageContextImageLoader] conformsToProtocol:@protocol(SDImageLoader)]) {
        imageLoader = context[SDWebImageContextImageLoader];
    } else {
        imageLoader = self.imageLoader;
    }
    // Check whether we should block failed url
    BOOL shouldBlockFailedURL;
    if ([self.delegate respondsToSelector:@selector(imageManager:shouldBlockFailedURL:withError:)]) {
        shouldBlockFailedURL = [self.delegate imageManager:self shouldBlockFailedURL:url withError:error];
    } else {
        shouldBlockFailedURL = [imageLoader shouldBlockFailedURLWithURL:url error:error];
    }
    
    return shouldBlockFailedURL;
}

//重点方法
//它主要的作用是根据传入的 URL、选项和上下文，生成一个最终的选项结果 SDWebImageOptionsResult，这个结果包含了用于控制图片加载行为的所有配置。这种设计允许 SDWebImage 在处理图片加载时具备高度的灵活性。
- (SDWebImageOptionsResult *)processedResultForURL:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context {
    // 定义一个变量 `result`，用于存储最终的选项处理结果
    SDWebImageOptionsResult *result;
    // 创建一个可变的上下文字典 `mutableContext`，用于存储上下文的变更
    SDWebImageMutableContext *mutableContext = [SDWebImageMutableContext dictionary];
    
    // 如果上下文中没有指定图像转换器，则从管理器中获取默认的图像转换器并设置到上下文中
    if (!context[SDWebImageContextImageTransformer]) {
        id<SDImageTransformer> transformer = self.transformer;
        [mutableContext setValue:transformer forKey:SDWebImageContextImageTransformer];
    }
    // 如果上下文中没有指定缓存键过滤器，则从管理器中获取默认的缓存键过滤器并设置到上下文中
    if (!context[SDWebImageContextCacheKeyFilter]) {
        id<SDWebImageCacheKeyFilter> cacheKeyFilter = self.cacheKeyFilter;
        [mutableContext setValue:cacheKeyFilter forKey:SDWebImageContextCacheKeyFilter];
    }
    // 如果上下文中没有指定缓存序列化器，则从管理器中获取默认的缓存序列化器并设置到上下文中
    if (!context[SDWebImageContextCacheSerializer]) {
        id<SDWebImageCacheSerializer> cacheSerializer = self.cacheSerializer;
        [mutableContext setValue:cacheSerializer forKey:SDWebImageContextCacheSerializer];
    }
    //合并到context
    if (mutableContext.count > 0) {
        if (context) {
            [mutableContext addEntriesFromDictionary:context]; // 将传入的 `context` 内容添加到 `mutableContext` 中
        }
        context = [mutableContext copy]; // 将合并后的 `mutableContext` 复制为不可变的上下文
    }
    
    // 如果存在选项处理器，则通过选项处理器处理 URL、选项和上下文，获取最终的 `result`
    if (self.optionsProcessor) {
        result = [self.optionsProcessor processedResultForURL:url options:options context:context];
    }
    // 如果 `result` 为空，使用默认的选项结果（使用传入的选项和上下文初始化）
    if (!result) {
        // Use default options result
        result = [[SDWebImageOptionsResult alloc] initWithOptions:options context:context];
    }
    // 返回最终的处理结果
    return result;
}

@end


@implementation SDWebImageCombinedOperation

- (void)cancel {
    @synchronized(self) {
        if (self.isCancelled) {
            return;
        }
        self.cancelled = YES;
        if (self.cacheOperation) {
            [self.cacheOperation cancel];
            self.cacheOperation = nil;
        }
        if (self.loaderOperation) {
            [self.loaderOperation cancel];
            self.loaderOperation = nil;
        }
        [self.manager safelyRemoveOperationFromRunning:self];
    }
}

@end
