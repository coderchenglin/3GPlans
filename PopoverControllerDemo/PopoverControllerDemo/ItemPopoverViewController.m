//
//  ItemPopoverViewController.m
//  PopoverControllerDemo
//
//  Created by chenglin on 2024/2/18.
//

#import "ItemPopoverViewController.h"

@interface ItemPopoverViewController ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation ItemPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"hello";
    [self.view addSubview:self.label];
    self.view.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillLayoutSubviews {
    // 在这重新修改子视图的布局
    self.label.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
