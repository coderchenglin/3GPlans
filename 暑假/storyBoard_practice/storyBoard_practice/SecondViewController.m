//
//  SecondViewController.m
//  storyBoard_practice
//
//  Created by chenglin on 2024/8/14.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)passValueWithBlock:(PassValueBlock)block {
    self.block = [block copy];
}

- (IBAction)back:(UIButton *)sender {
    NSLog(@"AAA %p", self.block);
    
    if (self.block) {
        self.block(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
