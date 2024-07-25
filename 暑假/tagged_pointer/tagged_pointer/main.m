//
//  main.m
//  tagged_pointer
//
//  Created by chenglin on 2024/7/19.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

//int main(int argc, char * argv[])
//{
//    @autoreleasepool {
//        NSNumber *number1 = @2;
//        NSNumber *number2 = @2;
//        NSNumber *number3 = @3;
//        NSNumber *numberFFFF = @(0xFFFF);
//
//        NSString *string1 = @"abc";
//
////        NSLog(@"number1 pointer is %p", number1);
////        NSLog(@"number2 pointer is %p", number2);
////        NSLog(@"number3 pointer is %p", number3);
////        NSLog(@"numberffff pointer is %p", numberFFFF);
//
//        NSLog(@"string1 \n%@\n%p\n%@", string1, string1, [string1 class]);
//        NSLog(@"number1 \n%@\n%p\n%@", number1, number1, [number1 class]);
//
//        //NSLog(@"%p", [number1 class]);
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}
//0x100dd0150
//000100000000110111010000000101010000

//0x100560090
//100000000010101100000000010010000
//0x104c50090
//100000100110001010000000010010000
//0x100bb0090
//100000000101110110000000010010000

//0x10407c130
//0x100da0130
//0x1045d0130

//0x1023f0130
//0x104a64130

#import "Person.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
       
        id str1 = [NSString stringWithFormat:@"123"];
        
        NSObject *obj = [[NSObject alloc] init];
        Person *person = [[Person alloc] init];
        //Class myclass = object_getClassName(str1);
        NSLog(@"str1 isa : %p", [str1 class]);
        NSLog(@"obj isa : %p", [obj class]);
        NSLog(@"person isa : %p", [person class]);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
