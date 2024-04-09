//
//  UITextField+UnEditableTextField.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/29.
//

//#import <Foundation/Foundation.h>
#import "UITextField+UnEditableTextField.h"
//#import "objc/runtime.h"

@implementation UITextField (UnEditableTextField)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"zxc");
    return NO;
}

@end
