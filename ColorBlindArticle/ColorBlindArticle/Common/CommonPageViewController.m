//
//  CommonPageViewController.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/2.
//

#import "CommonPageViewController.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"
#import "VideoTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface CommonPageViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation CommonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    
    if (index == 0) {
        CommonTableViewController *vc = [[CommonTableViewController alloc] init];
        return vc;
    } else {
        VideoTableViewController *videoTableViewController = [[VideoTableViewController alloc] init];
        return videoTableViewController;
    }
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titles[index];
    
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",self.titles[index]);
}


@end
