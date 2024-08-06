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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [runLoop run];
}


@end
