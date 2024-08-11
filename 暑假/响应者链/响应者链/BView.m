//
//  BView.m
//  响应者链
//
//  Created by chenglin on 2024/8/3.
//

#import "BView.h"

@implementation BView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super hitTest:point withEvent:event];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super pointInside:point withEvent:event];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触摸对象
    UITouch *touch = [touches anyObject];
    //获取前一个触摸点位置
    CGPoint prePoint = [touch previousLocationInView:self];
    //获取当前触摸点位置
    CGPoint curPoint = [touch locationInView:self];
    //计算偏移量
    CGFloat offsetX = curPoint.x - prePoint.x;
    CGFloat offsetY = curPoint.y - prePoint.y;
    //相对之前的位置偏移视图
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end
