//
//  Observer.m
//  KVO
//
//  Created by chenglin on 2024/7/16.
//

#import "Observer.h"

@implementation Observer

- (instancetype)init {
    self = [super init];
    if (self) {
        _person = [[Person alloc] init];
        [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"Name changed from %@ to %@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
