//
//  PersonTool.m
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import "PersonTool.h"

@implementation PersonTool

static PersonTool *_instance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone { 
    return [PersonTool sharedInstance];
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone { 
    return [PersonTool sharedInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [PersonTool sharedInstance];
}

@end
