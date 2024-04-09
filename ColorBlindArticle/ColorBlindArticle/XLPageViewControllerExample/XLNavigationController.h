//
//  XLNavigationController.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLNavigationController : UINavigationController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, strong) UIColor *barBackgourndColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *barTintColor;

@end

NS_ASSUME_NONNULL_END
