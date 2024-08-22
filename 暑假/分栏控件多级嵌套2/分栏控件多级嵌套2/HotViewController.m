//
//  HotViewController.m
//  分栏控件多级嵌套2
//
//  Created by chenglin on 2024/8/22.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bottomSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"色盲的类型和症状", @"关于色盲的知识", @"什么样的家庭需要测色盲"]];
    self.bottomSegmentedControl.selectedSegmentIndex = 0;
    [self.bottomSegmentedControl addTarget:self action:@selector(bottomSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.bottomSegmentedControl.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, 50);
    
    
    
    
}



@end
