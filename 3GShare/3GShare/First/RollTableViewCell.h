//
//  RollTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface RollTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl* pageControl;  //学习使用这个控件

@end

NS_ASSUME_NONNULL_END
