//
//  RegisterViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@protocol RegistrationDelegate <NSObject>

- (void)transmissionAccount:(UITextField*)account andPassword:(UITextField*)password;

@end

@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) id<RegistrationDelegate>delegate;
@property (nonatomic, strong) UITextField *accountText;
@property (nonatomic, strong) UITextField *passwordText;
@property (nonatomic, strong) UITextField *confirmText;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *backButton;

@end

NS_ASSUME_NONNULL_END

//在这边定义协议，并调用协议方法
