//
//  Observer.m
//  KVO2
//
//  Created by chenglin on 2024/8/1.
//

#import "Observer.h"

@implementation Observer

- (instancetype)init {
    self = [super init];
    if (self) {
        _person = [[Person alloc] init];
        [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        NSDictionary *myDict = @{@"name" : @"john", @"age" : @30};
        _dic = [[NSDictionary alloc] initWithDictionary:myDict];
        [myDict addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
        
    }
    return self;
}

- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"dic"]) {
//        NSLog(@"Name changed from %@ to %@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
        id newValue = change[NSKeyValueChangeNewKey];
        id oldValue = change[NSKeyValueChangeOldKey];
        NSNumber *kind = change[NSKeyValueChangeKindKey];
        NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
        NSNumber *isPrior = change[NSKeyValueChangeNotificationIsPriorKey];
        
        NSLog(@"Name changed from %@ to %@", oldValue, newValue);
        
        switch (kind.integerValue) {
            case NSKeyValueChangeSetting:
                NSLog(@"Setting new value");
                break;
            case NSKeyValueChangeInsertion:
                NSLog(@"Inserting new element");
                break;
            case NSKeyValueChangeRemoval:
                NSLog(@"Removing element");
                break;
            case NSKeyValueChangeReplacement:
                NSLog(@"Replacing element");
                break;
        }
        
        if (indexes) {
            NSLog(@"Changed indexes: %@", indexes);
        }
        
        if (isPrior.boolValue) {
            NSLog(@"This is a prior notification");
        }
        
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
