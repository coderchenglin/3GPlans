//
//  LoginView.h
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//定义协议
@protocol LoginButtonDelegate <NSObject>

- (void)getButton:(UIButton *)button;

@end


@interface LoginView : UIView

@property (nonatomic, weak) id<LoginButtonDelegate>loginButtonDelegate; //协议属性

- (void)viewInit;

@end

NS_ASSUME_NONNULL_END
