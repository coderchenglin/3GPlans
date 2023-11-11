//
//  MyImformationViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "MyInformationTableViewCell.h"
#import "FollowViewController.h"
#import "LetterViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface MyInformationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *numberArray;
@property (nonatomic, strong) NSMutableArray *nameMutableArray;


@end

NS_ASSUME_NONNULL_END
