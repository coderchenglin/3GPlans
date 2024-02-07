//
//  PhotoFixView.h
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import <UIKit/UIKit.h>

@protocol ButtonDelegate <NSObject>

- (void)getButton:(UIButton *_Nullable)button;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFixView : UIView

- (void)viewInit;
- (void)requestBack; //网络请求完成
@property (nonatomic, weak) id<ButtonDelegate> buttonDelegate;
@property (nonatomic, assign) int numberOfFix; //记录第几个功能
@property (nonatomic, strong) UIImage *oldImage; //传入的修复前照片
@property (nonatomic, strong) UIImageView *mainImageView; //图片放置区域


@end

NS_ASSUME_NONNULL_END
