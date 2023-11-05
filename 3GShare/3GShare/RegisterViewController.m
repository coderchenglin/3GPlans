//
//  RegisterViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *backImage = [UIImage imageNamed:@"kaiji1.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    backImageView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:backImageView];
    
    UIImage *logoImage = [UIImage imageNamed:@"login_logo.png"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.frame = CGRectMake(115, 100, 200, 200);
    [backImageView addSubview:logoImageView];
    
    UIImage *actionImage = [UIImage imageNamed:@"actionbar.png"];
    UIImageView *actionImageView = [[UIImageView alloc] initWithImage:actionImage];
    actionImageView.frame = CGRectMake(-300, 300, 1000, 100);
    [backImageView addSubview:actionImageView];
    
    _accountText = [[UITextField alloc] init];
    _passwordText = [[UITextField alloc] init];
    _confirmText = [[UITextField alloc] init];
    [self.view addSubview:_accountText];
    [self.view addSubview:_passwordText];
    [self.view addSubview:_confirmText];
    _accountText.frame = CGRectMake(100, 404, 250, 50);
    _passwordText.frame = CGRectMake(100, 474, 250, 50);
    _confirmText.frame = CGRectMake(100, 544, 250, 50);
    _accountText.keyboardType = UIKeyboardTypeDefault;
    _accountText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.keyboardType = UIKeyboardTypeDefault;
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _confirmText.keyboardType = UIKeyboardTypeDefault;
    _confirmText.borderStyle = UITextBorderStyleRoundedRect;
    _accountText.delegate = self;
    _passwordText.delegate  = self;
    _confirmText.delegate = self;
    _passwordText.secureTextEntry = YES;
    _confirmText.secureTextEntry = YES;
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:_confirmButton];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,1,1,1});
    _confirmButton.layer.borderWidth = 2;
    _confirmButton.layer.borderColor = color;
    [_confirmButton setTitle:@"确认注册" forState:UIControlStateNormal];
    _confirmButton.frame = CGRectMake(160, 620, 100, 50);
    [_confirmButton addTarget:self action:@selector(pressConfirm:) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.titleLabel.tintColor = [UIColor whiteColor];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:22];
    _confirmButton.layer.masksToBounds = YES;
    _confirmButton.layer.cornerRadius = 5.0;
    
    UIImage *accountImage = [UIImage imageNamed:@"user_img.png"];
    UIImage *passwordImage = [UIImage imageNamed:@"pass_img.png"];
    UIImage *confirmImage = [UIImage imageNamed:@"pass_img.png"];
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:accountImage];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:passwordImage];
    UIImageView *confirmImageView = [[UIImageView alloc] initWithImage:confirmImage];
    
    accountImageView.frame = CGRectMake(50, 404, 50, 50);
    passwordImageView.frame = CGRectMake(50, 474, 50, 50);
    confirmImageView.frame = CGRectMake(50, 544, 50, 50);
    accountImageView.backgroundColor = [UIColor whiteColor];
    passwordImageView.backgroundColor = [UIColor whiteColor];
    confirmImageView.backgroundColor = [UIColor whiteColor];
    [backImageView addSubview:accountImageView];
    [backImageView addSubview:passwordImageView];
    [backImageView addSubview:confirmImageView];
    accountImageView.layer.masksToBounds = YES;
    accountImageView.layer.cornerRadius = 5.0;
    passwordImageView.layer.masksToBounds = YES;
    passwordImageView.layer.cornerRadius = 5.0;
    confirmImageView.layer.masksToBounds = YES;
    confirmImageView.layer.cornerRadius = 5.0;
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    _backButton.frame = CGRectMake(20, 50, 50, 50);
    
    [self.view addSubview:_backButton];
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressConfirm:(UIButton*)button {
    if([_accountText.text isEqualToString:@""] || [_passwordText.text isEqualToString:@""]) {
        UIAlertController *tipView = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码格式错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [tipView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:tipView animated:YES completion:nil];
    }
    
    if([_passwordText.text isEqualToString:_confirmText.text]) {
        UIAlertController *tipView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        [tipView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:tipView animated:YES completion:nil];
        [self.delegate transmissionAccount:_accountText andPassword:_passwordText];
    } else {
        UIAlertController *warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"两次输入密码不一致" preferredStyle:UIAlertControllerStyleAlert];
        [warning addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:warning animated:YES completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -50, width, height);
    }];
    [UIView setAnimationsEnabled:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, width, height);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_accountText resignFirstResponder];
    [_passwordText resignFirstResponder];
    [_confirmText resignFirstResponder];
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
