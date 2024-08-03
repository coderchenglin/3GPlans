//
//  ViewController.m
//  KVO3
//
//  Created by chenglin on 2024/8/1.
//

#import "ViewController.h"
#import "MyObserver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyObserver *observer = [[MyObserver alloc] init];
    
    // 修改被观察对象的属性
    observer.observableObject.name = @"John";
    NSLog(@"Name is now %@", observer.observableObject.name);
    
    // 修改被观察对象的数组
    observer.observableObject.items = [[NSMutableArray alloc] initWithObjects:@"item1", @"item2", @"item3", nil];
//    [observer.observableObject.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"Item at index %lu is %@", (unsigned long)idx, obj);
//    }];
    
    // 删除数组中的元素
//    NSMutableArray *mutableItems = [observer.observableObject.items mutableCopy];
//    [mutableItems removeObjectAtIndex:1];
//    observer.observableObject.items = mutableItems;
    
    //这样是：NSKeyValueChangeSetting
    [observer.observableObject.items removeObjectAtIndex:1];
    
    //这样是：NSKeyValueChangeRemoval
    NSMutableArray *mutableItems = [observer.observableObject mutableArrayValueForKey:@"items"];//这个方法返回一个"键-值观察兼容"的可变数组:
    [mutableItems removeObjectAtIndex:1];
    
    // 替换数组中的元素
//    mutableItems[0] = @"new item1";
//    observer.observableObject.items = mutableItems;
    observer.observableObject.items[0] = @"new item1";
}


@end
