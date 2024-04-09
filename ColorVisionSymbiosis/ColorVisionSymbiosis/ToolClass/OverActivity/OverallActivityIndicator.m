//
//  OverallActivityIndicator.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "OverallActivityIndicator.h"

@implementation OverallActivityIndicator

+ (OverallActivityIndicator *)sharedOverallActivityIndicator {
    //设置单例方法
    static OverallActivityIndicator* overallActivityIndicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        overallActivityIndicator = [[OverallActivityIndicator alloc] init];
    });
    return overallActivityIndicator;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        //视图的初始化
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.15];
        
        //view的初始化
        self.titleView = [[UIView alloc] initWithFrame: CGRectMake(self.frame.size.width * 5 / 14, self.frame.size.height / 2 - self.frame.size.width / 7, self.frame.size.width / 3.5, self.frame.size.width / 3.5)];
        self.titleView.layer.masksToBounds = YES;
        self.titleView.layer.cornerRadius = 3.0;
        self.titleView.backgroundColor = [UIColor colorWithRed: 33 / 255.0 green: 33 / 255.0 blue: 33 / 255.0 alpha: 0.6];
//        self.titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview: self.titleView];
        
        
        //标签的初始化
        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.frame.size.height / 2 + 20, self.frame.size.width, 30)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize: 13.9];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.titleLabel];
        
        //指示器的初始化
        UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleLarge];
        indicatorView.color = [UIColor whiteColor];
        indicatorView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [indicatorView startAnimating];
        [self addSubview: indicatorView];
    }
    
    return self;
}

+ (void)startActivity {
    //安全判断，确认指示器控件当前不在展示状态
    if ([OverallActivityIndicator sharedOverallActivityIndicator].show) return;
    
    //将指示器添加到应用的window上
    [[UIApplication sharedApplication].keyWindow addSubview: [OverallActivityIndicator sharedOverallActivityIndicator]];
    
    //更新指示器状态
    [OverallActivityIndicator sharedOverallActivityIndicator].show = YES;;
}

+ (void)stopActivity {
    if ([OverallActivityIndicator sharedOverallActivityIndicator].show) {
//        将指示器视图从其父视图上移除
        [[OverallActivityIndicator sharedOverallActivityIndicator] removeFromSuperview];
    }
    
    //更新指示器状态
    [OverallActivityIndicator sharedOverallActivityIndicator].show = NO;
}

+ (void)setText:(NSString *)text {
    [OverallActivityIndicator sharedOverallActivityIndicator].titleLabel.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
