//
//  LoginViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"

@interface LoginViewController () <LoginButtonDelegate>
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) RegisterViewController *registerViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    self.loginView.loginButtonDelegate = self;
    [self.loginView viewInit];
    [self.view addSubview:self.loginView];
}

- (void)getButton:(UIButton *)button {
    if (button.tag == 0) {
        [[UIApplication sharedApplication]performSelector:@selector(suspend)];
    } else if (button.tag == 1) { //登陆
        
    } else if (button.tag == 2) { //注册
        self.registerViewController = [[RegisterViewController alloc] init];
        self.registerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.registerViewController animated:YES completion:nil];
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
