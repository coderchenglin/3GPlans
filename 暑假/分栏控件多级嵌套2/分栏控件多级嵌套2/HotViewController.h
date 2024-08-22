//
//  HotViewController.h
//  分栏控件多级嵌套2
//
//  Created by chenglin on 2024/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotViewController : UIViewController

@property (nonatomic, strong) UISegmentedControl *bottomSegmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *vc1;
@property (nonatomic, strong) UIViewController *vc2;
@property (nonatomic, strong) UIViewController *vc3;

@end

NS_ASSUME_NONNULL_END
