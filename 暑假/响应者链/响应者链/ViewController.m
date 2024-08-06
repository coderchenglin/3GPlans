//
//  ViewController.m
//  响应者链
//
//  Created by chenglin on 2024/8/3.
//

#import "ViewController.h"
#import "SView.h"
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import "DView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    SView *sv = [[SView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    sv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sv];
 
    AView *av = [[AView alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
    av.backgroundColor = [UIColor orangeColor];
    [sv addSubview:av];
    
    BView *bv = [[BView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    bv.backgroundColor = [UIColor greenColor];
    [av addSubview:bv];
    
    DView *dv = [[DView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    dv.backgroundColor = [UIColor cyanColor];
    [av addSubview:dv];
    
    av.dv = dv;
    
    CView *cv = [[CView alloc] initWithFrame:CGRectMake(50, 130, 50, 50)];
    cv.backgroundColor = [UIColor blueColor];
    [av addSubview:cv];
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@, %s", [self class], __func__);
}

@end
