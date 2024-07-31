//
//  pthread_mutexDemo.m
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import "pthread_mutexDemo.h"
#import <pthread.h>
@interface pthread_mutexDemo()
@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@property (assign, nonatomic) pthread_mutex_t ticketMutex2;
@end

@implementation pthread_mutexDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
        // 初始化锁
        pthread_mutex_init(&(_ticketMutex), &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
    }
    return self;
}

//卖票
//- (void)__saleTicket {
//    pthread_mutex_lock(&_ticketMutex);
//
//    [super __saleTicket];
//
//    pthread_mutex_unlock(&_ticketMutex);
//}


//死锁情况
//- (void)__saleTicket {
//    pthread_mutex_lock(&_ticketMutex);
//    [super __saleTicket];
//    [self performSelectorInBackground:@selector(__saleTicket2) withObject:nil];
//    pthread_mutex_unlock(&_ticketMutex);
//}
//
//- (void)__saleTicket2 {
//    pthread_mutex_lock(&_ticketMutex);
//    NSLog(@"%s", __func__);
//    pthread_mutex_unlock(&_ticketMutex);
//}






@end
