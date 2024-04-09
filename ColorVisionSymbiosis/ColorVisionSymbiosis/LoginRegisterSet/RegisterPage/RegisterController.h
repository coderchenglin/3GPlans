//
//  RegisterController.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"
#import "Manager.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterController : UIViewController

@property (nonatomic, strong)Manager* manager;
@property (nonatomic, strong)RegisterView* registerView;

@end

NS_ASSUME_NONNULL_END
