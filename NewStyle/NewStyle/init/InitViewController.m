//
//  InitViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "InitViewController.h"
#import "HomeViewController.h"
#import "GameViewController.h"
#import "ShareViewController.h"
#import "PersonalViewController.h"

#import "LoginViewController.h"

#define MYWIDTH ([UIScreen mainScreen].bounds.size.width)
#define MYHEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface InitViewController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIImageView *beforeImageView;

@end



@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    //启动界面5秒以后，显示导航栏
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:myTimer forMode:NSRunLoopCommonModes];
    
    UIColor *groundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f)blue:(18.0f / 255.0f) alpha:1.0f];
    self.view.backgroundColor = groundColor;
    
    self.beforeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MYWIDTH - 250) / 2, 250, 250, 60)];
    [self.beforeImageView setImage:[UIImage imageNamed:@"title1.png"]];
    self.beforeImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.beforeImageView];
    
    [self imageViewRun];
    [self controllerinit];
    
}

//第一个视图消失
- (void)imageViewRun {
    //通过这个方法，你可以指定动画时长、动画效果、完成后的操作等。
    [UIImageView animateWithDuration:0.1 animations:^{
        //动画缩小
        self.beforeImageView.frame = CGRectMake((MYWIDTH - 250) / 2 + 125, 280, 2.5, 0.6);
    }completion:^(BOOL finished) {
        //缩小完成后，切换图片
        self.beforeImageView.image = [UIImage imageNamed:@"image3.png"];
        //这个方法让第二章图片动画放大
        [self imageViewSecondRun];
    }];
}

//第二个视图显示
- (void)imageViewSecondRun {
    [UIImageView animateWithDuration:0.1 animations:^{
        self.beforeImageView.frame = CGRectMake((MYWIDTH - 300) / 2, 250, 300, 169);
    }];
    [self.beforeImageView stopAnimating];
}

//视图控制器提前初始化
- (void)controllerinit {
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    GameViewController *gameViewController = [[GameViewController alloc] init];
    ShareViewController *shareViewController = [[ShareViewController alloc] init];
    PersonalViewController *personalViewController = [[PersonalViewController alloc] init];
    UIColor *groundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f)blue:(18.0f / 255.0f) alpha:1.0f];

    homeViewController.view.backgroundColor = groundColor;
    gameViewController.view.backgroundColor = groundColor;
    shareViewController.view.backgroundColor = groundColor;
    personalViewController.view.backgroundColor = groundColor;
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    UINavigationController *gameNavigationController = [[UINavigationController alloc] initWithRootViewController:gameViewController];
    UINavigationController *shareNavigationController = [[UINavigationController alloc] initWithRootViewController:shareViewController];
    UINavigationController *personalNavigationController = [[UINavigationController alloc] initWithRootViewController:personalViewController];
    self.array = [NSArray arrayWithObjects:homeNavigationController, gameNavigationController, shareNavigationController, personalNavigationController, nil];
    //self.array = [NSArray arrayWithObjects:homeNavigationController, nil];
    
}

//启动图结束
- (void)timeOut {
    
    //测试登陆注册界面
//    LoginViewController *a = [LoginViewController new];
//    a.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:a animated:YES completion:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = self.array;//让工具栏的每个子视图，都封装成导航栏
    UIColor *titleColor = [UIColor colorWithRed:(85.0f / 255.0f) green:(83.0f / 255.0f) blue:(99.0f / 255.0f) alpha:1.0f];
    tabBarController.tabBar.barTintColor = titleColor;
    self.tabBarController.tabBar.translucent = NO;
    UIColor *tabBarColor = [UIColor colorWithRed:(32.0f / 255.0f) green:(31.0f / 255.0f) blue:(38.0f / 255.0f) alpha:1.0f];
    tabBarController.tabBar.backgroundColor = tabBarColor;
    
    //推出视图
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:tabBarController animated:YES completion:nil];
    
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
