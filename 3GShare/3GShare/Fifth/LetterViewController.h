//
//  LetterViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "FollowTableViewCell.h"


#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface LetterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSArray *desArray;

@end

NS_ASSUME_NONNULL_END
