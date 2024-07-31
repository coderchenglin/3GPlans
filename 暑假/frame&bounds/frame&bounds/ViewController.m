//
//  ViewController.m
//  frame&bounds
//
//  Created by chenglin on 2024/7/30.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *fView;
@property (nonatomic, strong) UIView *sView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blackColor];
    
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    superView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:superView];
    superView.bounds = CGRectMake(50, 50, 200, 200);
    
    NSLog(@"superView frame%@=======bounds:%@", NSStringFromCGRect(superView.frame), NSStringFromCGRect(superView.bounds));
    
    UIView *childView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    childView.backgroundColor = [UIColor redColor];
    [superView addSubview:childView];
    NSLog(@"childView frame:%@========bounds:%@",NSStringFromCGRect(childView.frame),NSStringFromCGRect(childView.bounds));
    childView.bounds = CGRectMake(50, 50, 100, 100);
    
    UIView *childView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    childView2.backgroundColor = [UIColor blueColor];
    [childView addSubview:childView2];
    NSLog(@"childView frame:%@========bounds:%@",NSStringFromCGRect(childView2.frame),NSStringFromCGRect(childView2.bounds));
    
    //
    //}
    //
    //- (void)viewDidLoad {
    //    [super viewDidLoad];
    //    UIButton *animateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    animateButton.frame = CGRectMake(100, 250, 100, 50);
    //    [animateButton setTitle:@"Animate" forState:UIControlStateNormal];
    //    [animateButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:animateButton];
    //
    //    self.fView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    [self.view addSubview:self.fView];
    //    self.fView.backgroundColor = [UIColor orangeColor];
    //
    //    self.sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //    [self.fView addSubview:self.sView];
    //    self.sView.backgroundColor = [UIColor blueColor];
    //
    //    NSLog(@"Bounds:");
    //    NSLog(@"fView x:%f; sView x:%f", self.fView.bounds.origin.x, self.sView.bounds.origin.x);
    //    NSLog(@"fView y:%f; sView y:%f", self.fView.bounds.origin.y, self.sView.bounds.origin.y);
    //    NSLog(@"fView width:%f; sView width:%f", self.fView.bounds.size.width, self.sView.bounds.size.width);
    //    NSLog(@"fView height:%f; sView height:%f", self.fView.bounds.size.height, self.sView.bounds.size.height);
    //
    //    NSLog(@"frame:");
    //    NSLog(@"fView x:%f; sView x:%f", self.fView.frame.origin.x, self.sView.frame.origin.x);
    //    NSLog(@"fView y:%f; sView y:%f", self.fView.frame.origin.y, self.sView.frame.origin.y);
    //}
    //
    //- (void) startAnimation {
    //    [self.fView setBounds:CGRectMake(60, 60, 100, 100)];
    //
    //    NSLog(@"Bounds:");
    //    NSLog(@"fView x:%f; sView x:%f", self.fView.bounds.origin.x, self.sView.bounds.origin.x);
    //    NSLog(@"fView y:%f; sView y:%f", self.fView.bounds.origin.y, self.sView.bounds.origin.y);
    //    NSLog(@"fView width:%f; sView width:%f", self.fView.bounds.size.width, self.sView.bounds.size.width);
    //    NSLog(@"fView height:%f; sView height:%f", self.fView.bounds.size.height, self.sView.bounds.size.height);
    //
    //    NSLog(@"frame:");
    //    NSLog(@"fView x:%f; sView x:%f", self.fView.frame.origin.x, self.sView.frame.origin.x);
    //    NSLog(@"fView y:%f; sView y:%f", self.fView.frame.origin.y, self.sView.frame.origin.y);
    //}
    //
    //
    //
}
@end
