//
//  main.m
//  Category
//
//  Created by chenglin on 2024/7/23.
//

#import <Foundation/Foundation.h>
#import "MyClass+privaty.h"
//#import "MyClass+MyAdditions.h"
#import "MyClass.h"

//#import "MyClass+Extension.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        MyClass *obj = [[MyClass alloc] init];
//        obj.myProperty = @"Hello, world!";
//        NSLog(@"myProperty : %@", obj.myProperty);
        
//        MyClass *myClass = [[MyClass alloc] init];
//        [myClass addMethod];
        
        MyClass *obj = [[MyClass alloc] init];
        [obj test];
        [obj outkj];

//        [obj test];
        
    }
    return 0;
}
