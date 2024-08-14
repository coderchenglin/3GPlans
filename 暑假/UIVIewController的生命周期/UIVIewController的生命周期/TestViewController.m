//
//  TestViewController.m
//  UIVIewController的生命周期
//
//  Created by chenglin on 2024/8/14.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   NSLog(@"%s",__func__);
}

//- (void)loadView {
//    [super loadView];
//    NSLog(@"%s",__func__);
//}

- (instancetype)initWithCoder:(NSCoder *)coder
{
   self = [super initWithCoder:coder];
   if (self) {
   NSLog(@"%s",__func__);
   }
   return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
       NSLog(@"%s",__func__);
       NSLog(@"NibName:%@-->bundle:%@",nibNameOrNil,nibBundleOrNil);
   }
   return self;
}


@end
