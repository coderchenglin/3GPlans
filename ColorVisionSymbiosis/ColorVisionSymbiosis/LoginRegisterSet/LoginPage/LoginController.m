//
//  LoginController.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [Manager sharedManager];
    
    self.loginView = [[LoginView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: self.loginView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmLogin:) name: @"ConfirmLogin" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(wayOfLogin:) name: @"WayOfLogin" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(getCodeAndStartCountdown:) name: @"GetCodeAndStartCountdown" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmLoginByCode:) name: @"ConfirmLoginByCode" object: nil];
    
}

#pragma mark 确认登录
- (void)confirmLogin: (NSNotification *)notification {
//    NSLog(@"%@ %@", notification.userInfo[@"phone"], notification.userInfo[@"password"]);
    NSString* phone = notification.userInfo[@"phone"];
    NSString* password = notification.userInfo[@"password"];
    
    if ([phone isEqualToString: @""] || [password isEqualToString: @""]) {
        NSLog(@"请输入手机号或密码");
    } else {
        [self.manager requestLoginInfoWithPhone: notification.userInfo[@"phone"] andPassword: notification.userInfo[@"password"] success:^(LoginModel * _Nonnull loginModel) {
            NSDictionary* requestResult = [loginModel toDictionary];
            NSLog(@"%@ = %@", requestResult, requestResult[@"message"]);
            NSString* resultString = requestResult[@"message"];
            if ([resultString isEqualToString: @"欢迎回来"]) {
//                UIViewController* vc =
//                [self.navigationController pushViewController:  animated: YES];
            } else {
                //Alert
            }
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
    }
}

- (void)confirmLoginByCode: (NSNotification *)notification {
    NSString* phone = notification.userInfo[@"phone"];
    NSString* code = notification.userInfo[@"code"];
    
    if ([phone isEqualToString: @""] || [code isEqualToString: @""]) {
        NSLog(@"请输入手机号或验证码");
    } else {
        [self.manager requestLoginByCodeInfoWithPhone: phone andCode: code success:^(LoginByCodeModel * _Nonnull loginByCodeModel) {
            NSDictionary* requestResult = [loginByCodeModel toDictionary];
            NSString* resultString = requestResult[@"message"];
            
            NSLog(@"%@", requestResult[@"message"]);
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
    }
}

#pragma mark 切换登录方式
- (void)wayOfLogin: (NSNotification *)notification {
    UIButton* button = notification.object;
//    NSLog(@"%ld", button.tag);
    if (button.tag == 101) {
        button.tag = 102;
        [button setTitle: @"用密码登录" forState: UIControlStateNormal];
        [self.loginView WayOfLoginingByCode];
    } else if (button.tag == 102) {
        button.tag = 101;
        [button setTitle: @"验证码登录" forState: UIControlStateNormal];
        [self.loginView WayOfLoginingByPassword];
    }
}

#pragma mark 倒计时
NSTimer* countdownTimer;
NSInteger countdownTime = 60;

- (void)getCodeAndStartCountdown: (NSNotification *)notification {
    NSLog(@"%@", notification.userInfo[@"phoneByCode"]);
    
    NSString* phone = notification.userInfo[@"phoneByCode"];
    
    if (!countdownTimer) {
        if ([phone isEqualToString: @""]) {
            NSLog(@"请输入手机号");
        } else {
            [self.manager requestCodeInfoWithPhone:phone success:^(CodeModel * _Nonnull codeModel) {
                NSDictionary* requestResult = [codeModel toDictionary];
                NSString* resultString = requestResult[@"message"];
                if ([resultString isEqualToString: @"手机号码无效"]) {
                    NSLog(@"手机号码无效");
                } else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.loginView.getCodeButton.enabled = NO;
                        [self.loginView.getCodeButton setTitle: @"60秒后重试" forState: UIControlStateDisabled];
                        countdownTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(updateCountdown) userInfo: nil repeats: YES];
                    });
                }
                NSLog(@"%@", requestResult[@"message"]);
            } failure:^(NSError * _Nonnull error) {
                if (error) NSLog(@"网络连接失败");
            }];
        }
    }
    
}

- (void)updateCountdown {
    countdownTime--;
    if (!countdownTime) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        countdownTime = 60;
        
        self.loginView.getCodeButton.enabled = YES;
        [self.loginView.getCodeButton setTitle: @"获取验证码" forState: UIControlStateNormal];
    } else {
        [self.loginView.getCodeButton setTitle: [NSString stringWithFormat: @"%ld秒后重试", countdownTime] forState: UIControlStateDisabled];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
