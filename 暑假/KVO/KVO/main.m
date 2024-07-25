//
//  main.m
//  KVO
//
//  Created by chenglin on 2024/7/16.
//

#import <Foundation/Foundation.h>
#import "Observer.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Observer *observer = [[Observer alloc] init];
        observer.person.name = @"John";
    }
    return 0;
}
