//
//  Person.m
//  isMemberOfClass
//
//  Created by chenglin on 2024/7/19.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"[self class] = %@",[self class]);
        NSLog(@"[super class] = %@",[super class]);
        NSLog(@"============");
        NSLog(@"[self superclass] = %@",[self superclass]);
        NSLog(@"[super superclass] = %@",[super superclass]);
    }
    return self;
}

@end
