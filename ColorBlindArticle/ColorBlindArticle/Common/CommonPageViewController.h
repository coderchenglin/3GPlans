//
//  CommonPageViewController.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/2.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonPageViewController : UIViewController

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//标题组
@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
