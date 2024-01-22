//
//  LoginViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "LoginViewController.h"
#import "LoginView.h"


@interface LoginViewController ()
@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    //self.loginView.loginButtonDelegate = self;
    
    [self.view addSubview:self.loginView];
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
