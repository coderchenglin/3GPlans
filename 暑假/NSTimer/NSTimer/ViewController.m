//
//  ViewController.m
//  NSTimer
//
//  Created by chenglin on 2024/8/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)invocationType {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(timerTest)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(timerTest);
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 invocation:invocation repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)selectorType {
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerTest {
    NSLog(@"hello");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self selectorType];
    [self invocationType];
}


@end
