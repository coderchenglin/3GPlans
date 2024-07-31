//
//  SecondViewController.m
//  通知
//
//  Created by chenglin on 2024/7/27.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kMyNotification object:nil];
    
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMyNotification object:nil];
}

- (void)handleNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *data = userInfo[@"data"];
    NSLog(@"Received data: %@", data);
    
}

@end
