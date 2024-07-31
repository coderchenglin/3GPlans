//
//  os_unfair_lockDemo.m
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import "os_unfair_lockDemo.h"
#import <os/lock.h>

@interface os_unfair_lockDemo ()
@property (nonatomic, assign) os_unfair_lock ticketLock;
@end

@implementation os_unfair_lockDemo

- (instancetype)init {
    self = [super init];
    if (self) {
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)__saleTicket {
    os_unfair_lock_lock(&_ticketLock);
    
    [super __saleTicket];
    
    os_unfair_lock_unlock(&_ticketLock);
}

@end
