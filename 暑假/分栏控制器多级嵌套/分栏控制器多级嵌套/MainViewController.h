//
//  MainViewController.h
//  分栏控制器多级嵌套
//
//  Created by chenglin on 2024/8/21.
//

#import <UIKit/UIKit.h>
#import "HotViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

@property (nonatomic, strong) UISegmentedControl *topSegmentedControl;
@property (nonatomic, strong) UISegmentedControl *secondSegmentedControl; // 第二层 UISegmentedControl
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *focusViewController;
//@property (nonatomic, strong) UIViewController *hotViewController;
@property (nonatomic, strong) HotViewController *hotViewController;


@end

NS_ASSUME_NONNULL_END
