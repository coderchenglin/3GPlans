//
//  Person.m
//  Block
//
//  Created by chenglin on 2024/7/21.
//

#import "Person.h"

@implementation Person

- (void)someMethod {
    int localVariable = 10;
    
    void (^myBlock)(void) = ^{
        NSLog(@"The value of localVariable is: %d", localVariable);
    };
    
    [self executeBlock:myBlock];
}

- (void)executeBlock:(void (^)(void))block {
    block();
}

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

@end
