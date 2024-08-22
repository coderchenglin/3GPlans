//
//  HotViewController.m
//  分栏控制器多级嵌套
//
//  Created by chenglin on 2024/8/21.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

//@implementation HotViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建二级分栏控制器
//    self.bottomSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
//    self.bottomSegmentedControl.selectedSegmentIndex = 0;
//    [self.bottomSegmentedControl addTarget:self action:@selector(bottomSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.bottomSegmentedControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
//    [self.view addSubview:self.bottomSegmentedControl];
//
//    // 用于显示内容的容器视图
//    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
//    [self.view addSubview:self.contentView];
//
////    // 设置 UIScrollView
////    [self setupBottomScrollView];
////    [self setupBottomChildViewControllers];
//
//    // 初始化子视图控制器
//    [self setupChildViewControllers];
//
//    // 默认显示第一个子视图控制器
//    [self displayContentController:self.vc1];
//}
//
//- (void)setupChildViewControllers {
//    self.vc1 = [[UIViewController alloc] init];
//    self.vc1.view.backgroundColor = [UIColor lightGrayColor];
//
//    self.vc2 = [[UIViewController alloc] init];
//    self.vc2.view.backgroundColor = [UIColor orangeColor];
//
//    self.vc3 = [[UIViewController alloc] init];
//    self.vc3.view.backgroundColor = [UIColor yellowColor];
//
//    [self addChildViewController:self.vc1];
//    [self addChildViewController:self.vc2];
//    [self addChildViewController:self.vc3];
//}
//
//- (void)bottomSegmentChanged:(UISegmentedControl *)sender {
//    if (sender.selectedSegmentIndex == 0) {
//        [self displayContentController:self.vc1];
//    } else if (sender.selectedSegmentIndex == 1) {
//        [self displayContentController:self.vc2];
//    } else {
//        [self displayContentController:self.vc3];
//    }
//}
//
//- (void)displayContentController:(UIViewController *)viewController {
//    // 移除当前显示的子视图
//    for (UIView *subview in self.contentView.subviews) {
//        [subview removeFromSuperview];
//    }
//
//    viewController.view.frame = self.contentView.bounds;
//    [self.contentView addSubview:viewController.view];
//    [viewController didMoveToParentViewController:self];
//}


//- (void)setupBottomScrollView {
//    self.bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
//    self.bottomScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.bottomScrollView.bounds.size.height);
//    self.bottomScrollView.pagingEnabled = YES;
//    self.bottomScrollView.delegate = self;
//    [self.view addSubview:self.bottomScrollView];
//}
//
//- (void)setupBottomChildViewControllers {
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.view.backgroundColor = [UIColor lightGrayColor];
//    vc1.view.frame = self.bottomScrollView.bounds;
//
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.view.backgroundColor = [UIColor orangeColor];
//    vc2.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.bottomScrollView.bounds.size.height);
//
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.view.backgroundColor = [UIColor yellowColor];
//    vc3.view.frame = CGRectMake(self.view.bounds.size.width * 2, 0, self.view.bounds.size.width, self.bottomScrollView.bounds.size.height);
//
//    [self addChildViewController:vc1];
//    [self.bottomScrollView addSubview:vc1.view];
//    [vc1 didMoveToParentViewController:self];
//
//    [self addChildViewController:vc2];
//    [self.bottomScrollView addSubview:vc2.view];
//    [vc2 didMoveToParentViewController:self];
//
//    [self addChildViewController:vc3];
//    [self.bottomScrollView addSubview:vc3.view];
//    [vc3 didMoveToParentViewController:self];
//}
//
//- (void)bottomSegmentChanged:(UISegmentedControl *)sender {
//    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
//    [self.bottomScrollView setContentOffset:offset animated:YES];
//}


//@implementation HotViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建二级分栏控制器
//    self.bottomSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
//    self.bottomSegmentedControl.selectedSegmentIndex = 0;
//    [self.bottomSegmentedControl addTarget:self action:@selector(bottomSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.bottomSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:self.bottomSegmentedControl];
//
//    // 用于显示内容的容器视图
//    self.contentView = [[UIView alloc] init];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:self.contentView];
//
//    // 设置自动布局约束
//    [self setupConstraints];
//
//    // 初始化子视图控制器
//    [self setupChildViewControllers];
//
//    // 默认显示第一个子视图控制器
//    [self displayContentController:self.vc1];
//}
//
//- (void)setupConstraints {
//    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
//
//    // 二级 UISegmentedControl 的约束
//    [NSLayoutConstraint activateConstraints:@[
//        [self.bottomSegmentedControl.topAnchor constraintEqualToAnchor:safeArea.topAnchor],
//        [self.bottomSegmentedControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//        [self.bottomSegmentedControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//        [self.bottomSegmentedControl.heightAnchor constraintEqualToConstant:50]
//    ]];
//
//    // Content View 的约束
//    [NSLayoutConstraint activateConstraints:@[
//        [self.contentView.topAnchor constraintEqualToAnchor:self.bottomSegmentedControl.bottomAnchor],
//        [self.contentView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//        [self.contentView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//        [self.contentView.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor]
//    ]];
//}
//
//- (void)setupChildViewControllers {
//    self.vc1 = [[UIViewController alloc] init];
//    self.vc1.view.backgroundColor = [UIColor lightGrayColor];
//
//    self.vc2 = [[UIViewController alloc] init];
//    self.vc2.view.backgroundColor = [UIColor orangeColor];
//
//    self.vc3 = [[UIViewController alloc] init];
//    self.vc3.view.backgroundColor = [UIColor yellowColor];
//
//    [self addChildViewController:self.vc1];
//    [self addChildViewController:self.vc2];
//    [self addChildViewController:self.vc3];
//}
//
//- (void)bottomSegmentChanged:(UISegmentedControl *)sender {
//    if (sender.selectedSegmentIndex == 0) {
//        [self displayContentController:self.vc1];
//    } else if (sender.selectedSegmentIndex == 1) {
//        [self displayContentController:self.vc2];
//    } else {
//        [self displayContentController:self.vc3];
//    }
//}
//
//- (void)displayContentController:(UIViewController *)viewController {
//    // 移除当前显示的子视图
//    for (UIView *subview in self.contentView.subviews) {
//        [subview removeFromSuperview];
//    }
//
//    viewController.view.frame = self.contentView.bounds;
//    [self.contentView addSubview:viewController.view];
//    [viewController didMoveToParentViewController:self];
//}
//
//
//@end

//@implementation HotViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建二级分栏控制器
//    self.bottomSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
//    self.bottomSegmentedControl.selectedSegmentIndex = 0;
//    [self.bottomSegmentedControl addTarget:self action:@selector(bottomSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.bottomSegmentedControl.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, 50);
//    [self.view addSubview:self.bottomSegmentedControl];
//
//    // 设置 UIScrollView
//    [self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    CGFloat yOffset = CGRectGetMaxY(self.bottomSegmentedControl.frame);
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset)];
//
//    // 设置 contentSize 的高度与 scrollView 高度一致，禁用竖向滑动
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.scrollView.bounds.size.height);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.delegate = self;
//
//    // 禁用竖向滚动
//    self.scrollView.alwaysBounceVertical = NO; // 不允许竖直方向的弹性滚动
//    self.scrollView.showsVerticalScrollIndicator = NO; // 隐藏竖向滚动条
//
//    [self.view addSubview:self.scrollView];
//}
//
////- (void)setupScrollView {
////    CGFloat yOffset = CGRectGetMaxY(self.bottomSegmentedControl.frame);
////    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset)];
////    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.scrollView.bounds.size.height);
////    self.scrollView.pagingEnabled = YES;
////    self.scrollView.delegate = self;
////    [self.view addSubview:self.scrollView];
////}
//
//- (void)setupChildViewControllers {
//    self.vc1 = [[UIViewController alloc] init];
//    self.vc1.view.backgroundColor = [UIColor lightGrayColor];
//    self.vc1.view.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    self.vc2 = [[UIViewController alloc] init];
//    self.vc2.view.backgroundColor = [UIColor orangeColor];
//    self.vc2.view.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    self.vc3 = [[UIViewController alloc] init];
//    self.vc3.view.backgroundColor = [UIColor yellowColor];
//    self.vc3.view.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    [self addChildViewController:self.vc1];
//    [self.scrollView addSubview:self.vc1.view];
//    [self.vc1 didMoveToParentViewController:self];
//
//    [self addChildViewController:self.vc2];
//    [self.scrollView addSubview:self.vc2.view];
//    [self.vc2 didMoveToParentViewController:self];
//
//    [self addChildViewController:self.vc3];
//    [self.scrollView addSubview:self.vc3.view];
//    [self.vc3 didMoveToParentViewController:self];
//}
//
//- (void)bottomSegmentChanged:(UISegmentedControl *)sender {
//    CGPoint offset = CGPointMake(self.scrollView.bounds.size.width * sender.selectedSegmentIndex, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    self.bottomSegmentedControl.selectedSegmentIndex = pageIndex;
//}
//
//@end

//@implementation HotViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 设置 UIScrollView
//    [self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//
//    // 设置 contentSize 的宽度为3倍，允许水平滑动
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.scrollView.bounds.size.height);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.delegate = self;
//
//    // 禁用竖向滚动
//    self.scrollView.alwaysBounceVertical = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//
//    [self.view addSubview:self.scrollView];
//}
//
//- (void)setupChildViewControllers {
//    self.vc1 = [[UIViewController alloc] init];
//    self.vc1.view.backgroundColor = [UIColor lightGrayColor];
//    self.vc1.view.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    self.vc2 = [[UIViewController alloc] init];
//    self.vc2.view.backgroundColor = [UIColor orangeColor];
//    self.vc2.view.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    self.vc3 = [[UIViewController alloc] init];
//    self.vc3.view.backgroundColor = [UIColor yellowColor];
//    self.vc3.view.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//
//    [self addChildViewController:self.vc1];
//    [self.scrollView addSubview:self.vc1.view];
//    [self.vc1 didMoveToParentViewController:self];
//
//    [self addChildViewController:self.vc2];
//    [self.scrollView addSubview:self.vc2.view];
//    [self.vc2 didMoveToParentViewController:self];
//
//    [self addChildViewController:self.vc3];
//    [self.scrollView addSubview:self.vc3.view];
//    [self.vc3 didMoveToParentViewController:self];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    // 通知主视图控制器更新第二层分栏的选中状态
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    if (self.parentViewController && [self.parentViewController respondsToSelector:@selector(secondSegmentChanged:)]) {
//        UISegmentedControl *secondSegmentedControl = [(id)self.parentViewController secondSegmentedControl];
//        if (secondSegmentedControl) {
//            secondSegmentedControl.selectedSegmentIndex = pageIndex;
//        }
//    }
//}
//
//@end


@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置 UIScrollView
    [self setupScrollView];
    [self setupChildViewControllers];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.scrollView.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    // 禁用竖向滚动
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
}

- (void)setupChildViewControllers {
    self.vc1 = [[UIViewController alloc] init];
    self.vc1.view.backgroundColor = [UIColor lightGrayColor];
    self.vc1.view.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.vc2 = [[UIViewController alloc] init];
    self.vc2.view.backgroundColor = [UIColor orangeColor];
    self.vc2.view.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.vc3 = [[UIViewController alloc] init];
    self.vc3.view.backgroundColor = [UIColor yellowColor];
    self.vc3.view.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    [self addChildViewController:self.vc1];
    [self.scrollView addSubview:self.vc1.view];
    [self.vc1 didMoveToParentViewController:self];
    
    [self addChildViewController:self.vc2];
    [self.scrollView addSubview:self.vc2.view];
    [self.vc2 didMoveToParentViewController:self];
    
    [self addChildViewController:self.vc3];
    [self.scrollView addSubview:self.vc3.view];
    [self.vc3 didMoveToParentViewController:self];
}

@end
