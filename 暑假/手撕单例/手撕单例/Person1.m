//
//  Person1.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "Person1.h"

@implementation Person1

static Person1 *person = nil;

+ (nonnull instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person = [[super allocWithZone:NULL] init];
    });
    return person;
    
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [Person1 sharedInstance];
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [Person1 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person1 sharedInstance];
}


@end
