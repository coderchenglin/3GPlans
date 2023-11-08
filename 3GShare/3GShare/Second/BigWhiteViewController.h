//
//  BigWhiteViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import <UIKit/UIKit.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface BigWhiteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *describeArray;
@property (nonatomic, strong) UIButton *backButton;

@end

NS_ASSUME_NONNULL_END
