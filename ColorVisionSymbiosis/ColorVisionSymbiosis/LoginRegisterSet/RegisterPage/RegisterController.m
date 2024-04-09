//
//  RegisterController.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [[Manager alloc] init];
    
    self.registerView = [[RegisterView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: self.registerView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmRegister:) name: @"ConfirmRegister" object: nil];
    
}

- (void)confirmRegister: (NSNotification *)notification {
    NSLog(@"%@ %@ %@", notification.userInfo[@"phone"], notification.userInfo[@"password"], notification.userInfo[@"confirmPassword"]);
    NSString* phone = notification.userInfo[@"phone"];
    NSString* password = notification.userInfo[@"password"];
    NSString* repassword = notification.userInfo[@"confirmPassword"];
    
    if ([phone isEqualToString: @""] || [password isEqualToString: @""] || [repassword isEqualToString: @""]) {
        NSLog(@"请输入账号或密码");
    } else {
        [self.manager requestRegisterInfoWithPhone: notification.userInfo[@"phone"] Password: notification.userInfo[@"password"] andConfirmPassword: notification.userInfo[@"confirmPassword"] success:^(RegisterModel * _Nonnull registerModel) {
            NSDictionary* requestResult = [registerModel toDictionary];
            NSLog(@"%@ = %@", requestResult, requestResult[@"message"]);
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
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
