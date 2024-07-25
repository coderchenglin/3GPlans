//
//  main.m
//  isMemberOfClass
//
//  Created by chenglin on 2024/7/19.
//

#import <Foundation/Foundation.h>

#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //Person *person = [[Person alloc] init];
//        NSNumber *number1 = @1;
//        NSNumber *number2 = @2;
//        NSNumber *number3 = @3;
//        NSNumber *numberFFFF = @(0xFFFF);
//
//        NSLog(@"number1 pointer is %p", number1);
//        NSLog(@"number2 pointer is %p", number2);
//        NSLog(@"number3 pointer is %p", number3);
//        NSLog(@"numberffff pointer is %p", numberFFFF);
        NSNumber *number1 = @4;
        NSNumber *number2 = @5;
        NSNumber *number3 = @(0xFFFFFFFFFFFFFFF);
        
        NSLog(@"\nnumber1=%p\nnumber2=%p\nnumber3=%p", number1, number2, number3);
        
    }
    return 0;
}




