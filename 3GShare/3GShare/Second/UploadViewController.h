//
//  UploadViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import <UIKit/UIKit.h>
#import "PhotoWallViewController.h"
#import "SelectTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface UploadViewController : UIViewController<PhotoWallDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextField *describeText;
@property (nonatomic, strong) UIButton *releaseButton;
@property (nonatomic, strong) UIColor *goodColor;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UILabel *shouLabel;//展示，收回
@property (nonatomic, strong) UILabel *quantity; //?

@property UITableView *tableView;
@property UIButton *button;
@property NSMutableArray *strArr;
@property NSMutableString *str;
@property BOOL openSelect;

- (void)allinit;

@end

NS_ASSUME_NONNULL_END
