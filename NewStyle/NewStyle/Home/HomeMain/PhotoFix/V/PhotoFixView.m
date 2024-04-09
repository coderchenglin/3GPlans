//
//  PhotoFixView.m
//  NewStyle
//
//  Created by chenglin on 2024/2/11.
//

#import "PhotoFixView.h"
#import "Masonry.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PhotoFixView ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *nameArray;  //名字数组
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator; //小菊花
@property (nonatomic, strong) UIButton *shareButton; //保存和分享按钮
@property (nonatomic, strong) UIView *keepOutView;  //遮挡按钮view

@end

@implementation PhotoFixView

- (void)viewInit {
    self.nameArray = @[@"就图片修复",@"人像动漫化",@"图片去雾",@"增强对比度", @"图片清晰化", @"黑白图片上色", @"图片色彩增强"];
    [self titleInit];
    [self mainImageViewInit];
    [self activityIndicatorInit];
    [self buttonInit];
}

- (void)titleInit {
    
    self.backgroundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f) blue:(18.0f / 255.0f) alpha:1.0f];
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.backButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"fanhui.png"]] forState:UIControlStateNormal];
    self.backButton.tag = 666;
    [self addSubview:self.backButton];
    //状态栏高度
    NSSet *set = [UIApplication sharedApplication].connectedScenes;
    UIWindowScene *windowScene = [set anyObject];
    UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if(statusBarManager.statusBarFrame.size.height < 30) {
            make.top.equalTo(self).offset(43 - 20);
        } else {
            make.top.equalTo(self).offset(43);
        }
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.top.equalTo(self).offset(43);
        make.left.equalTo(self).offset(20);
    }];
    
    [self.backButton addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.nameArray[self.numberOfFix];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (statusBarManager.statusBarFrame.size.height < 30) {
            make.top.equalTo(self).offset(45 - 20);
        } else {
            make.top.equalTo(self).offset(45);
        }
        make.height.equalTo(@30);
        make.width.equalTo(@(0.6 * SIZE_WIDTH));
        make.left.equalTo(self).offset(SIZE_WIDTH / 2 - 0.3 * SIZE_WIDTH);
    }];
}

//图片初始化
- (void)mainImageViewInit {
    self.mainImageView = [[UIImageView alloc] init];
    self.mainImageView.image = self.oldImage;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.mainImageView];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-300);
    }];
}

//小菊花
- (void)activityIndicatorInit {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self.mainImageView addSubview:self.activityIndicator];
    //设置小菊花的frame
    self.activityIndicator.frame = CGRectMake((SIZE_WIDTH - 40) / 2 - 100, (SIZE_HEIGHT - 400) / 2 - 100, 200, 200);
    self.activityIndicator.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    [self.activityIndicator startAnimating];
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor whiteColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor clearColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES时，刚进入界面不会显示
    self.activityIndicator.hidesWhenStopped = NO;
}

- (void)buttonInit {
    NSArray *array = @[@"保存到相册",@"分享到SHARE"];
    for (int i = 0; i < 2; i++) {
        self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.shareButton.frame = CGRectMake(40, 630 + i * 85, SIZE_WIDTH - 80, 60);
        self.shareButton.layer.masksToBounds = YES;
        self.shareButton.layer.cornerRadius = 0.03 * SIZE_WIDTH;
        self.shareButton.tintColor = [UIColor whiteColor];
        self.shareButton.titleLabel.font = [UIFont systemFontOfSize:23];
        [self.shareButton setTitle:array[i] forState:UIControlStateNormal];
        self.shareButton.backgroundColor = [UIColor colorWithRed:(17.0f / 255.0f) green:(132.0f / 255.0f) blue:(253.0f / 255.0f) alpha:1.0f];
        self.shareButton.tag = i;
        [self.shareButton addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareButton];
    }
    self.keepOutView = [[UIView alloc] initWithFrame:CGRectMake(40, 630, SIZE_WIDTH - 80, 145)];
    self.keepOutView.backgroundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f) blue:(18.0f / 255.0f) alpha:1.0f];
    [self addSubview:self.keepOutView];

}

- (void)buttonReturn:(UIButton *)button {
    [self.buttondelegate getButton:button];
}

//网络请求完成时
- (void)requestBack {
    self.activityIndicator.hidden = YES;
    [self sendSubviewToBack:self.keepOutView];
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
