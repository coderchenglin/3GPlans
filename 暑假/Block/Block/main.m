//
//  main.m
//  Block
//
//  Created by chenglin on 2024/7/21.
//

#import <Foundation/Foundation.h>

#import "Person.h"

//typedef void (^Block)(void);

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        Block block;
//
//        {
//            Person *p = [[Person alloc] init];
//            block = ^{
//                NSLog(@"%@",p);
//            };
//            [p release];
//        }
//
//        block();
//        NSLog(@"--------");
//
//        sleep(5);
//
//    }
//    return 0;
//}

#import "Helper.h"

@interface MyClass : NSObject

- (void)testBlock;

@end

@implementation MyClass

//test1 ：正常调用 - 正常
- (void)testBlock {
    Helper *helper = [[Helper alloc] init];
    helper.block = ^{
        NSLog(@"test");
    };
    helper.block();
}

//test2 ： 调用一个对象的nil block - 崩溃
- (void)testBlockNilBlock {
    Helper *helper = [Helper new];
    helper.block();
}

//test3 ： 调用一个nil对象的block - 崩溃
- (void)testBlockNilObj {
    Helper *helper = nil;
    helper.block();
}

//test4 ： 调用一个nil对象的调用普通函数 - 正常
- (void)test {
    Helper *helper = nil;
    [helper triger];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        MyClass *myClass = [[MyClass alloc] init];
        //[myClass testBlock];  //正常
        //[myClass testBlockNilBlock]; //崩溃
        //[myClass testBlockNilObj];  //崩溃
        [myClass test]; //正常
        
    }
    return 0;
}

