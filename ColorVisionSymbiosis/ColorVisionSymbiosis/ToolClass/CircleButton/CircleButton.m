//
//  CircleButton.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "CircleButton.h"

@interface CircleButton()

/*! @brief button圆形路径 */
@property(nonatomic, strong) UIBezierPath *path;
/*! @brief 圆半径 */
@property(nonatomic, assign) CGFloat radius;

@end

@implementation CircleButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    CircleButton *roundButton = [super buttonWithType:buttonType];
    if (roundButton) {
        roundButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [roundButton bringSubviewToFront:roundButton.imageView];
    }
    return roundButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self bringSubviewToFront:self.imageView];
    }
    return self;
}

- (CGFloat)radius{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat radius = width < height ? width : height;
    return radius * 0.35;
}

- (UIBezierPath *)path{
    CGPoint center = CGPointMake(self.radius, self.radius);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius startAngle:0.0f endAngle:M_PI * 2 clockwise:YES];
    [path closePath];
    return path;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = self.path.CGPath;
    self.layer.mask = shapLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
