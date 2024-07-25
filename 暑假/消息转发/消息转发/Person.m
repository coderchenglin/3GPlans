//
//  Person.m
//  消息转发
//
//  Created by chenglin on 2024/7/21.
//

#import "Person.h"
#import <objc/runtime.h>
//#import "animal.h"
#import "Student.h"

@implementation Person

struct method_t {
    SEL sel;
    char *types;
    IMP imp;
};

- (void)other {
    NSLog(@"%s", __func__);
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {  //sel代表无法响应的方法名
//    if (sel == @selector(test)) {
//        //获取其他方法
//        Method method = class_getInstanceMethod([self class], @selector(other));  //这是一个runtime函数，需要包含头文件#import <objc/runtime.h>，
//            //参数一：（class）sel是未能响应的方法的类，就传[self class]
//            //参数二（SEL）name是要查找的方法名（就是自己动态添加的方法的方法名），传 @selector(方法名)
//        //动态添加test的方法
//        class_addMethod([self class], sel, method_getImplementation(method), method_getTypeEncoding(method));//这也是一个runtime函数，用于动态的向一个类添加一个新的方法。
//        //参数一：（Class）cls是要添加方法的类，就传[self class]
//        //参数二：（SEL）name表示未能相应的方法名，就传sel
//        //参数三：（IMP）imp是方法的实现函数指针, 就传method_getImplementation(method)
//        //参数四：（const char*）types是方法的类型编码字符串，就传method_getTypeEncoding(method))
//    }
//    return [super resolveInstanceMethod:sel];
//} //系统默认返回NO

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        return [[Student alloc] init];
    }
    return nil;
} //系统默认返回nil
//调用forwardingTargetForSelector，返回值不为nil时，会调用objc_msgSend(返回值, SEL)，结果就是调用了objc_msgSend(Student,test)


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {

        //这三种实现方法都可以
        return [[[Student alloc] init] methodSignatureForSelector:aSelector];
        //return [[Student class] instanceMethodSignatureForSelector:aSelector];
        //return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

    if ([anInvocation selector] == @selector(test)) {

    } else {

    }

    NSLog(@"这里我想干嘛就干嘛");
}


@end
