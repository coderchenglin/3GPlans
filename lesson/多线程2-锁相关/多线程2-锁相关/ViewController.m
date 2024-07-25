//
//  ViewController.m
//  多线程2-锁相关
//
//  Created by chenglin on 2024/6/5.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int ticketsCount;

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
////    NSLog(@"1");
//
//    //[self performSelector:@selector(test) withObject:nil afterDelay:3];
//}
//
//- (void)test {
//    NSLog(@"2");
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    dispatch_async(queue, ^{
//        NSLog(@"1");
//        [self performSelector:@selector(test) withObject:nil];//这个方法定义在runtime中，就是调用objc_msgsend（）方法
//        [self performSelector:@selector(test) withObject:nil afterDelay:3];//这个方法是定义在runloop中的，用到了定时器NSTimer，
//        //这句代码的本质，就是往runloop里面添加了一个定时器
//        NSLog(@"3");
//    });
//}

//运行结果：
//2024-06-05 17:47:04.835921+0800 多线程2-锁相关[68687:2306238] 1
//2024-06-05 17:47:04.836160+0800 多线程2-锁相关[68687:2306238] 3
//为什么没有执行 [self performSelector:@selector(test) withObject:nil afterDelay:3];这句代码？
//因为这句代码的本质是往当前线程的runloop中添加定时器，但是当前线程没有runloop！



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    dispatch_async(queue, ^{
//        NSLog(@"1");
////        [self performSelector:@selector(test) withObject:nil];//这个方法定义在runtime中，就是调用objc_msgsend（）方法
//        [self performSelector:@selector(test) withObject:nil afterDelay:3];//这个方法是定义在runloop中的，用到了定时器NSTimer，
//        //这句代码的本质，就是往runloop里面添加了一个定时器
//
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        //除了主线程，其他的子线程是默认没有启动runloop的
//
//        NSLog(@"3");
//    });
//
//    NSLog(@"4");
//}



#pragma mark - 任务组的使用
//需求：实现先并发执行任务一和任务二，再执行任务三
//方法：使用任务组，group

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    //创建并发队列
//    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
//
//    //添加异步任务
//    dispatch_group_async(group, queue, ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务1 - %@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_group_async(group, queue, ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务2 - %@", [NSThread currentThread]);
//        }
//    });
//    //等前面的任务执行完毕后，执行该任务
////    dispatch_group_notify(group, queue, ^{
////        dispatch_async(dispatch_get_main_queue(), ^{
////            for (int i = 0; i < 5; i++) {
////                NSLog(@"任务3 - %@", [NSThread currentThread]);
////            }
////        });
////    });
//
//    //等价：
//    dispatch_group_notify(group, queue, ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务3 - %@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_group_notify(group, queue, ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务4 - %@", [NSThread currentThread]);
//        }
//    });
//}



#pragma mark - 多线程安全隐患
//1.取钱存钱





//2.卖票

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self saleTickets];
}

- (void)saleTicket {
    int oldTicketCount = self.ticketsCount;
//    sleep(0.2);
    oldTicketCount--;
    self.ticketsCount = oldTicketCount;
    
//    self.ticketsCount--;
    NSLog(@"剩余%d - %@", self.ticketsCount, [NSThread currentThread]);
}

- (void)saleTickets {
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
//            NSLog(@"北京");
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
//            NSLog(@"上海");
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
 //           NSLog(@"广州");
        }
    });
}




//1.必须访问的是同一把锁，才能达到加锁的目的
//2.使用过程是，我先创建一把锁。线程是要对一把特定的锁进行操作
//如果这把锁没有被别人加过，它就会加这把锁。如果被别人加过，那就等待，等别人解锁后再加锁

//所以存钱和取钱，不能同时进行，那么就必须共用同一把锁
//但是买票和存钱，取钱，没有必要用同一把锁



#pragma mark - OSSpinLock
//1.这把锁叫自旋锁，等待锁的线程会处于忙等状态，一直占用着CPU的资源
//目前已经不再安全，可能会出现优先级反转问题
//如果等待锁的线程优先级较高，它会一直占用着CPU资源，优先级低的线程就无法释放锁


//锁的使用：（不一定要定义成属性）
//当有多个事情需要用到同一把锁的时候，可以定义成属性来使用；
// 或者定义一个全局的static锁，并且在initialize方法里进行初始化
//如果只有一件事情（一个方法）要用到同一把锁的时候，可以在方法里面 定义一个static的锁

//有一个小知识点：
//static变量，不能通过一个函数的返回值给它初始化，只能用一个实际的值进行初始化
//如果要用函数调用的返回值赋值，需要在另一处写
//并且如果是初始化，记得用once （单例）




//pthread_mutex是跨平台的锁
//mutex叫做互斥锁，等待锁的时候
//
//递归锁允许同一线程多次对同一把锁加锁

//主线程大部分事情都是交给了runLoop去做，比如UI界面的刷新，点击事件的处理，perforSelection等等。
//但是，普通的代码，比如，简单打印，是不需要runLoop的

//GCD的串行队列也可以实现线程同步
//信号量也可以实现线程同步，让最大线程数为1
@end
