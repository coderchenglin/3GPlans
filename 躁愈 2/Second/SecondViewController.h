//
//  SecondViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import <UIKit/UIKit.h>
@class PageOneView;
@class SecondModel;
@class HMSegmentedControl;

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong ,nonatomic) UIColor *backColor;
@property (nonatomic, strong) PageOneView *secondView;
@property (nonatomic, strong) SecondModel *secondModel;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
- (void)registeTableViewCell;
- (void)setupSegmentedControl;
- (void)setupPageViewController;
@end

NS_ASSUME_NONNULL_END
