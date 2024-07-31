//
//  FirstViewController.m
//  通知
//
//  Created by chenglin on 2024/7/27.
//

#import "FirstViewController.h"
#import "ViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //时间触发时发送通知
    
    [self someEventTriggered];
    
}

- (void)someEventTriggered {
    // 事件触发时发送通知
    NSDictionary *userInfo = @{@"data": @"some data to pass"};
    [[NSNotificationCenter defaultCenter] postNotificationName:kMyNotification object:self userInfo:userInfo];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
