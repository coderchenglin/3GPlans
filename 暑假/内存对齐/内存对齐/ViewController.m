//
//  ViewController.m
//  内存对齐
//
//  Created by chenglin on 2024/7/21.
//

#import "ViewController.h"
#import "ZLObject.h"
#include <malloc/malloc.h>
#include <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZLObject *p1 = [[ZLObject alloc] init];
    NSLog(@"p1 : %@ -- 内存字节 = %lu -- 指针地址 = %p", p1, malloc_size((__bridge const void*)p1), &p1);
    //-- 内存字节 = 16 -- 指针地址 = 0x16b92fa68
    
    ZLObject *p2 = [[ZLObject alloc] init];
    NSLog(@"p2 : %@ -- 内存字节 = %lu -- 指针地址 = %p", p2, malloc_size((__bridge const void*)p2), &p2);
    //-- 内存字节 = 16 -- 指针地址 = 0x16b92fa60
    
    NSLog(@"ZLObject:实例字节大小 = %lu", class_getInstanceSize([ZLObject class]));
    
}


@end
