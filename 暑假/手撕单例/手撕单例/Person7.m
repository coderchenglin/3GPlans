//
//  Person7.m
//  手撕单例
//
//  Created by chenglin on 2024/8/6.
//

#import "Person7.h"

static Person7 *person7 = nil;

@implementation Person7 

+ (instancetype)sharedInstance {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person7 = [[super allocWithZone:NULL] init];
    });
}

- (id)copyWithZone:(NSZone *)zone {
    return [Person7 sharedInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [Person7 sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Person7 sharedInstance];
}


@end
