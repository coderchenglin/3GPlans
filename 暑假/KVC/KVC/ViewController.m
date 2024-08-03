//
//  ViewController.m
//  KVC
//
//  Created by chenglin on 2024/8/1.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)printNSArrayMethods
{
    u_int count;
    Method *methods = class_copyMethodList([NSArray class], &count);
    for (int i = 0; i < count ; i++)
    {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSLog(@"%d---%@", i, NSStringFromSelector(sel));
    }
    free(methods);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self printNSArrayMethods];
}


@end
