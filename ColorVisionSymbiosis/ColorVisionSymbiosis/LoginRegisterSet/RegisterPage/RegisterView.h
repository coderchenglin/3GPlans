//
//  RegisterView.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView <UITextFieldDelegate>

@property (nonatomic, strong)UIView* circleView;
@property (nonatomic, strong)UIView* whiteView;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UITextField* phoneField;
@property (nonatomic, strong)UITextField* passwordField;
@property (nonatomic, strong)UITextField* confirmPasswordField;
@property (nonatomic, strong)UIButton* registerButton;
@property (nonatomic, strong)UILabel* phoneLabel;
@property (nonatomic, strong)UILabel* passwordLabel;
@property (nonatomic, strong)UILabel* confirmPasswordLabel;
@property (nonatomic, strong)UIButton* loginByVerifying;

@end

NS_ASSUME_NONNULL_END
