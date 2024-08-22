//
//  MainViewController.h
//  分栏控件多级嵌套2
//
//  Created by chenglin on 2024/8/22.
//

#import <UIKit/UIKit.h>
#import "HotViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *topSegmentedControl;
@property (nonatomic, strong) UISegmentedControl *secondSegmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *focusViewController;
@property (nonatomic, strong) UIViewController *hotViewController;

@end

NS_ASSUME_NONNULL_END
