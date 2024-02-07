//
//  RegisterView.h
//  NewStyle
//
//  Created by chenglin on 2024/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RegisterButtonDelegate <NSObject>

- (void)getButton:(UIButton *)button;

@end

@interface RegisterView : UIView

@property (nonatomic, weak) id<RegisterButtonDelegate> registerButtonDelegate;

- (void)viewInit;

@end

NS_ASSUME_NONNULL_END
