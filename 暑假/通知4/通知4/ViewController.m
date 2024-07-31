//
//  ViewController.m
//  通知4
//
//  Created by chenglin on 2024/7/29.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.view.backgroundColor = [UIColor redColor];
//    //添加观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"NotificationName" object:nil];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{    // 异步执行 + 串行队列
//        NSLog(@"--current thread: %@", [NSThread currentThread]);
//        NSLog(@"Begin post notification");
//        //发送通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:nil];
//        NSLog(@"End");
//    });
//}
//
//- (void)test {
//    NSLog(@"--current thread: %@", [NSThread currentThread]);
//    NSLog(@"Handle notification and sleep 3s");
//    sleep(3);
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"NotificationName" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"TestNotification" object:@1];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"--current thread: %@", [NSThread currentThread]);
//    NSLog(@"Begin post notification");
//    [NSNotificationCenter.defaultCenter postNotificationName:@"TestNotification" object:nil];
////    NSNotification *notification = [NSNotification notificationWithName:@"NotificationName" object:nil];
////    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
//    NSLog(@"End");
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"NotificationName" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1--current thread: %@", [NSThread currentThread]);
    NSLog(@"Begin post notification");
    NSNotification *notification = [NSNotification notificationWithName:@"NotificationName" object:nil];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostNow];
    NSLog(@"End");
}



- (void)test {
    NSLog(@"2--current thread: %@", [NSThread currentThread]);
    NSLog(@"Handle notification and sleep 3s");
    sleep(3);
}


//// 添加观察
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"TestNotification" object:@1];
//// 通知发送
//[NSNotificationCenter.defaultCenter postNotificationName:@"TestNotification" object:nil];




@end
