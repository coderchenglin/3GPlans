//
//  ChangeViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ChangeViewController : UIViewController

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *tipsArray;
@property (nonatomic, strong) UILabel *originalLabel;
@property (nonatomic, strong) UITextField *original;
@property (nonatomic, strong) UILabel *changeLabel;
@property (nonatomic, strong) UITextField *change;
@property (nonatomic, strong) UILabel *changeAgainLabel;
@property (nonatomic, strong) UITextField *changeAgain;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIColor *goodColor;

@end

NS_ASSUME_NONNULL_END
