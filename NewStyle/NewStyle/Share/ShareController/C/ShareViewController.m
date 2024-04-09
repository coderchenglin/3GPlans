//
//  ShareViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "ShareViewController.h"
#import "ShareView.h"
#import "PublishViewController.h"
#import "PhotoBrowseViewController.h"
@interface ShareViewController ()
@property (nonatomic, strong) ShareView *shareView;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.title = @"分享";
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 10)];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];
    tabBarItem.image = [[UIImage imageNamed:@"share1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"share2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = tabBarItem;
    
    self.shareView = [[ShareView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.shareView];
    [self.shareView viewInit];
    self.navigationItem.titleView = self.shareView.segmentedControl;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressShareImage:) name:@"shareImage" object:nil];
    
    UIBarButtonItem *photoButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pressPublishViewController)];
    photoButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = photoButtonItem;
}

- (void)pressPublishViewController {
    PublishViewController *publishViewController = [[PublishViewController alloc] init];
    int flag;
    if (self.shareView.scrollView.contentOffset.x == 0) {
        flag = 0;
    } else {
        flag = 1;
    }
    publishViewController.flag = flag;
    [self.navigationController pushViewController:publishViewController animated:YES];
}

- (void)pressShareImage:(NSNotification *)sender {
    PhotoBrowseViewController *photoBrowseViewController = [[PhotoBrowseViewController alloc] init];
    photoBrowseViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    photoBrowseViewController.shareImage = sender.userInfo[@"shareImage"];
    [self presentViewController:photoBrowseViewController animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
