//
//  ChangeViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _goodColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    _nameArray = [[NSArray alloc] initWithObjects:@"旧密码", @"新密码", @"确认密码", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(20, 40, 50, 50);
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"修改密码";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _originalLabel = [[UILabel alloc] init];
    _originalLabel.text = @"旧密码";
    _originalLabel.frame = CGRectMake(10, 110, 200, 30);
    [self.view addSubview:_originalLabel];
    _original = [[UITextField alloc] init];
    _original.frame = CGRectMake(100, 110, 350, 30);
    [self.view addSubview:_original];
    _original.secureTextEntry = YES;
    _original.borderStyle = UITextBorderStyleNone;
    _original.keyboardType = UIKeyboardTypeDefault;
    _original.placeholder = @"请输入原密码";
    
    _changeLabel = [[UILabel alloc] init];
    _changeLabel.text = @"新密码";
    _changeLabel.frame = CGRectMake(10, 160, 200, 30);
    [self.view addSubview:_changeLabel];
    _change = [[UITextField alloc] init];
    _change.frame = CGRectMake(100, 160, 350, 30);
    [self.view addSubview:_change];
    _change.secureTextEntry = YES;
    _change.borderStyle = UITextBorderStyleNone;
    _change.keyboardType = UIKeyboardTypeDefault;
    _change.placeholder = @"6-20位英文或数字组合";
    
    _changeAgainLabel = [[UILabel alloc] init];
    _changeAgainLabel.text = @"确认密码";
    _changeAgainLabel.frame = CGRectMake(10, 210, 200, 30);
    [self.view addSubview:_changeAgainLabel];
    _changeAgain = [[UITextField alloc] init];
    _changeAgain.frame = CGRectMake(100, 210, 350, 30);
    [self.view addSubview:_changeAgain];
    _changeAgain.secureTextEntry = YES;
    _changeAgain.borderStyle = UITextBorderStyleNone;
    _changeAgain.keyboardType = UIKeyboardTypeDefault;
    _changeAgain.placeholder = @"再次确认输入的密码";
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _confirmButton.frame = CGRectMake(170, 300, 80, 40);
    [_confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(pressConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];
    _confirmButton.backgroundColor = _goodColor;
    _confirmButton.layer.masksToBounds =YES;
    _confirmButton.layer.cornerRadius = 5.0;
    _confirmButton.titleLabel.tintColor = [UIColor whiteColor];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:20];
}

- (void)pressConfirm:(UIButton*)button {
    if ([_change.text isEqualToString:_changeAgain.text]) {
        UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:tips animated:YES completion:nil];
    } else {
        UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"您输入的两次密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:tips animated:YES completion:nil];
    }
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_original resignFirstResponder];
    [_change resignFirstResponder];
    [_changeAgain resignFirstResponder];
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
