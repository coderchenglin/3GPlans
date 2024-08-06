//
//  Person6.m
//  手撕单例
//
//  Created by chenglin on 2024/8/3.
//

#import "Person6.h"

@implementation Person6

static Person6 *person6 = nil;

+ (instancetype)sharedInstance {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person6 = [[super allocWithZone:NULL] init];
    });
    return person6;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Person6 sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [Person6 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person6 sharedInstance];
}

@end
