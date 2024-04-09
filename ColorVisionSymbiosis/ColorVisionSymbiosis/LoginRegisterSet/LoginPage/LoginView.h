//
//  LoginView.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView <UITextFieldDelegate>

@property (nonatomic, strong)UIView* circleView;
@property (nonatomic, strong)UIView* whiteView;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UITextField* phoneField;
@property (nonatomic, strong)UITextField* passwordField;
@property (nonatomic, strong)UIButton* loginButton;
@property (nonatomic, strong)UILabel* phoneLabel;
@property (nonatomic, strong)UILabel* passwordLabel;
@property (nonatomic, strong)UIButton* loginByCodeButton;
@property (nonatomic, strong)UIButton* getCodeButton;

- (void)WayOfLoginingByPassword;
- (void)WayOfLoginingByCode;

@end

NS_ASSUME_NONNULL_END
