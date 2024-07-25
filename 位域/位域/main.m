//
//  main.m
//  位域
//
//  Created by chenglin on 2024/7/18.
//

#import <Foundation/Foundation.h>

#import "Person.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person* person = [[Person alloc] init];
        [person setTall:YES];
        [person setRich:NO];
        BOOL isTall = [person isTall];

        NSLog(@"%d", isTall);
        
        
    }
    return 0;
}
