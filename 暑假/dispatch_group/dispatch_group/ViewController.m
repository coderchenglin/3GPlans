//
//  ViewController.m
//  dispatch_group
//
//  Created by chenglin on 2024/8/2.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton
 
    dispatch_queue_t queueColumn = dispatch_queue_create("SerialQueue1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queueColumn, ^{
        [self setrsInfoIsTimer:NO];
    });
 
    //...
}
 
- (void)setrsInfoIsTimer:(BOOL)isTimer
{
    //局部变量的group，可以解决dispatch_group_leave(group)奔溃的问题，
    dispatch_queue_t serial_queue = dispatch_queue_create("SerialQueue2", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
 
    //MARK: 开始组装数据
    
    dispatch_group_enter(group);
    dispatch_async(serial_queue, ^{
        NSLog(@"getGuestListIsFirstEnter --- group ---");
        [self getHallInfoGroup:group];
    });
 
    //阻塞线程SerialQueue1
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
 
    dispatch_group_enter(group);
    dispatch_async(serial_queue, ^{
        NSLog(@"getGuestListIsFirstEnter --- group ---");
        [self getGuestListIsFirstEnter:YES isTimer:isTimer group:group];
    });
 
    //阻塞线程SerialQueue1
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
 
    dispatch_async(dispatch_get_main_queue(), ^{
           
        //...更新UI
 
    });
 
    //MARK:组装数据结束
}
 
- (void)getHallInfoGroup:(dispatch_group_t)group
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"XX",@"",@"XX1",@"",@"XX2", nil];
    [[KSNetWork shareInstance] postWithOperationType:@"XXX" Params:dict TranSuc:^(NSDictionary * _Nonnull resultInfo) {
 
        dispatch_group_leave(group);
    } TranFail:^(NSDictionary * _Nonnull errInfo) {
 
        dispatch_group_leave(group);
    } showLoading:self.showLoading];
}
 
-(void)getGuestListIsFirstEnter:(BOOL)firstEnter isTimer:(BOOL)isTimer group:(nullable dispatch_group_t)group
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"XX",@"",@"XX1",@"",@"XX2", nil];
    [[KSNetWork shareInstance] postWithOperationType:@"XXX" Params:dict TranSuc:^(NSDictionary * _Nonnull resultInfo) {
 
        dispatch_group_leave(group);
    } TranFail:^(NSDictionary * _Nonnull errInfo) {
 
        dispatch_group_leave(group);
    } showLoading:self.showLoading];
}


@end
