//
//  ViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/2.
//

#import <UIKit/UIKit.h>
@class View;
@interface ViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong)View *beginView;
- (void)createTabToJump;
@property (nonatomic, strong)UIColor *colorOfBack;
@property (nonatomic, strong)UIColor *darkerColorOfBack;
- (UIColor*)mostColor:(UIImage*)Image;
- (UIColor*)mostDarkerColor:(UIImage*)Image;
- (void)firstLoginBtn;
@end

