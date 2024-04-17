//
//  ViewController.m
//  RunloopStudy
//
//  Created by chenglin on 2024/4/15.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建一个 Runloop 对象
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];

    // 设置超时时间为5秒钟 - 这是一个预设的超时时间点
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5];

    //dispatch_time_t是一个以纳秒为单位的时间戳，NSEC_PER_SEC表示一秒的纳秒数
    //这个方法不会阻塞当前线程，它提供一种“异步”调度任务的方式，用于延迟执行代码块而不影响当前线程的执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //此处是延迟执行的代码，将在5秒后执行
        NSLog(@"Program has run for 5 seconds.");
    });
    
//    NSTimeInterval delay = 6.0;
//    NSDate *startDate = [NSDate date];
//    while ([[NSDate date] timeIntervalSinceDate:startDate] < delay) {
//        // 什么都不做，只是等待时间达到5秒钟
//        // 注意：这种方式会阻塞当前线程，请避免在主线程中使用
//    }
    
    // 使用超时值运行 Runloop
    while ([timeoutDate timeIntervalSinceNow] > 0) {
        
        // 运行 Runloop，但限制最长等待时间为5秒钟
        BOOL didReceiveEvent = [myRunLoop runMode:NSDefaultRunLoopMode beforeDate:timeoutDate]; //用与运行当前runloop
        
        if (didReceiveEvent) {
            // 如果收到了事件，处理事件并退出循环
            NSLog(@"Received an event!");
            // 处理事件的逻辑在这里添加
            break; // 退出循环
        } else {
            // 如果超时未收到事件，可以继续等待或进行一些其他操作
            NSLog(@"Timeout occurred. Do any needed housekeeping.");
            // 可以在超时后执行一些清理操作或其他逻辑
            // 继续等待或退出循环
        }
    }

    // 在超时时间内未收到事件或超时后的处理逻辑

    
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    [self.view addSubview:self.tableView];
    
    //测试线程的销毁
//    [self threadTest];
}

//
//#pragma mark - UITableViewDataSourse Methods
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 100;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifier = @"cellId";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    for (NSInteger i = 1; i <= 5; i++) {
//        [[cell.contentView viewWithTag:i] removeFromSuperview];
//    }
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor redColor];
//    label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
//    label.font = [UIFont boldSystemFontOfSize:13];
//    label.tag = 1;
//    [cell.contentView addSubview:label];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
//    imageView.tag = 2;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.image = image;
//    NSLog(@"current:%@",[NSRunLoop currentRunLoop].currentMode);
//    [cell.contentView addSubview:imageView];
//
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
//    imageView2.tag = 3;
//    UIImage *image2 = [UIImage imageWithContentsOfFile:path];
//    imageView2.contentMode = UIViewContentModeScaleAspectFit;
//    imageView2.image = image2;
//    [cell.contentView addSubview:imageView2];
//
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
//    label2.lineBreakMode = NSLineBreakByWordWrapping;
//    label2.numberOfLines = 0;
//    label2.backgroundColor = [UIColor clearColor];
//    label2.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
//    label2.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
//    label2.font = [UIFont boldSystemFontOfSize:13];
//    label2.tag = 4;
//
//    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
//    imageView3.tag = 5;
//    UIImage *image3 = [UIImage imageWithContentsOfFile:path];
//    imageView3.contentMode = UIViewContentModeScaleAspectFit;
//    imageView3.image = image3;
//    [cell.contentView addSubview:label2];
//    [cell.contentView addSubview:imageView3];
//
//    return cell;
//}
//
////- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    [self performSelector:@selector(subThreadOpetion) onThread:self.subThread withObject:nil waitUntilDone:NO];
////}
////
////- (void)threadTest {
////    HLThread *subThread = [[HLThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
//////    [subThread setName:@"HLThread"];
////    [subThread start];
////    self.subThread = subThread;
////}
////
////- (void)subThreadEntryPoint {
////    @autoreleasepool {
////        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
////        [runloop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
////        NSLog(@"启动Runloop前--%@", runloop.currentMode);
////        [runloop run];
////    }
////}
////
////- (void)subThreadOpetion {
////    NSLog(@"启动RunLoop后--%@", [NSRunLoop currentRunLoop].currentMode);
////    NSLog(@"%@---子线程任务开始", [NSThread currentThread]);
////    [NSThread sleepForTimeInterval:3.0];
////    NSLog(@"%@---子线程任务结束", [NSThread currentThread]);
////}
//
//
@end
