//
//  MyOperation.m
//  GCD
//
//  Created by chenglin on 2024/7/25.
//

#import "MyOperation.h"

@implementation MyOperation

- (void)main {
    @try {
        if (self.isCancelled)
            return;
        NSLog(@"MyOperation is executing");
        
        for (NSInteger i = 0; i < 100; i++) {
            if (self.isCancelled)
                return;
            //模拟长时间执行任务
            [NSThread sleepForTimeInterval:0.1];
        }
        
        if (self.isCancelled)
            return;
        NSLog(@"MyOperation is finished");
        
        
    } @catch (NSException *exception) {
        NSLog(@"111");
    } @finally {
        NSLog(@"222");
    }
}

@end
