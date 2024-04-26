//
//  Observer.m
//  KVO
//
//  Created by chenglin on 2024/4/21.
//

#import "Observer.h"

@implementation Observer

- (instancetype)init {
    self = [super init];
    if (self) {
        _person = [[Person alloc] init];
        //添加观察者
        [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

//KVO回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object == self.person && [keyPath isEqualToString:@"name"]) {
        NSString *newName = change[NSKeyValueChangeNewKey];
        NSLog(@"Person's name changed to:%@", newName);
    }
    
}

- (void)dealloc {
    //移除观察者
    [self.person removeObserver:self forKeyPath:@"name"];
}

@end
