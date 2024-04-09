//
//  FirstViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import <UIKit/UIKit.h>
@class FirstView;
@class FirstModel;
NS_ASSUME_NONNULL_BEGIN

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) FirstModel *homeModel;
@property (nonatomic, strong) FirstView *homeView;
@property (strong ,nonatomic) UIColor *backColor;
- (void)registeTableViewCell;
@end

NS_ASSUME_NONNULL_END
