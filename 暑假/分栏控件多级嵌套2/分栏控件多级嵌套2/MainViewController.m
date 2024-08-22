//
//  MainViewController.m
//  分栏控件多级嵌套2
//
//  Created by chenglin on 2024/8/22.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor  = [UIColor whiteColor];
    self.topSegmentedControl.selectedSegmentIndex = 0;
    self.topSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"关注",@"热门"]];
    self.topSegmentedControl.frame = CGRectMake(100, 50, self.view.bounds.size.width - 200, 30);
    [self.topSegmentedControl addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged]; //值发生变化时调用
    [self.view addSubview:self.topSegmentedControl];

    //创建第二层分栏控制器，到哪默认隐藏
    self.secondSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
    self.secondSegmentControl.selectedSegmentIndex = 0;
    [self.secondSegmentControl addTarget:self action:@selector(secondSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.secondSegmentControl.frame = CGRectMake(0, 80, self.view.bounds.size.width, 30);
    self.secondSegmentControl.hidden = YES; //
    [self.view addSubview:self.secondSegmentControl];
    
    [self setupScrollView];
    [self setupChildViewControllers];
    

}

- (void)setupScrollView {
    CGFloat yOffset = CGRectGetMaxY(self.topSegmentedControl.frame);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset)];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.scrollView.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
}

- (void)setupChildViewControllers {
    
    self.focusViewController = [[UIViewController alloc] init];
    self.focusViewController.view.backgroundColor = [UIColor whiteColor];
    self.focusViewController.view.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.scrollView.bounds.size.height - 110);
    
    self.hotViewController = [[HotViewController alloc] init];
    self.hotViewController.view.frame = CGRectMake(self.view.bounds.size.width, 110, self.view.bounds.size.width, self.scrollView.bounds.size.height - 110);
    
    [self addChildViewController:self.focusViewController];
    [self.scrollView addSubview:self.focusViewController.view];
    
    [self addChildViewController:self.hotViewController];
    [self.scrollView addSubview:self.hotViewController.view];
    
    [self.hotViewController didMoveToParentViewController:self];
    
}

- (void)topSegmentChanged:(UISegmentedControl *)sender {
    CGPoint offset = CGPointMake(self.view.bounds.size.width * sender.selectedSegmentIndex, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
    if (sender.selectedSegmentIndex == 1) {
        self.secondSegmentControl.hidden = NO;
        [self adjustScrollViewFrameForSecondSegmentVisible:YES];
    } else {
        self.secondSegmentControl.hidden = YES;
        [self adjustScrollViewFrameForSecondSegmentVisible:NO];
    }
    
}

- (void)adjustScrollViewFrameForSecondSegmentVisible:(BOOL)visible {
    CGFloat yOffset = visible ? CGRectGetMaxY(self.secondSegmentControl.frame) : CGRectGetMaxY(self.topSegmentedControl.frame);
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.frame = CGRectMake(0, yOffset, self.view.bounds.size.width, self.view.bounds.size.height - yOffset);
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.topSegmentedControl.selectedSegmentIndex = pageIndex;
    
    if (pageIndex == 1) {
        self.secondSegmentControl.hidden = NO;
        [self adjustScrollViewFrameForSecondSegmentVisible:YES];
    } else {
        self.secondSegmentControl.hidden = YES;
        [self adjustScrollViewFrameForSecondSegmentVisible:NO];
    }
    
}


@end
