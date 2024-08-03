//
//  Person4.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "Person4.h"

static Person4 *person4 = nil;

@implementation Person4

+ (instancetype)sharedInstance {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person4 = [[super allocWithZone:NULL] init];
    });
    return person4;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Person4 sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [Person4 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person4 sharedInstance];
}

@end
