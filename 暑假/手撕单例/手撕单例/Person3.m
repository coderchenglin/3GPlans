//
//  Person3.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "Person3.h"

@implementation Person3

static Person3 *person3;

+ (instancetype)sharedInstance {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person3 = [[super allocWithZone:NULL] init];
    });
    return person3;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Person3 sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [Person3 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person3 sharedInstance];
}

@end
