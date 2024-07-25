//
//  ViewController.m
//  delegate循环引用
//
//  Created by chenglin on 2024/7/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.customView = [[CustomView alloc] initWithFrame:self.view.bounds];
    self.customView.backgroundColor = [UIColor redColor];
    self.customView.delegate = self;
    [self.view addSubview:self.customView];
}

- (void)customViewButtonTapped:(NSString *)info {
    NSLog(@"%@", info);
}

@end
