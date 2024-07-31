//
//  FirstViewController.m
//  通知2
//
//  Created by chenglin on 2024/7/27.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Constants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    self.textField.center = self.view.center;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"valueFromSecondView";
    [self.view addSubview:self.textField];
    
    self.textField2 = [[UITextField alloc] initWithFrame: CGRectMake(20, 100, 200, 30)];
        self.textField2.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
        self.textField2.borderStyle = UITextBorderStyleRoundedRect;
        self.textField2.placeholder = @"valueFromThirdView";
        [self.view addSubview: self.textField2];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSecondController)];
    [self.view addGestureRecognizer: tapGesture];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveTextFromSecondView:) name:@"firstViewFromSecondView" object:nil];
    [center addObserver:self selector:@selector(receiveTextFromThirdView:) name:@"firstViewFromThirdView" object:nil];
    
    //[self pushSecondController];
}

- (void)receiveTextFromSecondView:(NSNotification *)notification {
    self.textField.text = notification.userInfo[@"key"];
}

- (void)receiveTextFromThirdView:(NSNotification *)notification {
    self.textField2.text = notification.userInfo[@"key"];
}


- (void)pushSecondController {
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    SecondViewController *VC2 = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:VC2 animated:YES];
//    NSDictionary *userInfo = @{@"data": @"Some data to pass"};
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:kMyNotification object:self userInfo:userInfo];
//}
//
//
//
//- (void)someEventTriggered {
//
//    NSLog(@"post成功");
//    NSDictionary *userInfo = @{@"data": @"Some data to pass"};
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:kMyNotification object:self userInfo:userInfo];
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
