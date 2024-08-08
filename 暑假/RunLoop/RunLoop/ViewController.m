//
//  ViewController.m
//  RunLoop
//
//  Created by chenglin on 2024/8/5.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

//- (void)start{
//    [self registerObserver];
//    [self startMonitor];
//}
//
//static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
//{
//    DSBlockMonitor *monitor = (__bridge DSBlockMonitor *)info;
//    monitor->activity = activity;
//    // 发送信号
//    dispatch_semaphore_t semaphore = monitor->_semaphore;
//    dispatch_semaphore_signal(semaphore);
//}
//
//- (void)registerObserver{
//    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
//    //NSIntegerMax : 优先级最小
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                                            kCFRunLoopAllActivities,
//                                                            YES,
//                                                            NSIntegerMax,
//                                                            &CallBack,
//                                                            &context);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//}
//
//- (void)startMonitor{
//    // 创建信号
//    _semaphore = dispatch_semaphore_create(0);
//    // 在子线程监控时长
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (YES)
//        {
//            //超时时间是 1 秒，没有等到信号量，st 就不等于 0， RunLoop 所有的任务
//            long st = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
//            if (st != 0)
//            {
//                if (self->activity == kCFRunLoopBeforeSources || self->activity == kCFRunLoopAfterWaiting)
//                {
//                    if (++self->_timeoutCount < 2){
//                        NSLog(@"timeoutCount==%lu",(unsigned long)self->_timeoutCount);
//                        continue;
//                    }
//                    NSLog(@"检测到卡顿");
//                }
//            }
//            self->_timeoutCount = 0;
//        }
//    });
//}

//int largeNumber = 100000000;
//- (void)correctSolution1{
//    for (int i = 0; i < largeNumber; i++) {
//        //NSString *str = [[NSString alloc] initWithFormat:@"hello -%04d", i];
//        NSString *str = [NSString stringWithFormat:@"hello -%04d", i];
//        str = [str stringByAppendingString:@" - world"];
//    }
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self correctSolution1];
//}

//
//__weak id reference = nil;
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSString *str = [NSString stringWithFormat:@"sunnyxx"];
//
//
//    // str是一个autorelease对象，设置一个weak的引用来观察它
////    self.person = [[Person alloc] init];
////    self.person.name = @"111";
//    reference = str;
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"%@", reference); // Console: sunnyxx
////    NSLog(@"%@", self.person.name);
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"%@", reference); // Console: (null)
////    NSLog(@"%@", self.person.name);
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"🧗‍♀️🧗‍♀️ ....");
        
        // 构建下下文，这里只有三个参数有值，0 是 version 值代表是 source0，info 则直接传的 self 即当前的 vc，schedule 和 cancel 偷懒了传的 NULL，它们分别是
        // 执行 CFRunLoopAddSource 添加 rls 和 CFRunLoopRemoveSource 移除 rls 时调用的，大家可以自己试试，
        // 然后最后是执行函数 perform 传了 runLoopSourcePerformRoutine。
        CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, NULL, NULL, runLoopSourcePerformRoutine};
        
        CFRunLoopSourceRef rls = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);

        // 创建好的 rls 必须手动标记为待处理，否则即使 run loop 正常循环也不会执行此 rls
        CFRunLoopSourceSignal(rls); // ⬅️ 断点 1
        
        // 由于计时器一直在循环执行，所以这里可不需要我们手动唤醒 run loop
        CFRunLoopWakeUp(CFRunLoopGetCurrent()); // ⬅️ 断点 2

        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰⏰⏰ timer 回调...");
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode); // ⬅️ 断点 4（这里执行一次计时器回调再打断点）
        }];

        [[NSRunLoop currentRunLoop] run];
    }];
    
    [thread start];
}

void runLoopSourcePerformRoutine (void *info) {
    NSLog(@"👘👘 %@", [NSThread currentThread]); // ⬅️ 断点 3
}





@end
