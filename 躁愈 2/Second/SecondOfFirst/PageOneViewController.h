//
//  PageOneViewController.h
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import <UIKit/UIKit.h>
@class PageOneView;
NS_ASSUME_NONNULL_BEGIN

@interface PageOneViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong ,nonatomic) UIColor *backColor;
@property (nonatomic, strong) PageOneView *secondView;
- (void)registeTableViewCell;
@end

NS_ASSUME_NONNULL_END
