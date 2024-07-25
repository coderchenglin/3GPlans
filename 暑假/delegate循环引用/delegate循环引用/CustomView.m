//
//  CustomView.m
//  delegate循环引用
//
//  Created by chenglin on 2024/7/23.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50, 50, 100, 50);
        [button setTitle:@"Tap" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)buttonTapped {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customViewButtonTapped:)]) {
        
        [self.delegate customViewDidTapButton:@"button was tapped!"];
    }
}

@end
