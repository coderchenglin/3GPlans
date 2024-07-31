//
//  ViewController.m
//  copy&strong
//
//  Created by chenglin on 2024/7/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *newString = [NSString stringWithFormat:@"newString"];
    
    self.myStrongStr = newString;
    self.myCopyStr = newString;
    
    NSLog(@"newString   对象地址：%p, 指针地址：%p, 对象的值：%@", newString, &newString, newString);
    NSLog(@"myStrongStr 对象地址：%p, 指针地址：%p, 对象的值：%@", _myStrongStr, &_myStrongStr, _myStrongStr);
    NSLog(@"myCopyStr   对象地址：%p, 指针地址：%p, 对象的值：%@", _myCopyStr, &_myCopyStr, _myCopyStr);
}


@end
