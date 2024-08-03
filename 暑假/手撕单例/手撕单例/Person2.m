//
//  Person2.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "Person2.h"

@implementation Person2

static Person2 *person2 = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person2 = [[super allocWithZone:NULL] init];
    });
    return person2;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Person2 sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [Person2 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person2 sharedInstance];
}


@end
