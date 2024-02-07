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
//为避免保留环，NetworkFetcher不保留其delegate属性，使用weak，不实用strong
//在上面定义在协议以后，类LoginView就可以用一个属性来存放委托对象loginButtonDelegate了
- (void)viewInit;

@end

NS_ASSUME_NONNULL_END
