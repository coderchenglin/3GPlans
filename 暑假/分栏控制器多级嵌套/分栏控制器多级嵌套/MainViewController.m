//
//  MainViewController.m
//  分栏控制器多级嵌套
//
//  Created by chenglin on 2024/8/21.
//

#import "MainViewController.h"
#import "HotViewController.h"

@interface MainViewController ()

@end

//@implementation MainViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建顶级分栏控制器
//    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"热门"]];
//    self.topSegmentedControl.selectedSegmentIndex = 0;
//    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = self.topSegmentedControl;
//
//    // 设置 UIScrollView
//    //[self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.delegate = self;
//    [self.view addSubview:self.scrollView];
//}
//
//- (void)setupChildViewControllers {
//    self.focusViewController = [[UIViewController alloc] init];
//    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
//    self.focusViewController.view.frame = self.view.bounds;
//
//    self.hotViewController = [[HotViewController alloc] init];
//    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//
//    [self addChildViewController:self.focusViewController];
//    [self.scrollView addSubview:self.focusViewController.view];
//    [self.focusViewController didMoveToParentViewController:self];
//
//    [self addChildViewController:self.hotViewController];
//    [self.scrollView addSubview:self.hotViewController.view];
//    [self.hotViewController didMoveToParentViewController:self];
//}
//
////- (void)topSegmentChanged:(UISegmentedControl *)sender {
////    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
////    [self.scrollView setContentOffset:offset animated:YES];
////}
//
//- (void)topSegmentChanged:(UISegmentedControl *)sender {
//    if (sender.selectedSegmentIndex == 0) {
//        self.focusViewController.view.hidden = NO;
//        self.hotViewController.view.hidden = YES;
//    } else {
//        self.focusViewController.view.hidden = YES;
//        self.hotViewController.view.hidden = NO;
//    }
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
//}
//
//@end

//@implementation MainViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建顶级分栏控制器
//    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"热门"]];
//    self.topSegmentedControl.selectedSegmentIndex = 0;
//    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = self.topSegmentedControl;
//
//    // 设置 UIScrollView
//    [self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.delegate = self;
//    [self.view addSubview:self.scrollView];
//}
//
//- (void)setupChildViewControllers {
//    self.focusViewController = [[UIViewController alloc] init];
//    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
//    self.focusViewController.view.frame = self.view.bounds;
//
//    self.hotViewController = [[HotViewController alloc] init];
//    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//
//    [self addChildViewController:self.focusViewController];
//    [self.scrollView addSubview:self.focusViewController.view];
//    [self.focusViewController didMoveToParentViewController:self];
//
//    [self addChildViewController:self.hotViewController];
//    [self.scrollView addSubview:self.hotViewController.view];
//    [self.hotViewController didMoveToParentViewController:self];
//}
//
//- (void)topSegmentChanged:(UISegmentedControl *)sender {
//    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
//}
//
//@end

//@implementation MainViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建顶级分栏控制器
//    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"热门"]];
//    self.topSegmentedControl.selectedSegmentIndex = 0;
//    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = self.topSegmentedControl;
//
//    // 设置 UIScrollView
//    [self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//
//    // 设置 contentSize 的高度与 scrollView 高度一致，禁用竖向滑动
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
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
//- (void)setupChildViewControllers {
//    self.focusViewController = [[UIViewController alloc] init];
//    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
//    self.focusViewController.view.frame = self.view.bounds;
//
//    self.hotViewController = [[HotViewController alloc] init];
//    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//
//    [self addChildViewController:self.focusViewController];
//    [self.scrollView addSubview:self.focusViewController.view];
//    [self.focusViewController didMoveToParentViewController:self];
//
//    [self addChildViewController:self.hotViewController];
//    [self.scrollView addSubview:self.hotViewController.view];
//    [self.hotViewController didMoveToParentViewController:self];
//}
//
//- (void)topSegmentChanged:(UISegmentedControl *)sender {
//    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
//}
//
//@end


//@implementation MainViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 创建顶级分栏控制器
//    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"热门"]];
//    self.topSegmentedControl.selectedSegmentIndex = 0;
//    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.topSegmentedControl.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, 50);
//    [self.view addSubview:self.topSegmentedControl];
//
//    // 创建第二层分栏控制器，但默认隐藏
//    self.secondSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
//    self.secondSegmentedControl.selectedSegmentIndex = 0;
//    [self.secondSegmentedControl addTarget:self action:@selector(secondSegmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.secondSegmentedControl.frame = CGRectMake(0, CGRectGetMaxY(self.topSegmentedControl.frame), self.view.bounds.size.width, 50);
//    self.secondSegmentedControl.hidden = YES; // 默认隐藏
//    [self.view addSubview:self.secondSegmentedControl];
//
//    // 设置 UIScrollView
//    [self setupScrollView];
//    [self setupChildViewControllers];
//}
//
//- (void)setupScrollView {
//    CGFloat yOffset = CGRectGetMaxY(self.topSegmentedControl.frame);
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset)];
//
//    // 设置 contentSize 的高度与 scrollView 高度一致，禁用竖向滑动
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.scrollView.bounds.size.height);
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
//    self.focusViewController = [[UIViewController alloc] init];
//    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
//    self.focusViewController.view.frame = self.view.bounds;
//
//    self.hotViewController = [[HotViewController alloc] init];
//    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height);
//
//    [self addChildViewController:self.focusViewController];
//    [self.scrollView addSubview:self.focusViewController.view];
//    [self.focusViewController didMoveToParentViewController:self];
//
//    [self addChildViewController:self.hotViewController];
//    [self.scrollView addSubview:self.hotViewController.view];
//    [self.hotViewController didMoveToParentViewController:self];
//}
//
//- (void)topSegmentChanged:(UISegmentedControl *)sender {
//    // 根据选中的 segment 切换视图
//    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
//
//    // 显示或隐藏第二层分栏控制器
//    if (sender.selectedSegmentIndex == 1) { // 如果选中了"热门"
//        self.secondSegmentedControl.hidden = NO;
//        [self adjustScrollViewFrameForSecondSegmentVisible:YES];
//    } else {
//        self.secondSegmentedControl.hidden = YES;
//        [self adjustScrollViewFrameForSecondSegmentVisible:NO];
//    }
//}
//
//- (void)adjustScrollViewFrameForSecondSegmentVisible:(BOOL)visible {
//    CGFloat yOffset = visible ? CGRectGetMaxY(self.secondSegmentedControl.frame) : CGRectGetMaxY(self.topSegmentedControl.frame);
//    [UIView animateWithDuration:0.3 animations:^{
//        self.scrollView.frame = CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset);
//    }];
//}
//
//- (void)secondSegmentChanged:(UISegmentedControl *)sender {
//    // 第二层分栏控制器的逻辑
//    // 可以根据需要处理在这里处理
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
//
//    // 同样，根据滚动的结果，显示或隐藏第二层分栏控制器
//    if (pageIndex == 1) {
//        self.secondSegmentedControl.hidden = NO;
//        [self adjustScrollViewFrameForSecondSegmentVisible:YES];
//    } else {
//        self.secondSegmentedControl.hidden = YES;
//        [self adjustScrollViewFrameForSecondSegmentVisible:NO];
//    }
//}
//
//@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建顶级分栏控制器
    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"热门"]];
    self.topSegmentedControl.selectedSegmentIndex = 0;
    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.topSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.topSegmentedControl];
    
    // 创建第二层分栏控制器，但默认隐藏
    self.secondSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
    self.secondSegmentedControl.selectedSegmentIndex = 0;
    [self.secondSegmentedControl addTarget:self action:@selector(secondSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.secondSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.secondSegmentedControl.hidden = YES; // 默认隐藏
    [self.view addSubview:self.secondSegmentedControl];
    
    // 设置 UIScrollView
    [self setupScrollView];
    [self setupChildViewControllers];
    [self setupConstraints];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    
    // 设置 contentSize 的高度与 scrollView 高度一致，禁用竖向滑动
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    // 禁用竖向滚动
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.scrollView];
}

- (void)setupChildViewControllers {
    self.focusViewController = [[UIViewController alloc] init];
    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
    self.focusViewController.view.frame = self.view.bounds;
    
    self.hotViewController = [[HotViewController alloc] init];
    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height);
    
    [self addChildViewController:self.focusViewController];
    [self.scrollView addSubview:self.focusViewController.view];
    [self.focusViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.hotViewController];
    [self.scrollView addSubview:self.hotViewController.view];
    [self.hotViewController didMoveToParentViewController:self];
}

- (void)setupConstraints {
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    
    // 顶级 UISegmentedControl 约束
    [NSLayoutConstraint activateConstraints:@[
        [self.topSegmentedControl.topAnchor constraintEqualToAnchor:safeArea.topAnchor],
        [self.topSegmentedControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.topSegmentedControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.topSegmentedControl.heightAnchor constraintEqualToConstant:50]
    ]];
    
    // 第二层 UISegmentedControl 约束
    [NSLayoutConstraint activateConstraints:@[
        [self.secondSegmentedControl.topAnchor constraintEqualToAnchor:self.topSegmentedControl.bottomAnchor],
        [self.secondSegmentedControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.secondSegmentedControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.secondSegmentedControl.heightAnchor constraintEqualToConstant:50]
    ]];
    
    // UIScrollView 约束
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.secondSegmentedControl.bottomAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor]
    ]];
}

- (void)topSegmentChanged:(UISegmentedControl *)sender {
    // 根据选中的 segment 切换视图
    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
    // 显示或隐藏第二层分栏控制器
    if (sender.selectedSegmentIndex == 1) { // 如果选中了"热门"
        self.secondSegmentedControl.hidden = NO;
    } else {
        self.secondSegmentedControl.hidden = YES;
    }
}

- (void)secondSegmentChanged:(UISegmentedControl *)sender {
    // 第二层分栏控制器的逻辑
    // 可以根据需要处理在这里处理
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
    
    // 同样，根据滚动的结果，显示或隐藏第二层分栏控制器
    if (pageIndex == 1) {
        self.secondSegmentedControl.hidden = NO;
    } else {
        self.secondSegmentedControl.hidden = YES;
    }
}

@end
