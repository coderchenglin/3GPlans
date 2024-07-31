//
//  ViewController.m
//  NSOperation
//
//  Created by chenglin on 2024/7/25.
//

#import "ViewController.h"
#import "JHOperation.h"
#import <objc/runtime.h>

#import "DownloadOperation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)Operation1 {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    [op start];
}

- (void)test {
    for (NSInteger i = 0; i < 2; i++) {
        NSLog(@"当前线程：%@", [NSThread currentThread]);
    }
}

- (void)Operation2 {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程：%@", [NSThread currentThread]);
    }];
    [op start];
}

- (void)Operation3 {
    JHOperation *op = [[JHOperation alloc] init];
    [op start];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
////    [self Operation1];
//
//    //在其他线程执行
////    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(Operation1) object:nil];
////    [thread setName:@"firstThread"];
////    [thread start];
//
////    [self Operation2];
//
//    //使用NSBlockOperation
////    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
////        NSLog(@"当前线程：%@", [NSThread currentThread]);
////    }];
////
////    [op addExecutionBlock:^{
////        for (int i = 0; i < 2; i++) {
////            NSLog(@"当前线程2:%@", [NSThread currentThread]); //打印当前线程
////        }
////    }];
////
////    [op addExecutionBlock:^{
////        for (int i = 0; i < 2; i++) {
////            NSLog(@"当前线程3:%@", [NSThread currentThread]); //打印当前线程
////        }
////    }];
////
////    [op start];
//
//    [self Operation3];
//
//
//}


- (void)Operation4 {
    //1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    //2. 创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];

    //3. 添加操作
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];

}


- (void)Operation5 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程1:%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
    
}

- (void)Operation6 {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = -1; //默认情况，并发队列，且不限制最大并发数
    queue.maxConcurrentOperationCount = 1; //串行队列
    queue.maxConcurrentOperationCount = 2; //并发队列，一次只能执行2个并发队列
    [queue addOperationWithBlock:^{
       NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
       NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
       NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
    
}



- (void)Operation7 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"当前线程2:%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
    
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //[self Operation4];
//    //[self Operation5];
//    //[self Operation6];
//    //[self Operation7];
//
//}




//如何使用NSOperation实现并发下载碎片文件任务？
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://example.com/largefile"];
    NSInteger fileSize = 1000000;
    NSInteger fragmentSize = 200000;
    NSInteger numberOfFragments = (fileSize + fragmentSize - 1) / fragmentSize;
    
    NSString *destinationPath = @"/path/to/destination";
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (NSInteger i = 0; i < numberOfFragments; i++) {
        NSInteger start = i * fragmentSize;
        NSInteger length = MIN(fragmentSize, fileSize - start);
        
        DownloadOperation *operation = [[DownloadOperation alloc] initWithUrl:url start:start length:length fragmentIndex:i destinationPath:destinationPath];
        [queue addOperation:operation];
    }
    
    [queue waitUntilAllOperationsAreFinished];
    NSLog(@"All fragments downloaded.");

}

@end
