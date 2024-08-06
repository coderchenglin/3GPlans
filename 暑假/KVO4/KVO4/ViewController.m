//
//  ViewController.m
//  KVO4
//
//  Created by chenglin on 2024/8/3.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.arrayManager = [[MyArrayManager alloc] init];
//
//    // 添加 KVO 观察者
//    [self.arrayManager addObserver:self forKeyPath:@"models" options:NSKeyValueObservingOptionNew context:nil];
//
//    // 创建并添加一个新模型
//    MyModel *model1 = [[MyModel alloc] init];
//    model1.name = @"Model 1";
//    [self.arrayManager addModel:model1];
//
//    // 更新模型
//    MyModel *model2 = [[MyModel alloc] init];
//    model2.name = @"Model 2";
//    [self.arrayManager replaceModelAtIndex:0 withModel:model2];
//
//    // 移除模型
//    [self.arrayManager removeModelAtIndex:0];
//}
//
//// 处理 KVO 通知
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
//                       context:(void *)context {
//    if ([keyPath isEqualToString:@"models"]) {
//        NSLog(@"Array changed: %@", change);
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//
//- (void)dealloc {
//    // 移除 KVO 观察者
//    [self.arrayManager removeObserver:self forKeyPath:@"models"];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutableArray = [NSMutableArray array];
    
    // 使用 KVC 返回一个 proxy 对象，并监听该 proxy 对象
    [self addObserver:self forKeyPath:@"mutableArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    // 操作数组内容
    [[self mutableArrayValueForKey:@"mutableArray"] addObject:@99];
    [[self mutableArrayValueForKey:@"mutableArray"] addObject:@101];
    [[self mutableArrayValueForKey:@"mutableArray"] replaceObjectAtIndex:0 withObject:@100];
    [[self mutableArrayValueForKey:@"mutableArray"] removeObjectAtIndex:0];
}

// 处理 KVO 通知
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"mutableArray"]) {
        NSLog(@"NSMutableArray changed: %@", change);
        
        NSArray *oldArray = change[NSKeyValueChangeOldKey];
        NSArray *newArray = change[NSKeyValueChangeNewKey];
        NSLog(@"==%@==%@", oldArray, newArray);
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // 移除 KVO 观察者
    [self removeObserver:self forKeyPath:@"mutableArray"];
}

@end


