//
//  OSSpinLockDemo.m
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()
@property (nonatomic, assign) OSSpinLock moneylock;
@property (nonatomic, assign) OSSpinLock ticketLock;
@end

@implementation OSSpinLockDemo

- (instancetype)init {
    if (self = [super init]) {
        self.moneylock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__drawMoney {
    OSSpinLockLock(&_moneylock);
    
    [super __drawMoney];
    
    OSSpinLockUnlock(&_moneylock);
}

- (void)__saveMoney {
    OSSpinLockLock(&_moneylock);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&_moneylock);
}

- (void)__saleTicket {
    OSSpinLockLock(&_ticketLock);
    
    [super __saleTicket];
    
    OSSpinLockUnlock(&_ticketLock);
}


@end
