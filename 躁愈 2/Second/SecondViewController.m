//
//  SecondViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import "SecondViewController.h"
#import "PageOneView.h"
#import "SecondModel.h"
#import "ScrollerTableViewCell.h"
#import "SecondOfFirstTableViewCell.h"
#import "SecondOfSecondTableViewCell.h"
#import "SecondOfThirdTableViewCell.h"
#import "PageOneViewController.h"
#import "PageTwoViewController.h"
#import "PageThreeViewController.h"
#import "PageFourViewController.h"
#import "HMSegmentedControl.h"
extern UIColor *colorOfBack;
@interface SecondViewController ()

@end

@implementation SecondViewController

- (UIColor *)extracted {
    return colorOfBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.secondModel = [[SecondModel alloc] init];
    self.secondModel.pageViewControllers = [[NSArray alloc] init];
    self.view.backgroundColor = [self extracted];
    [self setupSegmentedControl];
    [self setupPageViewController];
}

- (void)setupSegmentedControl {
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"探索", @"情绪卡片", @"宠物", @"医生咨询"]];
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth; // 自动调整
//    [[HMSegmentedControl alloc] initWithSectionTitles:@[@"已收公告",@"已发公告"]];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationBottom;
    self.segmentedControl.selectionIndicatorColor = [UIColor blackColor];  //线条的颜色
    // 设置未选中时的字体颜色
    NSDictionary *normalTextAttributes = @{
        NSForegroundColorAttributeName : [UIColor grayColor], // 未选中状态下的字体颜色，这里使用灰色作为示例
        NSFontAttributeName : [UIFont systemFontOfSize:14] // 可以设置字体大小等其他属性
    };
    self.segmentedControl.titleTextAttributes = normalTextAttributes;

    // 设置选中时的字体颜色
    NSDictionary *selectedTextAttributes = @{
        NSForegroundColorAttributeName : [UIColor blackColor], // 选中状态下的字体颜色，这里使用红色作为示例
        NSFontAttributeName : [UIFont boldSystemFontOfSize:14] // 可以设置字体大小等其他属性
    };
    self.segmentedControl.selectedTitleTextAttributes = selectedTextAttributes;

    self.segmentedControl.selectionIndicatorHeight = 4.0f;
//    self.segmentedControl.segmentWidth = 80; // 指定每个段的固定宽度
//    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    
    self.segmentedControl.frame = CGRectMake(10, 50, self.view.frame.size.width - 20, 30);
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = colorOfBack;
    [self.view addSubview:self.segmentedControl];
}

- (void)setupPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;

    PageOneViewController *initialVC = [[PageOneViewController alloc] init];
    PageTwoViewController *secondVC = [[PageTwoViewController alloc] init];
    PageThreeViewController *thirdVC = [[PageThreeViewController alloc] init];
    PageFourViewController *fourthVC = [[PageFourViewController alloc] init];
    self.secondModel.pageViewControllers = @[initialVC, secondVC, thirdVC, fourthVC];

    [self.pageViewController setViewControllers:@[initialVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    self.pageViewController.view.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 90);
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    UIPageViewControllerNavigationDirection direction = selectedIndex > self.pageViewController.viewControllers.firstObject.restorationIdentifier.integerValue ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;

    [self.pageViewController setViewControllers:@[self.secondModel.pageViewControllers[selectedIndex]] direction:direction animated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.secondModel.pageViewControllers indexOfObject:viewController];
    if (currentIndex == 0) {
        return nil;
    }
    return self.secondModel.pageViewControllers[currentIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.secondModel.pageViewControllers indexOfObject:viewController];
    if (currentIndex == NSNotFound || currentIndex + 1 == self.secondModel.pageViewControllers.count) {
        return nil;
    }
    return self.secondModel.pageViewControllers[currentIndex + 1];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSInteger currentIndex = [self.secondModel.pageViewControllers indexOfObject:self.pageViewController.viewControllers.firstObject];
        self.segmentedControl.selectedSegmentIndex = currentIndex;
    }
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
