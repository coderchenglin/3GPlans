//
//  PhotoFixView.m
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import "PhotoFixView.h"
#import "Masonry.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PhotoFixView ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSArray *nameArray;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator; //小菊花
@property (nonatomic, strong) UIButton *shareButton; //保存和分享按钮
@property (nonatomic, strong) UIView *keepOutView;  //遮挡按钮view

@end

@implementation PhotoFixView

- (void)viewInit {
    self.nameArray = @[@"旧图片修复", @"人像动漫化", @"图片去雾", @"增强对比度", @"图片清晰化", @"黑白图片上色", @"图片色彩增强"];
    [self titleInit];
    //[self mainImageViewInit];
    //[self activityIndicatorInit];
    //[self buttonInit];
}

//标题栏初始化
- (void)titleInit {
    
    self.backgroundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f) blue:(18.0f / 255.0f) alpha:1.0f];
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.backButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"fanhui.png"]] forState:UIControlStateNormal];
    self.backButton.tag = 666;
    [self addSubview:self.backButton];
    //状态栏高度
    NSSet *set = [UIApplication sharedApplication].connectedScenes;
    UIWindowScene *windowScene = [set anyObject];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
