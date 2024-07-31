//
//  pthread_rwlock_t_Demo.m
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import "pthread_rwlock_t_Demo.h"
#import <pthread.h>

@interface pthread_rwlock_t_Demo ()
@property (nonatomic, assign) pthread_rwlock_t rwlock;
@end

@implementation pthread_rwlock_t_Demo

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_rwlock_init(&_rwlock, NULL);
    }
    return self;
}

- (void)otherTest {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            [self read];
        });
        dispatch_async(queue, ^{
            [self write];
        });
    }
}

- (void)read {
    pthread_rwlock_rdlock(&_rwlock);
    sleep(1);
    NSLog(@"%s", __func__);
    pthread_rwlock_unlock(&_rwlock);
}

- (void)write {
    pthread_rwlock_wrlock(&_rwlock);
    sleep(1);
    NSLog(@"%s", __func__);
    pthread_rwlock_unlock(&_rwlock);
}

- (void)dealloc {
    pthread_rwlock_destroy(&_rwlock);
}

@end
