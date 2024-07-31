//
//  SecondViewController.m
//  通知2
//
//  Created by chenglin on 2024/7/27.
//

#import "SecondViewController.h"
#import "Constants.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
        
    self.textField = [[UITextField alloc] initWithFrame: CGRectMake(20, 100, 200, 30)];
    self.textField.center = self.view.center;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"secondView";
    self.textField.delegate = self;
    
    [self.view addSubview: self.textField];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(pushThirdController)];
    [self.view addGestureRecognizer: tapGesture];

}

- (void)pushThirdController {
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    
    [self.navigationController pushViewController:thirdViewController animated:YES];
}



//- (void)textFieldDidChangeSelection:(UITextField *)textField {
//    NSDictionary *message = @{@"key" : textField.text};
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//
//    [center postNotificationName:@"firstViewFromSecondView" object:self userInfo:message];
//}


//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMyNotification object:nil];
//}
//
//- (void)handleNotification:(NSNotification *)notification {
//    NSLog(@"observer成功");
//    NSDictionary *userInfo = notification.userInfo;
//    NSString *data = userInfo[@"data"];
//    NSLog(@"Received data : %@", data);
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
