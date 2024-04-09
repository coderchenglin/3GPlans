//
//  ViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  Demo主视图

#import "ViewController.h"
#import "OtherAppExampleListVC.h"
#import "BasicFunctionListVC.h"
#import "SpecialUseExampleVC.h"
#import "XLPageViewController.h"

@interface ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //配置
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.showTitleInNavigationBar = true;
    config.titleViewStyle = XLPageTitleViewStyleSegmented;
    config.separatorLineHidden = true;
    //设置缩进
    config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark PageViewControllerDataSource
//分页数
- (NSInteger)pageViewControllerNumberOfPage {
    return [self vcTitles].count;
}

//分页标题
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return [self vcTitles][index];
}

//分页视图控制器
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    if (index == 0) {
        OtherAppExampleListVC *vc = [[OtherAppExampleListVC alloc] init];
        return vc;
        
    }else if (index == 1) {
        BasicFunctionListVC *vc = [[BasicFunctionListVC alloc] init];
        return vc;
    }else  {
        SpecialUseExampleVC *vc = [[SpecialUseExampleVC alloc] init];
        return vc;
    }
}

#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self vcTitles][index]);
}

#pragma mark -
#pragma mark 标题
- (NSArray *)vcTitles {
    return @[@"App例子",@"基础属性",@"特殊用法"];
}
@end
