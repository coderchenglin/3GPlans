//
//  MyClass+MyProperty.m
//  Category
//
//  Created by chenglin on 2024/7/23.
//

#import "MyClass+MyProperty.h"
#import <objc/runtime.h>

static const void* myPropertyKey = &myPropertyKey; //这是代码规范，用于生成一个全局唯一的key

@implementation MyClass (MyProperty)

- (NSString *)myProperty {
    return objc_getAssociatedObject(self, myPropertyKey); //传一个全局唯一的key
}

- (void)setMyProperty:(NSString *)myProperty {
    objc_setAssociatedObject(self, "abc", myProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}


@end
