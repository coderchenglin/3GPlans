//
//  FifthViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>
#import "SetTableViewCell.h"
#import "PersonTableViewCell.h"

#import "MyUpViewController.h"
#import "MyInformationViewController.h"
#import "MyRecommendViewController.h"
#import "SetUpViewController.h"



#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface FifthViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;




@end

NS_ASSUME_NONNULL_END
