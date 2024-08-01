//
//  ViewController.m
//  KVO2
//
//  Created by chenglin on 2024/8/1.
//

#import "ViewController.h"
#import "Observer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Observer *observer = [[Observer alloc] init];
    observer.person.name = @"john";
    observer.person.name = @"Doe";
    
}


@end
