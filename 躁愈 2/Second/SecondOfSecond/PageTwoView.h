//
//  PageTwoView.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageTwoView : UIView<UITableViewDataSource, UITableViewDelegate>
- (void)addTableView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;//小菊花
- (void)showLoadMoreView;
- (void)hideLoadMoreView;
@end

NS_ASSUME_NONNULL_END
