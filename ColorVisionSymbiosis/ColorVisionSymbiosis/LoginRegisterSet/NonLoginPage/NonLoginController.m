//
//  NonLoginController.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "NonLoginController.h"
#import "LoginController.h"
#import "RegisterController.h"

@interface NonLoginController ()

@end

@implementation NonLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nonLoginView = [[NonLoginView alloc] initWithFrame: self.view.bounds];
    
    [self.view addSubview: self.nonLoginView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressLogin) name: @"Login" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressRegister) name: @"Register" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressLoginByCode) name: @"LoginByCode" object: nil];

}

- (void)pressLogin {
    LoginController* loginController  = [[LoginController alloc] init];
    [self presentViewController: loginController animated: YES completion: nil];
//    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)pressRegister {
    RegisterController* registerController = [[RegisterController alloc] init];
    [self presentViewController: registerController animated: YES completion: nil];
}

//- (void)pressLoginByCode {
//    NSLog(@"pressLoginCode");
//    LoginByCodeController* loginByCodeController = [[LoginByCodeController alloc] init];
//    loginByCodeController.modalPresentationStyle = 8;
//    [self presentViewController: loginByCodeController animated: YES completion: nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
