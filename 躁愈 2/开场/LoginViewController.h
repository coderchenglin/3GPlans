//
//  LoginViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/28.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *topic;
@property (nonatomic, strong) UILabel *subTopic;

@property(retain, nonatomic)UITextField *textField1;
@property(retain, nonatomic)UITextField *textField2;

@property (strong, nonatomic) UIButton *verifyBtn;
@property (strong, nonatomic) UIButton *loginBtn;
@property (nonatomic, strong) UIButton* backButton;
@property (strong, nonatomic) FMDatabase *dataBase;

@end

NS_ASSUME_NONNULL_END
