//
//  InitViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/2/13.
//

#import "InitViewController.h"
#import "HomeViewController.h"
#import "GameViewController.h"
#import "ShareViewController.h"
#import "PersonalViewController.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
//393
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//852

@interface InitViewController ()
@property (nonatomic, strong) UIImageView *beforeImageView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:myTimer forMode:NSRunLoopCommonModes];
    
    UIColor *groundColor = [UIColor colorWithRed:(140.0f / 255.0f) green:(140.0f / 255.0f) blue:(140.0f / 255.0f) alpha:1.0];
    self.view.backgroundColor = groundColor;
    self.beforeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    self.beforeImageView.frame = CGRectMake((SIZE_WIDTH - 250) / 2, 250, 250, 60);
    NSLog(@"width = %f height = %f",SIZE_WIDTH,SIZE_HEIGHT);
    [self.view addSubview:self.beforeImageView];
    [self imageViewRun];
}

- (void)imageViewRun {
    [UIImageView animateWithDuration:2 animations:^{
        self.beforeImageView.frame = CGRectMake((SIZE_WIDTH - 250) / 2 + 125, 280, 2.5, 0.6);
    }completion:^(BOOL finished) {
        self.beforeImageView.image = [UIImage imageNamed:@"image3.png"];
        [self imageViewSecondRun];
    }];
}

- (void)imageViewSecondRun {
    [UIImageView animateWithDuration:2 animations:^{
        self.beforeImageView.frame = CGRectMake((SIZE_WIDTH - 300) / 2, 250, 300, 144);
    }];
    [self.beforeImageView stopAnimating];
}

- (void)controllerInit {
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    GameViewController *gameViewController = [[GameViewController alloc] init];
    ShareViewController *shareViewController = [[ShareViewController alloc] init];
    UIColor *groundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f)blue:(18.0f / 255.0f) alpha:1.0f];
    
    homeViewController.view.backgroundColor = groundColor;
    gameViewController.view.backgroundColor = groundColor;
    shareViewController.view.backgroundColor = groundColor;

    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    UINavigationController *gameNavigationController = [[UINavigationController alloc] initWithRootViewController:gameViewController];
    UINavigationController *shareNavigationController = [[UINavigationController alloc] initWithRootViewController:shareViewController];
    self.array = [NSArray arrayWithObjects:homeNavigationController,gameNavigationController,shareNavigationController, nil];
}

- (void)timeOut {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = self.array;
    UIColor *titleColor = [UIColor colorWithRed:(85.0f / 255.0f) green:(83.0f / 255.0f) blue:(99.0f / 255.0f) alpha:1.0f];
    tabBarController.tabBar.translucent = NO;
    UIColor *tabBarColor = [UIColor colorWithRed:(32.0f / 255.0f) green:(31.0f / 255.0f)blue:(38.0f / 255.0f) alpha:1.0f];
    tabBarController.tabBar.backgroundColor = tabBarColor;
    
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    tabBarController.selectedIndex = 0;  //设置初始选项为第一个item
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
