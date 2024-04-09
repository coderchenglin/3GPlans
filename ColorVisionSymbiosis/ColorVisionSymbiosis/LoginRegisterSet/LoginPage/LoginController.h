//
//  LoginController.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "Manager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginController : UIViewController

@property (nonatomic, strong)Manager* manager;

@property (nonatomic, strong)LoginView* loginView;

@end

NS_ASSUME_NONNULL_END
