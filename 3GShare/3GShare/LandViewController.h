//
//  LandViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/4.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "FifthViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface LandViewController : UIViewController<UITextFieldDelegate, RegistrationDelegate>

@property (nonatomic, strong) UITextField *accountText;
@property (nonatomic, strong) UITextField *passwordText;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *resignButton;
@property (nonatomic, strong) UITextField *transAccount;
@property (nonatomic, strong) UITextField *transPassword;

- (void)LoadingInterface;
- (void)RegistrationInterface;
//- (void)transmissionAccount:(UITextField*)account andPassword:(UITextField*)password;

@end

NS_ASSUME_NONNULL_END

//RegisterViewController 传值给 LandViewController
//           A                         B
//A定义一个协议，并声明一个代理属性
//对象B遵循协议，并实现协议里的方法
//再对象B种，将自己作为对象A的代理
//对象A中调用代理方法，也就是让B对象执行代理方法
//对象B实现代理方法
