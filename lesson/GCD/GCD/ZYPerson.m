//
//  ZYPerson.m
//  GCD
//
//  Created by chenglin on 2024/7/25.
//

#import "ZYPerson.h"

@interface ZYPerson ()

@end



static NSString *_name;
static dispatch_queue_t _concurrentQueue;

@implementation ZYPerson
- (instancetype)init
{
    if (self = [super init]) {
        _concurrentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
- (void)setName:(NSString *)name
{
    dispatch_barrier_async(_concurrentQueue, ^{
        _name = [name copy];
    });
}
- (NSString *)name
{
    __block NSString *tempName;
    dispatch_sync(_concurrentQueue, ^{
        tempName = _name;
    });
    return tempName;
}

@end
