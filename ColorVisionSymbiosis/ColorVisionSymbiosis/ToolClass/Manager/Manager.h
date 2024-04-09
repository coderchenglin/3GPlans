//
//  Manager.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "RegisterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginModelBlock)(LoginModel* loginModel);
typedef void(^RegisterModelBlock)(RegisterModel* registerModel);
typedef void(^CodeModelBlock)(CodeModel* codeModel);
typedef void(^LoginByCodeBlock)(LoginByCodeModel* loginByCodeModel);
typedef void(^ErrorBlock)(NSError* error);

@interface Manager : NSObject

+ (instancetype)sharedManager;

- (void)requestLoginInfoWithPhone: (NSString *)phone andPassword: (NSString *)password success: (LoginModelBlock)sucess failure: (ErrorBlock)failure;

- (void)requestRegisterInfoWithPhone: (NSString *)phone Password: (NSString *)password andConfirmPassword: (NSString *)confirmPassword success: (RegisterModelBlock)success failure: (ErrorBlock)failure;

- (void)requestCodeInfoWithPhone: (NSString *)phone success: (CodeModelBlock)success failure: (ErrorBlock)failure;

- (void)requestLoginByCodeInfoWithPhone: (NSString *)phone andCode: (NSString *)password success: (LoginByCodeBlock)success failure: (ErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
