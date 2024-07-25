//
//  CustomView.h
//  delegate循环引用
//
//  Created by chenglin on 2024/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomViewDelegate <NSObject>

- (void)customViewDidTapButton:(NSString *)info;

@end

@interface CustomView : UIView

@property (nonatomic, strong) id<CustomViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
