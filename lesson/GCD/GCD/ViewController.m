//
//  ViewController.m
//  GCD
//
//  Created by chenglin on 2024/6/3.
//

#import "ViewController.h"
#import "ZYPerson.h"
#import "MyOperation.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
////    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
//
//    //异步
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务1 - %@", [NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务2 - %@", [NSThread currentThread]);
//    });
//
//    //同步
//    dispatch_sync(queue, ^{
//        NSLog(@"执行任务3 - %@", [NSThread currentThread]);
//    });
//    dispatch_sync(queue, ^{
//        NSLog(@"执行任务4 - %@", [NSThread currentThread]);
//    });
//    //异步
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务5 - %@", [NSThread currentThread]);
//    });
//    //同步
//    dispatch_sync(queue, ^{
//        NSLog(@"执行任务6 - %@", [NSThread currentThread]);
//    });
//
////    2024-06-03 19:51:50.564585+0800 GCD[17212:858722] 执行任务3 - <_NSMainThread: 0x600003508440>{number = 1, name = main}
////    2024-06-03 19:51:50.564611+0800 GCD[17212:858886] 执行任务1 - <NSThread: 0x600003541500>{number = 7, name = (null)}
////    2024-06-03 19:51:50.564612+0800 GCD[17212:858887] 执行任务2 - <NSThread: 0x600003502f40>{number = 5, name = (null)}
////    2024-06-03 19:51:50.564729+0800 GCD[17212:858722] 执行任务4 - <_NSMainThread: 0x600003508440>{number = 1, name = main}
////    2024-06-03 19:51:50.564866+0800 GCD[17212:858722] 执行任务6 - <_NSMainThread: 0x600003508440>{number = 1, name = main}
////    2024-06-03 19:51:50.564877+0800 GCD[17212:858887] 执行任务5 - <NSThread: 0x600003502f40>{number = 5, name = (null)}
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //第一个参数传优先级，第二个参数就传0
//    //用于获取全局并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    //等价写法：
//    //dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_async(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务一    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务二    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL); //    创建一个穿行队列
//
//    dispatch_async(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务一    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务二    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//
//
//}




//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //1.串行队列
//    //  先执行任务一再执行任务二
//    //2.不管是穿行队列还是并行队列，只要用同步函数，都是按顺序执行
//    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL); //    创建一个穿行队列
//
//    dispatch_async(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务一    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"执行任务二    %d - %@", i, [NSThread currentThread]);
//        }
//    });
//}
//
//


//
//- (void)interView01 {
////    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务2 - %@", [NSThread currentThread]);
//    });
//}

//- (void)interView02 {
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_sync(queue, ^{
//        NSLog(@"执行任务2 - %@", [NSThread currentThread]);
//    });
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self interView01];
//    NSLog(@"执行任务1");
//    [self interView01];
//    NSLog(@"执行任务3");
//    [self interView01];
//}
//执行结果：
//2024-06-05 16:56:26.487515+0800 GCD[66975:2260994] 执行任务1
//2024-06-05 16:56:26.487568+0800 GCD[66975:2260994] 执行任务3
//2024-06-05 16:56:26.539759+0800 GCD[66975:2260994] 执行任务2 - <_NSMainThread: 0x600000524000>{number = 1, name = main}
//2024-06-05 16:56:26.539818+0800 GCD[66975:2260994] 执行任务2 - <_NSMainThread: 0x600000524000>{number = 1, name = main}
//2024-06-05 16:56:26.539860+0800 GCD[66975:2260994] 执行任务2 - <_NSMainThread: 0x600000524000>{number = 1, name = main}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSLog(@"执行任务1");
////    [self interView02];
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_sync(queue, ^{
//        NSLog(@"执行任务2 - %@", [NSThread currentThread]);
//    });
//    //NSLog(@"执行任务3");
//}
//执行结果：死锁
//
////给sync方法中传主队列，会产生死锁原因：
////1.首先这是一个队列，先进先出，需要等该队列中上一个任务执行完，才能执行这个block任务：
////^{
////NSLog(@"执行任务2 - %@", [NSThread currentThread]);
////});
////2.由于该线程是主队列，主队列的上一个任务是什么呢？上一个任务就是viewDidload方法
////3.而sync方法代表，立即在当前线程执行该任务
//
////也就是说，按照线程的先进先出，必须要等 NSLog(@"执行任务3")打印完，viewDidLoad方法执行完，才能去执行block任务。
////但要想执行这个打印函数，必须先把sync函数过掉，而sync函数意味着要立即执行加入的block方法，也就是说必须把该block方法执行完，才能继续往后执行
////因此造成死锁
//
////这里最不容易想到的是，串行队列的任务，需要执行完上一个任务才能执行下一个任务，而任务是什么？任务就是block块或者函数，方法，要想到在主线程中，viewDidload方法，就是一个任务，这个任务执行完，才能执行下一个
////这也就好理解，如果不是sync函数而是async函数，那么一定是先把viewDidLoad方法里的内容全部执行完才会执行async函数里的内容




//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    NSLog(@"执行任务1");
//
//    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务2");
//
//        dispatch_sync(queue, ^{
//            NSLog(@"执行任务3");
//        });
//
//        NSLog(@"执行任务4");
//    });
//
//    NSLog(@"执行任务5");
//
//    //结果：
//    //2024-06-05 16:54:14.351680+0800 GCD[66913:2259121] 执行任务1
//    //2024-06-05 16:54:14.351732+0800 GCD[66913:2259121] 执行任务5
//    //2024-06-05 16:54:14.351747+0800 GCD[66913:2259273] 执行任务2
//    //这段代码稍作分析可知道，也会产生死锁，是在子线程中产生死锁
//}




//- (void)interview04 {
//    NSLog(@"执行任务1");
//
//    dispatch_queue_t queue =  dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue2 =  dispatch_queue_create("myqueue2", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue3 =  dispatch_queue_create("myqueue2", DISPATCH_QUEUE_SERIAL);
//
//    //给异步方法传串行队列：创建新的子线程，串行执行
//    dispatch_async(queue, ^{ // block0
//        NSLog(@"执行任务2");
//        //给同步方法传并发队列：在当前线程，串行执行
//        dispatch_sync(queue2, ^{ // block1
//            NSLog(@"执行任务3");
//        });
//
//        NSLog(@"执行任务4");
//    });
//
//    NSLog(@"执行任务5");
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self interview04];
//
////结果：不会死锁
////    2024-06-05 17:03:22.700255+0800 GCD[67169:2266826] 执行任务1
////    2024-06-05 17:03:22.700320+0800 GCD[67169:2266826] 执行任务5
////    2024-06-05 17:03:22.700324+0800 GCD[67169:2266934] 执行任务2
////    2024-06-05 17:03:22.700366+0800 GCD[67169:2266934] 执行任务3
////    2024-06-05 17:03:22.700401+0800 GCD[67169:2266934] 执行任务4
//
////为什么不会死锁？
////因为queue和queue2是两个不同的队列，block0在队列queue中，block1在队列queue2中
//    //整体是将这两个队列中的任务，放在同一个子线程中顺序执行
//
//}




//- (void)interview05 {
//    NSLog(@"执行任务1");
//
//    dispatch_queue_t queue =  dispatch_queue_create("myqueue2", DISPATCH_QUEUE_CONCURRENT);
//
//    //给异步方法传串行队列：创建新的子线程，串行执行
//    dispatch_async(queue, ^{ // block0
//        NSLog(@"执行任务2");
//        //给同步方法传并发队列：在当前线程，串行执行
//        dispatch_sync(queue, ^{ // block1
//            NSLog(@"执行任务3");
//        });
//
//        NSLog(@"执行任务4");
//    });
//
//    NSLog(@"执行任务5");
//}
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self interview05];
//
//
////结果：不会死锁
////    2024-06-05 17:21:45.990981+0800 GCD[67642:2280956] 执行任务1
////    2024-06-05 17:21:45.991046+0800 GCD[67642:2280956] 执行任务5
////    2024-06-05 17:21:45.991051+0800 GCD[67642:2281256] 执行任务2
////    2024-06-05 17:21:45.991108+0800 GCD[67642:2281256] 执行任务3
////    2024-06-05 17:21:45.991145+0800 GCD[67642:2281256] 执行任务4
//
//    //不会死锁的原因，虽然是同一个队列，
//    //但是因为队列是并发队列，给到异步方法，整体就是一个并发执行，因此不会产生死锁
//
//}






//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);  //这是一个全局的并发队列，只有一个
//    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
//    dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);  //这是自己创建的并发队列
//    dispatch_queue_t queue4 = dispatch_queue_create("queue4", DISPATCH_QUEUE_CONCURRENT);
//
//    NSLog(@"%p %p %p %p", queue1, queue2, queue3, queue4);
//    //0x104d2d2c0 0x104d2d2c0 0x600001140380 0x600001140500
//
//    //  dispatch_queue_t本质就是一个指针
//}


//进程间通信
//- (void)communication {
//    // 获取全局并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 获取主队列
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//
//    dispatch_sync(queue, ^{
//        // 异步追加任务
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//
//        // 回到主线程
//        dispatch_async(mainQueue, ^{
//            // 追加在主线程中执行的任务
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
//
//    NSLog(@"==");
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self communication];
//}



//- (void)read {
//    dispatch_async(self.queue, ^{
//        sleep(1);
//        NSLog(@"read");
//    });
//}
//
//- (void)write {
//    dispatch_barrier_async(self.queue, ^{
//        sleep(1);
//        NSLog(@"write");
//    });
//
////    dispatch_async(self.queue, ^{
////        sleep(1);
////        NSLog(@"write");
////    });
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
//
//    for (int i = 0; i < 10; i++) {
//        [self read];
//        [self read];
//        [self read];
//        [self write];
//    }
//
//
//}


//5.2、GCD 延时执行方法：dispatch_after
//- (void)after {
//    NSLog(@"currentThread ---%@", [NSThread currentThread]); //打印当前线程
//    NSLog(@"asyncMain---begin");
//
//    dispatch_after(dispatch_time(DISPATCH_WALLTIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //2秒后异步追加任务代码到主队列，并开始执行
//        NSLog(@"after---%@", [NSThread currentThread]); //打印当前线程
//    });
//}

//5.3、GCD 一次性代码（只执行一次）：dispatch_once

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //[self after];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //只执行一次的代码，里面默认说线程安全的
//    });
//
//}



//5.4 GCD队列组：dispatch_group

//- (void)groupNotify {
//    NSLog(@"currentThread---%@", [NSThread currentThread]);
//    NSLog(@"group -- begin");
//
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //追加任务1
//        for (int i = 0; i < 5; i++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"1---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //追加任务2
//        for (int i = 0; i < 2; i++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"2 ---- %@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //等前面的异步任务1，任务2都执行完毕后，回道主线程执行下边任务
//        for (int i = 0; i < 2; i++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"3---%@", [NSThread currentThread]);
//        }
//        NSLog(@"group---end");
//    });
//
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self groupNotify];
//
//}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue, ^{
//        NSLog(@"任务1");
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"任务2");
//        });
//
//        NSLog(@"任务3");
//    });
//
//}


//- (void)communication {
//    //获取全局并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//
//    dispatch_async(queue, ^{
//        //异步追加任务
//        for (int i = 0; i < 2; i++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"1----%@", [NSThread currentThread]);
//        }
//
//        //回到主线程
//        dispatch_async(mainQueue, ^{
//            //追加在主线程执行的任务
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"2----%@", [NSThread currentThread]);
//        });
//    });
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //[self communication];
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //信号量初始化必须大于等于0， 因为dispatch_semaphore_wait 执行的是-1操作。
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    //创建异步队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//
//        sleep(1);
//        NSLog(@"执行任务: A");
//        //让信号量+1
////        dispatch_semaphore_signal(semaphore);
//    });
//
//    //当当前的信号量值为0时候会阻塞线，如果大于0的话，信号量-1，不阻塞线程.(相当于加锁)
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    dispatch_async(queue, ^{
//
//        sleep(1);
//        NSLog(@"执行任务: B");
//        //让信号量+1（相当于解锁）
//        dispatch_semaphore_signal(semaphore);
//    });
//
//    //当当前的信号量值为0时候会阻塞线，如果大于0的话，信号量-1，不阻塞线程
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    dispatch_async(queue, ^{
//
//        sleep(1);
//        NSLog(@"执行任务: C");
//        dispatch_semaphore_signal(semaphore);
//    });
//
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //设置最大开辟的线程数为3
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
//    //创建一个并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    //开启的是10个异步的操作，通过信号量，让10个异步的最多3个m，剩下的同步等待
//    for (NSInteger i = 0; i < 10; i++) {
//
//        dispatch_async(queue, ^{
//            //当信号量为0时候，阻塞当前线程
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            NSLog(@"执行任务 %ld", i);
//            sleep(1);
//            NSLog(@"完成当前任务 %ld", i);
//            //释放信号
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//}

//这里出现了“优先级反转问题“

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 设置最大开辟的线程数为3
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
//
//    // 创建高优先级和低优先级队列
//    dispatch_queue_t highPriorityQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
//    dispatch_queue_t lowPriorityQueue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
//
//    for (NSInteger i = 0; i < 10; i++) {
//        dispatch_queue_t targetQueue = (i < 5) ? highPriorityQueue : lowPriorityQueue;
//        dispatch_async(targetQueue, ^{
//            // 当信号量为0时候，阻塞当前线程
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            NSLog(@"执行任务 %ld", i);
////            sleep(1);
//            NSLog(@"完成当前任务 %ld", i);
//            // 释放信号
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//}



//dispatch_after
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    NSLog(@"begin");
//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^{
//        NSLog(@"延迟执行任务");
//    });
//
//}



/**
 * 快速迭代方法 dispatch_apply
 */
//- (void)apply {
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
//
//    NSLog(@"apply---begin");
//    dispatch_apply(6, queue, ^(size_t index) {
//        NSLog(@"%zd---%@",index, [NSThread currentThread]);
//    });
//    NSLog(@"apply---end");
//}



//group


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 创建一个队列组
//    dispatch_group_t group = dispatch_group_create();
//
//    // 获取用户信息
//    dispatch_group_enter(group);
//    [self fetchUserInfo:^(UserInfo *userInfo) {
//        // 处理用户信息
//        NSLog(@"User info: %@", userInfo);
//        dispatch_group_leave(group);
//    }];
//
//    // 获取订单列表
//    dispatch_group_enter(group);
//    [self fetchOrderList:^(NSArray *orders) {
//        // 处理订单列表
//        NSLog(@"Orders: %@", orders);
//        dispatch_group_leave(group);
//    }];
//
//    // 获取优惠券列表
//    dispatch_group_enter(group);
//    [self fetchCouponList:^(NSArray *coupons) {
//        // 处理优惠券列表
//        NSLog(@"Coupons: %@", coupons);
//        dispatch_group_leave(group);
//    }];
//
//    // 等待所有任务完成
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        // 所有数据获取完成,进行最终处理
//        NSLog(@"All data fetched!");
//    });
//}





/**
 * semaphore 线程同步
 */
//- (void)semaphoreSync {
//
//    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
//    NSLog(@"semaphore---begin");
//
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//    __block int number = 0;
//    dispatch_async(queue, ^{
//        // 追加任务 1
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//
//        number = 100;
//
//        dispatch_semaphore_signal(semaphore);
//    });
//
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"semaphore---end,number = %zd",number);
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self semaphoreSync];
//
//}


//多读单写问题：
 

 
//#import "ZYPerson.h"

//- (void)stressTestReadWriteOperations {
//    ZYPerson *person = [[ZYPerson alloc] init];
//
//    // 定义读写操作次数
//    const int kOperationCount = 10;
//
//    // 创建一个 dispatch_group 来并发执行操作
//    dispatch_group_t group = dispatch_group_create();
//
//    // 执行读写操作
//    for (int i = 0; i < kOperationCount; i++) {
//        dispatch_group_async(group, dispatch_get_main_queue(), ^{
//            [person setName:[NSString stringWithFormat:@"Name %d", i]];
//            NSString *name = [person name];
//            NSLog(@"Read name: %@", name);
//        });
//    }
//
//    // 等待所有操作完成
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//
//    NSLog(@"All %d read/write operations completed.", kOperationCount);
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //[self stressTestReadWriteOperations];
//}

//- (void)viewDidLoad {
//    MyOperation *operation = [[MyOperation alloc] init];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
//
//    //sleep(3);
//    [operation cancel];
//
//}


//void downloadFragment(NSInteger fragmentIndex) {
//    // 模拟下载任务
//    NSLog(@"Downloading fragment %ld", (long)fragmentIndex);
//    [NSThread sleepForTimeInterval:1]; // 模拟网络延迟
//    NSLog(@"Downloaded fragment %ld", (long)fragmentIndex);
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    for (NSInteger i = 0; i < 5; i++) {
//        dispatch_async(concurrentQueue, ^{
//            downloadFragment(i);
//        });
//    }
//
//    dispatch_barrier_sync(concurrentQueue, ^{
//        NSLog(@"All fragments downloaded.");
//    });
//}



//并发下载碎片文件内容，用GCD和NSOperation怎么实现？

//定义一个函数，用于下载文件的一个碎片
//void downloadFragment(NSURL *url, NSInteger start, NSInteger length, NSInteger fragmentIndex, NSString *destinationPath, void (^completionHandler)(BOOL)) {
//    //创建一个可变的URL请求，设置范围头以请求文件的一部分
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSString *range = [NSString stringWithFormat:@"bytes=%ld-%ld", start, start + length - 1];
//    [request setValue:range forHTTPHeaderField:@"Range"];
//
//    // 使用共享会话创建一个NSURLSession
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    //创建一个数据任务来下载文件的碎片
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            // 如果有错误，调用完成处理程序并传递NO
//            completionHandler(NO);
//        } else {
//            // 如果没有错误，将数据写入文件
//            NSString *fragmentPath = [destinationPath stringByAppendingPathComponent:[NSString stringWithFormat:@"fragment_%ld", fragmentIndex]];
//            [data writeToFile:fragmentPath atomically:YES];
//            // 调用完成处理程序并传递YES
//            completionHandler(YES);
//        }
//    }];
//    [dataTask resume];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 定义要下载的文件URL
//    NSURL *url = [NSURL URLWithString:@"https://example.com/largefile"];
//    // 假设文件大小为1000000字节
//    NSInteger fileSize = 1000000; // 例子中的文件大小
//    // 定义每个碎片的大小为200000字节
//    NSInteger fragmentSize = 200000; // 每个小块的大小
//    // 计算需要下载的碎片数量
//    NSInteger numberOfFragments = (fileSize + fragmentSize - 1) / fragmentSize;
//    // 定义存储碎片文件的目录路径
//    NSString *destinationPath = @"/path/to/destination"; // 存放下载碎片的目录
//    // 创建一个GCD组，用于同步多个并发下载任务
//    dispatch_group_t downloadGroup = dispatch_group_create();
//    // 创建一个并发队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//    // 启动并发下载任务
//    for (NSInteger i = 0; i < numberOfFragments; i++) {
//        // 每个任务进入GCD组
//        dispatch_group_enter(downloadGroup);
//        // 计算每个碎片的起始位置和长度
//        NSInteger start = i * fragmentSize;
//        NSInteger length = MIN(fragmentSize, fileSize - start);
//
//        // 将下载任务提交到并发队列
//        dispatch_async(concurrentQueue, ^{
//            downloadFragment(url, start, length, i, destinationPath, ^(BOOL success) {
//                if (!success) {
//                    NSLog(@"Failed to download fragment %ld", (long)i);
//                } else {
//                    NSLog(@"Downloaded fragment %ld", (long)i);
//                }
//                // 每个任务完成后离开GCD组
//                dispatch_group_leave(downloadGroup);
//            });
//        });
//    }
//
//    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"All fragments downloaded.");
//        // 这里可以添加代码来将碎片合并成一个完整的文件
//    });
//
//    [[NSRunLoop currentRunLoop] run]; // 保持程序运行直到所有下载完成
//}



//- (void)viewDidLoad {
//
//    NSLog(@"start");
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    // 模拟读操作
//    void (^readBlock)(void) = ^{
//        // 读取共享资源
//        NSLog(@"Read operation - %@", [NSThread currentThread]);
//    };
//
//    // 模拟写操作
//    void (^writeBlock)(void) = ^{
//        // 写入共享资源
//        NSLog(@"Write operation - %@", [NSThread currentThread]);
//    };
//
//    // 执行读操作
//    dispatch_async(concurrentQueue, readBlock);
//    dispatch_async(concurrentQueue, readBlock);
//    dispatch_async(concurrentQueue, readBlock);
//
//    // 执行写操作
//    dispatch_barrier_sync(concurrentQueue, writeBlock);
//
//    // 再执行读操作
//    dispatch_async(concurrentQueue, readBlock);
//    dispatch_async(concurrentQueue, readBlock);
//    dispatch_async(concurrentQueue, readBlock);
//
//    NSLog(@"end");
//}

- (void)viewDidLoad {
    
    ZYPerson *obj = [[ZYPerson alloc] init];
    obj.name = @"aaa";
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"1 - %@", tmp);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"2 - %@", tmp);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"3 - %@", tmp);
    });
    
    dispatch_barrier_async(concurrentQueue, ^{
        [obj setName:@"bbb"];
        NSLog(@"%@", obj.name);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"4 - %@", tmp);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"5 - %@", tmp);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *tmp = [obj name];
        NSLog(@"6 - %@", tmp);
    });
    
}



@end

//
//同步函数和异步函数，不能决定函数是串行执行还是并行执行，只能决定能否开启新的线程执行任务，
//sync/async
//同步：在当前线程中执行，不具备开启新线程的能力
//      后面的内容需要等同步函数返回了，才能执行。所以就在当前线程执行就行，不需要开启新的线程，因此也不具备开新线程的能力
//异步：在新的线程中执行，具备开启新线程的能力（注意，是具备开新线程的能力，不一定会开启新线程）
//      后面的内容不需要等异步函数返回才执行，后面的内容可以直接执行。所以需要开启新线程，因此具备开新线程的能力
//
//==同步函数和异步函数最重要的一句理解！！！
//：同步函数后面的内容需要等同步函数返回（执行完了），才能执行。一步函数后面的内容不需要能异步函数返回才执行，可以直接执行（就好像可以跳过这个异步函数一样），而这个异步函数里面的内容就需要开启一个新线程来执行。==
//
//队列：并发和串行。主要影响任务的执行方式，能不能开启新线程取决于上面的两个函数
//并发：多个任务并发执行
//串行：一个任务执行完毕后，再执行下一个任务
//
//如何分析呢？
//首先，同步函数（sync，代表没有开新线程，一定是串行执行
//异步函数（async，代表如果需要，可以开新线程）
//如果传的是并发队列，就并发执行任务
//如果传的是手动创建的串行队列，就在子线程串行执行
//如果传的是主队列，就在主线程中串行执行
//什么情况下不会开启新线程呢？传入的是主队列
//
//
//
//
//死锁条件总结：
//往当前的串行的队列中添加任务，就会产生死锁。其他情况都不会产生死锁
//1.当前队列 （在两个不同的队列就不会）
//2.当前队列是串行队列 （并发队列就不会）



