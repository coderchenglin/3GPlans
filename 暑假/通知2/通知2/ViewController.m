//
//  ViewController.m
//  通知2
//
//  Created by chenglin on 2024/7/27.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"、


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SecondViewController *obj2 = [[SecondViewController alloc] init];
    [obj2 viewDidLoad];
    FirstViewController *obj = [[FirstViewController alloc] init];
    [obj viewDidLoad];

}


@end
