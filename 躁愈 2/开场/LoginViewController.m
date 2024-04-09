//
//  LoginViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/28.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "Manager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
#pragma mark 返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"fanhui_zhihu.png"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@65);
        make.left.equalTo(@20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.topic = [[UILabel alloc] init];
    _topic.frame = CGRectMake(60, 100, self.view.frame.size.width - 120, 80);
    _topic.text = @"手机登录";
    [self.view addSubview:_topic];
    _topic.font = [UIFont systemFontOfSize:40];
    
    self.subTopic = [[UILabel alloc] init];
    _subTopic.frame = CGRectMake(60, 150, self.view.frame.size.width - 120, 80);
    _subTopic.text = @"未注册绑定的手机号将自动注册";
    _subTopic.font = [UIFont systemFontOfSize:15];
    _subTopic.textColor = [UIColor grayColor];
    [self.view addSubview:_subTopic];
    
    //文本框
    self.textField1 = [[UITextField alloc]init];
    self.textField1.frame = CGRectMake(60, 260, 280, 55);
    self.textField1.placeholder = @" 请输入手机号";
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    // 设置文本框的圆角
    self.textField1.layer.cornerRadius = 10;
    self.textField1.layer.masksToBounds = YES;
    self.textField1.backgroundColor = [UIColor whiteColor];  // 设置背景颜色
    self.textField1.layer.borderColor = [UIColor grayColor].CGColor;  // 设置边框颜色
    self.textField1.layer.borderWidth = 1.0;  // 设置边框宽度
    [self.textField1 becomeFirstResponder];
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = YES;
    self.textField1.delegate = self;
    [self.view addSubview:self.textField1];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.textField2 = [[UITextField alloc]init];
    self.textField2.frame = CGRectMake(60, 325, 130, 55);
    self.textField2.placeholder = @" 六位验证码";
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    // 设置文本框的圆角
    self.textField2.layer.cornerRadius = 10;
    self.textField2.layer.masksToBounds = YES;
    self.textField2.backgroundColor = [UIColor whiteColor];  // 设置背景颜色
    self.textField2.layer.borderColor = [UIColor grayColor].CGColor;  // 设置边框颜色
    self.textField2.layer.borderWidth = 1.0;  // 设置边框宽度
    [self.textField2 becomeFirstResponder];
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = YES;
    self.textField2.delegate = self;
    [self.view addSubview:self.textField2];
        //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];}
    
#pragma mark 注册按钮
    self.verifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyBtn.layer.cornerRadius = 10;
    _verifyBtn.frame = CGRectMake(210, 325, 130, 55);
    _verifyBtn.layer.borderColor = [UIColor grayColor].CGColor;  // 设置边框颜色
    _verifyBtn.layer.borderWidth = 1.0;  // 设置边框宽度
    [self.view addSubview:_verifyBtn];
    
    // 启用按钮的点击事件处理
    [_verifyBtn addTarget:self action:@selector(registeAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark 登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 10;
    _loginBtn.frame = CGRectMake(60, 390, 280, 55);
    _loginBtn.layer.borderColor = [UIColor grayColor].CGColor;  // 设置边框颜色
    _loginBtn.layer.borderWidth = 1.0;  // 设置边框宽度
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(secondLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark 登录失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failToLog) name:@"failToLog" object:nil];

}

- (void)failToLog {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)registeAction:(UIButton *)sender {
    // 禁用按钮防止重复点击
    sender.enabled = NO;
    sender.alpha = 0.5; // 可选，设置按钮为半透明以表示不可用状态
    __block NSInteger remainingSeconds = 60; // 剩余秒数
    [sender setTitle:@"重新验证 (60)" forState:UIControlStateDisabled];
    [[Manager shareManager] NetWorkGetVerifyWithData:^(NSString * _Nonnull verify) {
            NSLog(@"%@", verify);
        } andError:^(NSError * _Nullable error) {
            NSLog(@"Error: %@", error);
        } andPhoneNumber:self.textField1.text];
    
    // 使用NSTimer创建一个每秒触发一次的计时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (remainingSeconds == 0) {
            [timer invalidate]; // 停止计时器
            sender.enabled = YES; // 重新启用按钮
            sender.alpha = 1.0; // 可选，恢复按钮的不透明度
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
        } else {
            remainingSeconds--;
            NSString *title = [NSString stringWithFormat:@"重新验证 (%ld)", (long)remainingSeconds];
            [sender setTitle:title forState:UIControlStateDisabled];
        }
    }];

    // 将计时器添加到当前的运行循环中
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)secondLoginBtn {
    [[Manager shareManager] NetWorkGetLoginWithData:^(NSString * _Nonnull success) {
        if ([success isEqualToString:@"ok"]) {
            // 请求成功，跳转到下一个页面
            dispatch_async(dispatch_get_main_queue(), ^{
                [self saveTokenToUserDefaults:self.textField1.text];
#pragma 将token加到数据库中
                [self createDataBase];
                [self insertDataBase];
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToHome" object:nil];
            });
        } else {
            
        }
        } andError:^(NSError * _Nullable error) {
            // 请求成功但返回的不是预期值，弹出错误提示
        } andPhoneNumber:self.textField1.text andVerifyNumber:self.textField2.text];
}

- (void)pressBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 存储token到NSUserDefalut
- (void)saveTokenToUserDefaults:(NSString *)token {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"UserToken"];
    [defaults synchronize];
}

- (void)createDataBase {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"tokenDataBase.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];
    if ([_dataBase open]) {
        BOOL result = [_dataBase executeUpdate:@"CREATE TABLE 't_tokenDataBase' ('token' TEXT)"];
        if (result) {
            NSLog(@"创表成功");
        }
        NSLog(@"Open database Success");
    } else {
        NSLog(@"fail to open database");
    }
    [_dataBase close];
}

- (void)insertDataBase {
    if ([_dataBase open]) {
        NSString *insertSql = @"insert into 't_tokenDataBase'(token) values(?)";
        BOOL result = [_dataBase executeUpdate:insertSql, self.textField1.text];
        if (result) {
            NSLog(@"添加数据成功");
        } else {
            NSLog(@"添加数据失败");
        }
    }
    [_dataBase close];
}

@end
