//
//  ViewController.m
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import "ViewController.h"
#import "BaseDemo.h"

#import "OSSpinLockDemo.h"
#import "os_unfair_lockDemo.h"
#import "pthread_mutexDemo.h"
#import "pthread_rwlock_t_Demo.h"

@interface ViewController ()

@property (nonatomic, strong) BaseDemo *demo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    pthread_rwlock_t_Demo *demo = [[pthread_rwlock_t_Demo alloc] init];
    //[demo ticketTest];
//    [demo moneyTest];
    [demo otherTest];
    
}


@end
