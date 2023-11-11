//
//  MyRecommendViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "ShowTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface MyRecommendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *describeArray;
@property (nonatomic, copy) NSArray *timeArray;
@property (nonatomic, copy) NSArray *tipsArray;
@property (nonatomic, strong) NSString *imageName;


@end

NS_ASSUME_NONNULL_END
