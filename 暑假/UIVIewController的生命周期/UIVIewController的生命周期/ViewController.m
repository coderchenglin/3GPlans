//
//  ViewController.m
//  UIVIewController的生命周期
//
//  Created by chenglin on 2024/8/14.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   TestViewController *vc = [[TestViewController alloc]initWithNibName:@"ATestController" bundle:nil];
   [self.navigationController pushViewController:vc animated:YES];
}


@end
