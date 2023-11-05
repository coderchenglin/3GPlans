//
//  FirstViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>
#import "ShowTableViewCell.h"
#import "RollTableViewCell.h"
#import "ContentViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *describeArray;
@property (nonatomic, copy) NSArray *timeArray;
@property (nonatomic, copy) NSArray *tipsArray;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSInteger lookNumber;
@property (nonatomic, assign) NSInteger shareNumber;
@property (nonatomic, strong) NSString *good;
@property (nonatomic, strong) NSString *look;
@property (nonatomic, strong) NSString *share;


@end

NS_ASSUME_NONNULL_END
