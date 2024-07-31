//
//  ThirdViewController.m
//  通知2
//
//  Created by chenglin on 2024/7/29.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
       
       self.textField = [[UITextField alloc] initWithFrame: CGRectMake(20, 100, 200, 30)];
       self.textField.center = self.view.center;
       self.textField.borderStyle = UITextBorderStyleRoundedRect;
       self.textField.placeholder = @"thirdView";
       self.textField.delegate = self;
       
       [self.view addSubview: self.textField];
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    NSDictionary* message = @{@"key" : textField.text};
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    NSNotification *notification = [NSNotification notificationWithName:@"firstViewFromThirdView" object:self userInfo:message];
    //[center postNotificationName: @"firstViewFromThirdView" object: self userInfo: message];
    [center postNotification:notification];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
