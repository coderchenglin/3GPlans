//
//  Manager.h
//  EmotionalAnalysis
//
//  Created by 夏楠 on 2024/1/27.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FaceModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^EmotionModelBlock) (EmotionModel *model);
typedef void (^VerifyBlock) (NSString *verify);
typedef void (^LoginBlock) (NSString *success);


typedef void (^ErrorBlock)(NSError * _Nullable error);//返回NSError类型的数据，ErrorBlock是该Block的名字，失败会返回该Block

@interface Manager : NSObject
+ (instancetype)shareManager;
@property (strong, nonatomic)FaceModel *eM;
- (void)NetWorkGetWithData:(EmotionModelBlock)mainModelBolck andError:(ErrorBlock)errorBlock andImage:(UIImage *)image;
- (void)NetWorkGetVerifyWithData:(VerifyBlock)mainModelBolck andError:(ErrorBlock)errorBlock andPhoneNumber:(NSString *)phoneNumber;
- (void)NetWorkGetLoginWithData:(LoginBlock)mainModelBolck andError:(ErrorBlock)errorBlock andPhoneNumber:(NSString *)phoneNumber andVerifyNumber:(NSString *)verifyNumber;
- (NSString *)convertImageToPostableFormat:(UIImage *)image preferredFormat:(NSString *)format quality:(CGFloat)quality ;
- (NSString *)convertImageToPostableFormat2:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
