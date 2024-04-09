//
//  MultiLevelExampleVC.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/2.
//


#import "MultiLevelExampleVC.h"
#import "CommonPageViewController.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"

//#import "CommonCollectionViewController.h"
#import "VideoTableViewController.h"

@interface MultiLevelExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation MultiLevelExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UINavigationBarAppearance* appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.shadowLineColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:19];
    config.titleNormalFont = [UIFont systemFontOfSize:19];
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    config.showTitleInNavigationBar = true;
    config.separatorLineHidden = true;
    config.shadowLineAnimationType = XLPageShadowLineAnimationTypeZoom; //缩放
    config.shadowLineWidth = 35;
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
//- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
//    if (index == 0) {
//        CommonTableViewController *vc = [[CommonTableViewController alloc] init];
//        return vc;
//    }
//    CommonPageViewController *vc = [[CommonPageViewController alloc] init];
////    vc.titles = @[@"推荐",@"同城",@"榜单",@"明星",@"搞笑",@"吃鸡",@"种草",@"情感",@"社会",@"新时代",@"电竞"];
//    vc.titles = @[@"色盲的类型和症状",@"关于色盲的知识",@"什么样的家庭需要测色盲",@"什么职业对色彩要求严"];
////    vc.titles = @[@""]
//    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
//    config.titleSelectedColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
//    config.titleNormalColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
//    config.shadowLineHidden = true;
//    config.titleSpace = 20;
//    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
//    config.titleNormalFont = [UIFont systemFontOfSize:17];
//    config.titleColorTransition = false; //标题颜色过渡开关 默认 开
//    vc.config = config;
//    return vc;
//}

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    if (index == 0) {
        VideoTableViewController *videoTableViewController = [[VideoTableViewController alloc] init];
        return videoTableViewController;
        
    } else {
        CommonPageViewController *vc = [[CommonPageViewController alloc] init];

        vc.titles = @[@"色盲的类型和症状",@"关于色盲的知识",@"什么样的家庭需要测色盲",@"什么职业对色彩要求严"];
    //    vc.titles = @[@""]
        XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
        config.titleSelectedColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
        config.titleNormalColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
        config.shadowLineHidden = true;
        config.titleSpace = 20;
        config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
        config.titleNormalFont = [UIFont systemFontOfSize:17];
        config.titleColorTransition = false; //标题颜色过渡开关 默认 开
        vc.config = config;
        return vc;
    }
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return [self titles][index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return [self titles].count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"关注",@"热门"];
}

@end
