//
//  Person.m
//  copy修饰符
//
//  Created by chenglin on 2024/8/2.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person 


- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Person *copy = [[[self class] alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++ ) {
        objc_property_t thisProperty = propertyList[i];
        const char* propertyCName = property_getName(thisProperty);
        NSString *propertyName = [NSString stringWithCString:propertyCName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyName];
        [copy setValue:value forKey:propertyName];
    }
    return copy;
    
}

@end
