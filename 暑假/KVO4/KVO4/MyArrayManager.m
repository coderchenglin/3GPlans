//
//  MyArrayManager.m
//  KVO4
//
//  Created by chenglin on 2024/8/3.
//

#import "MyArrayManager.h"

@implementation MyArrayManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _models = [NSMutableArray array];
    }
    return self;
}

- (void)addModel:(MyModel *)model {
    [[self mutableArrayValueForKey:@"models"] addObject:model];
}

- (void)removeModelAtIndex:(NSUInteger)index {
    [[self mutableArrayValueForKey:@"models"] removeObjectAtIndex:index];
}

- (void)replaceModelAtIndex:(NSUInteger)index withModel:(MyModel *)model {
    [[self mutableArrayValueForKey:@"models"] replaceObjectAtIndex:index withObject:model];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    BOOL automatic = NO;
    if ([key isEqualToString:@"name"]) {
        automatic = YES;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}

+ (BOOL)automaticallyNotifiesObserversOfModels {
    return NO;
}

@end
