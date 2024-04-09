//
//  XLNavigationController.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/1.
//

#import "XLNavigationController.h"

@interface XLNavigationController ()

@end

@implementation XLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO; //不透明
    
//    UINavigationBarAppearance* appearance = [[UINavigationBarAppearance alloc] init];
//    appearance.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.standardAppearance = appearance;
//    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    
//    self.navigationController.
    
}

#pragma mark -
#pragma mark Setter
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate]; //设置状态栏状态的方法
}

- (void)setTitleColor:(UIColor *)titleColor {
    NSDictionary *attributes = @{NSForegroundColorAttributeName:titleColor};
    [self.navigationBar setTitleTextAttributes:attributes];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    self.navigationBar.tintColor = barTintColor;
}

- (void)setBarBackgourndColor:(UIColor *)barBackgourndColor {
    for (UIView *view in self.navigationBar.subviews) {
        if ([view isMemberOfClass:NSClassFromString(@"_UIBarBackground")]) {
            view.backgroundColor = barBackgourndColor;
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


