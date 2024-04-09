//
//  Manager.h
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PhotoFixModel.h"

typedef void (^PhotoFixBlock)(PhotoFixModel *_Nonnull mainModel);

typedef void (^ErrorBlock)(NSError *_Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

+ (instancetype)sharedManage;
//图片处理
- (void)firstNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)secondNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)thirdNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)fourNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)fiveNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)sixNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;
- (void)sevenNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image;



@end

NS_ASSUME_NONNULL_END
