//
//  OverallActivityIndicator.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverallActivityIndicator : UIView

@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIView* titleView;
@property (nonatomic, assign)BOOL show;

//获取单例对象
+ (OverallActivityIndicator *)sharedOverallActivityIndicator;

//开始展示活动指示器
+ (void)startActivity;
//停止展示活动指示器
+ (void)stopActivity;

//设置活动展示器的提示文案
+ (void)setText: (NSString *)text;

@end

NS_ASSUME_NONNULL_END
