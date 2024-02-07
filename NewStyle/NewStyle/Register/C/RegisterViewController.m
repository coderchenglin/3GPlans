//
//  RegisterViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/2/6.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController () <RegisterButtonDelegate>

@property (nonatomic, strong) RegisterView *registerView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerView = [[RegisterView alloc] initWithFrame:self.view.frame];
    [self.registerView viewInit];
    self.registerView.registerButtonDelegate = self;
    [self.view addSubview:self.registerView];
    // Do any additional setup after loading the view.
}

- (void)getButton:(UIButton *)button {
    if (button.tag == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
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
