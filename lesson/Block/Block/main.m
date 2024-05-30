//
//  main.m
//  Block
//
//  Created by chenglin on 2024/5/24.
//

#import <Foundation/Foundation.h>
#import "MJPerson.h"

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        auto int age = 10;    //auto：自动变量  捕获方式，值传递
//        static int height = 10; //static变量   捕获方式 ，指针传递
//
//        void (^block)() = ^{
//            NSLog(@"Hello - %d, %d", age, height); //10, 20
//        };
//
//        age = 20;
//        height = 20;
//
//        block();
//
////        void (^block)(void) = ^{
////            NSLog(@"hello, world!");
////        };
////
////        block();
//    }
//    return 0;
//}


//1。block的底层结构
//2。block的变量捕获方式 ：
//局部变量：需要捕获
//   auto ： 值传递
//   static ： 指针传递
//全局变量： 不需要捕获直接访问
//   直接以全局变量的方式去访问（因为可以直接访问，没必要捕获）


//补充： static变量
//函数内的static变量： 只能在该函数内访问，其他函数无法访问，但是函数结束后，该变量不会销毁，会一直保存该值，直到下一次通过该函数来访问该变量
//即：函数内的static变量，它不会销毁，但其他函数不能访问，所以static局部变量，是需要进行捕获（保存）的，否则无法进行访问

//3. self变量，会捕获
//说明self是一个局部变量，auto变量，指的是方法调用者，而方法调用者每次都可能不一样
//解释 ：
//- (void)test(MJPerson *self, SEL _cmd)
//每一个OC函数后面  默认都紧跟着两个参数，一个self，一个_cmd
//而我们知道 参数就是局部变量

//而且self时作为一个对象类型的变量被捕获，会增加**引用计数**




//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        MJPerson* obj = [[MJPerson alloc] init];
//        obj.name = @"abc";
//        [obj test];
//    }
//    return 0;
//}



////3.Block本质是一个OC对象
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        void (^block)(void) = ^{
//            NSLog(@"Hello");
//        };
//
//        NSLog(@"%@", [block class]);  //__NSGlobalBlock__
//        NSLog(@"%@", [[block class] superclass]); //NSBlock
//        NSLog(@"%@", [[[block class] superclass] superclass]); //NSObject
//
//
//    }
//    return 0;
//}



//4.Block3种类型


//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        //Global - 没有访问auto变量
//        void (^block1)(void) = ^{
//            NSLog(@"block1 Hello");
//        };
//
//        NSLog(@"%@", [block1 class]);  //__NSGlobalBlock__
//
//        //Stack - 访问了auto变量
//        int age = 10;
//        void (^block2)(void) = ^{
//            NSLog(@"block2 ---- %d", age);
//        };
//
//        NSLog(@"%@", [block2 class]);  //__NSGlobalBlock__ //必须在MRC条件下才是
//    }
//    return 0;
//}


//总结 ： 在MRC环境下
//没有访问auto变量，就是Global
//访问了auto变量，就是Stack
//__NSStackBlock__调用了copy，就是__NSMallocBlock__

//void (^block)(void);
//void test2(void) {
//    int age = 10;
//    block = [^{
//        NSLog(@"block------%d", age);
//    } copy];
//}
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        test2();
//
//        block();
//    }
//    return 0;
//}


//栈空间上的block，不会去持有这个对象（无法保住对象的命）


typedef void (^MJBlock) (void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MJBlock block;
        
        {
            MJPerson *person = [[MJPerson alloc] init];
            person.age = 10;
            
            __weak MJPerson *weakPerson = person;
            block = ^{
                NSLog(@"--------%ld", (long)weakPerson.age);
            };
        }
        NSLog(@"--------");
    }
    return 0;
}


