//
//  LandViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/4.
//

#import "LandViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


@interface LandViewController ()

@end

@implementation LandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _transAccount = [[UITextField alloc] init];
    _transPassword = [[UITextField alloc] init];
    
    UIImage *backImage = [UIImage imageNamed:@"kaiji1.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    backImageView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:backImageView];
    
    //这只账户和密码的图标
    UIImage *userImage = [UIImage imageNamed:@"user_img.png"];
    UIImage *passImage = [UIImage imageNamed:@"pass_img.png"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:userImage];
    UIImageView *passImageView = [[UIImageView alloc] initWithImage:passImage];
    userImageView.backgroundColor = [UIColor whiteColor];
    [userImageView.layer setMasksToBounds:YES];
    //这两种写法一样：
    //[userImageView.layer setCornerRadius:20.0]; //一个是调用属性方法，setXXX
    userImageView.layer.cornerRadius = 20.0;   //一个是直接用点.语法设置属性，一样的
    passImageView.backgroundColor = [UIColor whiteColor];
    [passImageView.layer setMasksToBounds:YES];
    [passImageView.layer setCornerRadius:20.0];
    userImageView.frame = CGRectMake(50, 404, 50, 50);
    passImageView.frame = CGRectMake(50, 474, 50, 50);
    [backImageView addSubview:userImageView];
    [backImageView addSubview:passImageView];
    
    //设置账户和密码的文本输入框
    _accountText = [[UITextField alloc] init];
    _passwordText = [[UITextField alloc] init];
    _accountText.delegate = self;
    _passwordText.delegate = self;
    _accountText.frame = CGRectMake(100, 404, 250, 50);
    _passwordText.frame = CGRectMake(100, 474, 250, 50);
    _accountText.keyboardType = UIKeyboardTypeDefault;
    _passwordText.keyboardType = UIKeyboardTypeDefault;
    _accountText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    //密码的输入被隐藏
    _passwordText.secureTextEntry = YES;
    [self.view addSubview:_accountText];
    [self.view addSubview:_passwordText];
    
    //设置登录注册按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    _loginButton.titleLabel.tintColor = [UIColor whiteColor];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _loginButton.frame = CGRectMake(100, 550, 80, 40);
    [_loginButton addTarget:self action:@selector(pressLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _resignButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_resignButton setTitle:@"注册" forState:UIControlStateNormal];
    _resignButton.titleLabel.tintColor = [UIColor whiteColor];
    _resignButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _resignButton.frame = CGRectMake(220, 550, 80, 40);
    [_resignButton addTarget:self action:@selector(pressResignButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮边界
    //CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,1,1,1});
    
    _loginButton.layer.borderColor = [UIColor whiteColor].CGColor; //设置边框的颜色 //CGColor是UIColor的属性
    _loginButton.layer.cornerRadius = 5.0;  //设置边框的圆弧半径
    _loginButton.layer.borderWidth = 2; //设置边框的宽度
    //[_loginButton.layer setBorderWidth:2]; //同上
    _loginButton.layer.masksToBounds = YES;
    
    _resignButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _resignButton.layer.cornerRadius = 5.0;
    _resignButton.layer.borderWidth = 2;
    _resignButton.layer.masksToBounds = YES;
    
    
    [self.view addSubview:_loginButton];
    [self.view addSubview:_resignButton];

    //看button.layer.masksToBounds这个属性的作用 - 是否裁剪掉圆形边框外的内容
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(50, 100, 200, 200);
//
//    UIImage *image = [UIImage imageNamed:@"kaiji1.png"];
//    [button setImage:image forState:UIControlStateNormal];
//
//    button.layer.cornerRadius = 100; // 将按钮设置为圆形
//    button.layer.masksToBounds = NO; // 设置 masksToBounds 为 YES
//
//    [self.view addSubview:button];

    //设置自动登录按钮
    UIButton *autoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [autoButton setTitle:@"自动登录" forState:UIControlStateNormal];
    autoButton.frame = CGRectMake(80, 605, 120, 40);
    [autoButton addTarget:self action:@selector(autoLogin:) forControlEvents:UIControlEventTouchUpInside];
    autoButton.titleLabel.tintColor = [UIColor blueColor];
    [self.view addSubview:autoButton];
    autoButton.tag = 201;
    
    //设置logo图片
    UIImage* logoImage = [UIImage imageNamed:@"login_logo.png"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.frame = CGRectMake(115, 100, 200, 200);
    [self.view addSubview:logoImageView];
    [backImageView addSubview:logoImageView];
    //NSLog(@"%d",self.view == backImageView);
    
    UIImage *actionImage = [UIImage imageNamed:@"actionbar.png"];
    UIImageView *actionImageView = [[UIImageView alloc] initWithImage:actionImage];
    //actionImageView.frame = CGRectMake(0, 300, width, 80);
    actionImageView.frame = CGRectMake(-300, 300, 1000, 100);
    [backImageView addSubview:actionImageView];
    
    
    
}

- (void)pressLoginButton:(UIButton*)button {
    //自己设的账号密码，方便调试
    //[self LoadingInterface];
    
    if([_accountText.text isEqualToString:@"1"] && [_passwordText.text isEqualToString:@"1"]) {
        [self LoadingInterface];
    } else if ([_transAccount.text isEqualToString:@""] || [_transPassword.text isEqualToString:@""]) {
        UIAlertController *warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"您输入的账号未注册" preferredStyle:UIAlertControllerStyleAlert];
        [warning addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    
    if([_accountText.text isEqualToString:_transAccount.text] && [_passwordText.text isEqualToString:_transPassword.text]) {
        [self LoadingInterface];
    } else {
        UIAlertController *warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号或密码错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [warning addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:warning animated:YES completion:nil];
    }
}

- (void)pressResignButton:(UIButton*)button {
    [self RegistrationInterface];
}

- (void)autoLogin:(UIButton*)button {
    //201表示按钮未被按下 ： 添加一张图片，tag值为101，并将按钮的tag值设为202表示已按下
    if(button.tag == 201) {
        UIImage *image = [UIImage imageNamed:@"my_button_pressed.png"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.tag = 101;
        button.tag = 202;
        imageView.frame = CGRectMake(0, 0, 30, 30);
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:15.0];
        [button addSubview:imageView];
    } else {
        //按钮此时为202，为已按下，所以按下后，将tag值为101的图片删除，并将按钮的tag值变回201
        for (UIImageView *view in button.subviews) {
            if (view.tag == 101) {
                [view removeFromSuperview];
            }
        }
        button.tag = 201;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_accountText resignFirstResponder]; //放弃第一响应者状态，即收回键盘
    [_passwordText resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //这个方法用于创建视图动画效果
    //0.5代表持续时间
    //后面一个代码块表示动画过程执行的动作
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -50, width, height);
    }];
    [UIView setAnimationsEnabled:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:1 animations:^{
            self.view.frame = CGRectMake(0, 0, width, height);
    }];
    [UIView setAnimationsEnabled:YES]; //这句话是不禁用全局的动画效果 即如果这里设为NO，不会影响收回键盘，但会影响启动键盘（就是影响其他动画效果）
}


//登陆成功后，加载界面
- (void)LoadingInterface {
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    ForthViewController *forthViewController = [[ForthViewController alloc] init];
    FifthViewController *fifthViewController = [[FifthViewController alloc] init];
    
    UITabBarItem *firstTabBar = [[UITabBarItem alloc] init];
    firstTabBar.image = [UIImage imageNamed:@"radio_button_home.png"];
    firstViewController.tabBarItem = firstTabBar;
    UITabBarItem *secondTabBar = [[UITabBarItem alloc] init];
    secondTabBar.image = [UIImage imageNamed:@"radio_button_search.png"];
    secondViewController.tabBarItem = secondTabBar;
    UITabBarItem *thirdTabBar = [[UITabBarItem alloc] init];
    thirdTabBar.image = [UIImage imageNamed:@"radio_button_note.png"];
    thirdViewController.tabBarItem = thirdTabBar;
    UITabBarItem *forthTabBar = [[UITabBarItem alloc] init];
    forthTabBar.image = [UIImage imageNamed:@"radio_button_cup.png"];
    forthViewController.tabBarItem = forthTabBar;
    UITabBarItem *fifthTabBar = [[UITabBarItem alloc] init];
    fifthTabBar.image = [UIImage imageNamed:@"radio_button_user.png"];
    fifthViewController.tabBarItem = fifthTabBar;
    
    NSArray *viewArray = [[NSArray alloc] initWithObjects:firstViewController, secondViewController, thirdViewController, forthViewController, fifthViewController, nil];
    UITabBarController *mainController = [[UITabBarController alloc] init];
    mainController.viewControllers = viewArray;
    mainController.tabBar.translucent = NO; //设置为 NO 表示关闭半透明效果，让选项卡栏不再透明。
    mainController.tabBar.tintColor = [UIColor whiteColor];//tintColor 是选项卡栏中选项卡图标和文本的颜色。
    mainController.tabBar.barTintColor = [UIColor blackColor]; //barTintColor 是选项卡栏的背景颜色。
    
    mainController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:mainController animated:YES completion:nil];
}

//进入注册界面
//讲自己设置为LandViewController的代理，方便LandViewController传值给我
- (void)RegistrationInterface {
    RegisterViewController *registerView = [[RegisterViewController alloc] init];
    registerView.delegate = self;
    
    registerView.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:registerView animated:YES completion:nil];
}

//实现协议方法
- (void)transmissionAccount:(UITextField *)account andPassword:(UITextField *)password {
    _transAccount = account;
    _transPassword = password;
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
