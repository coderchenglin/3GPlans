//
//  AView.m
//  响应者链
//
//  Created by chenglin on 2024/8/3.
//

#import "AView.h"

@implementation AView

//方法返回的view是最合适的view
//point point坐标系是当前坐标系，代表当前触摸点在当前视图中的位置
//event 事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //父视图调用hitTest方法，判断当前触摸点在哪个视图中
    //返回哪个视图就说明当前触摸点在哪个视图中，在不重写父视图hitTest的情况下由系统判断，
    //返回nil，说明触摸点，不在当前视图以及其子视图中，
    UIView *view = [super hitTest:point withEvent:event];
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01 || !self.dv) {
        return nil;
    }
    if (view == nil) {
        //将父视图坐标系转换为自己（子视图）的坐标系
        //point坐标系是当前视图坐标系，代表当前触摸点在当前视图中的位置，
        //converPoint坐标系是子视图坐标系，代表触摸点在子视图中的位置，以当前子视图左上角为原点
        UIView *sub = self.dv;
        CGPoint converPoint = [sub convertPoint:point fromView:self];
        //判断转换后的点在不在当前子视图上，
        if ([sub pointInside:converPoint withEvent:event]) {
            return sub;
        } else {
            return view;
        }
//        这种方法也可以，实际上也是调用了pointInset
//        UIView *targetView = [sub hitTest:converPoint withEvent:event];
//        if (targetView) {
//            return targetView;
//        } else {
//            return targetView;
//        }
    }
    //如果在父视图找到了最合适的view，就返回这个最合适的view
    return view;
}

@end
