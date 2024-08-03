//
//  Person5.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "Person5.h"

@implementation Person5

static Person5 *person5 = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person5 = [[super allocWithZone:NULL] init];
    });
    return person5;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Person5 sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [Person5 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person5 sharedInstance];
}

@end
