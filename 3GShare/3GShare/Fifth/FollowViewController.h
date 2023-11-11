//
//  FollowViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "FollowTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@protocol NameDelegate <NSObject>

- (void)tranName:(NSMutableArray*)nameMutableArray;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FollowViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSMutableArray *nameMutableArray;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) id<NameDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
