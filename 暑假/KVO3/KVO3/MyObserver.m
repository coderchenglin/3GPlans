//
//  MyObserver.m
//  KVO3
//
//  Created by chenglin on 2024/8/1.
//

#import "MyObserver.h"

@implementation MyObserver

- (instancetype)init {
    self = [super init];
    if (self) {
        _observableObject = [[MyObservableObject alloc] init];
        
        //观察name属性
        [_observableObject addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
        [_observableObject addObserver:self forKeyPath:@"items" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    }
    return self;
}

- (void)dealloc {
    [_observableObject removeObserver:self forKeyPath:@"name"];
    [_observableObject removeObserver:self forKeyPath:@"items"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"name"]) {
        NSString *oldName = change[NSKeyValueChangeOldKey];
        NSString *newName = change[NSKeyValueChangeNewKey];
        NSLog(@"Name changed from %@ to %@", oldName, newName);
    } else if([keyPath isEqualToString:@"items"]) {
        NSKeyValueChangeKey changeType = [change[NSKeyValueChangeKindKey] intValue];
        
    }
    
}


@end
