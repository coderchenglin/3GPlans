//
//  JHOperation.m
//  NSOperation
//
//  Created by chenglin on 2024/7/25.
//

#import "JHOperation.h"

@implementation JHOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            NSLog(@"当前线程：%@", [NSThread currentThread]);
        }
    }
}

@end
