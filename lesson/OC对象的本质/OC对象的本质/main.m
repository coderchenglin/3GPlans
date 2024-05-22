//
//  main.m
//  OC对象的本质
//
//  Created by chenglin on 2024/5/21.
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "malloc/malloc.h"

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        NSObject *obj = [[NSObject alloc] init];
//        //获得NSObject类的实例对象的成员变量所占用的大小
//        NSLog(@"%zu", class_getInstanceSize([NSObject class])); //8
//        //获得obj指针所指向内存的大小
//        NSLog(@"%zu", malloc_size((__bridge const void*)obj)); //16（源码硬性规定）
//        Class obj1 = [NSObject class]; //Class就是一个指针，32位4个字节，64位8个字节
//
//    }
//    return 0;
//}


#pragma mark 对象的本质

//struct Student_IMPL {
//    Class isa;
//    int _no;
//    int _age;
//    char _num;
//};
//
////Student
//@interface Student : NSObject
//{
//    @public
//    int _no;
//    int _age;
//    char _num;
//}
//
//@end
//
//@implementation Student
//
//@end
//
////man
//@interface Man : Student
//{
//    @public
//    int _money;
//}
//
//@end
//
//@implementation Man
//
//@end
//
//
//int main(int argc, const char* argv[]) {
//    @autoreleasepool {
//        Student *student = [[Student alloc] init];
//        student->_no = 4;
//        student->_age = 5;
//
//        struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)student;
//        NSLog(@"no is %d, age is %d", stuImpl->_no, stuImpl->_age);
//        //NSLog(@"%@", stuImpl->isa);
//
//        NSLog(@"%zu", class_getInstanceSize([Student class])); //24  //这里是因为结构体内存对齐   8个字节的倍数（因为isa指针是8字节） //返回的是这个类创建出的实例至少需要的内存空间
//        //sizeof是一个运算符！计算的是类型的大小！不是函数！是在编译阶段就能算出来的东西
//
//        NSLog(@"%zu", malloc_size((__bridge const void*)student)); //32  16个字节的倍数（因为苹果操作系统给对象在堆上分配内存时，分配的都是16字节的倍数）
//        //这个是操作系统实际分配的空间，是操作系统的内存对齐
//
//        Man *man = [[Man alloc] init];
//        man->_money = 10000;
//        NSLog(@"%zu", class_getInstanceSize([Man class])); //24
//
//        NSLog(@"%zu", malloc_size((__bridge const void*)man)); //32
//
//    }
//}


#pragma mark 类对象的本质

//int main(int argc, const char* argv[]) {
//    @autoreleasepool {
//        //实例对象
//        NSObject *obj1 = [[NSObject alloc] init];
//        NSObject *obj2 = [[NSObject alloc] init];
//
//        //类对象
//        Class objectClass1 = [obj1 class];
//        Class objectClass2 = [obj2 class];
//        Class objectClass3 = object_getClass(obj1);
//        Class objectClass4 = object_getClass(obj2);
//        Class objectClass5 = [NSObject class];
//
//        //元类对象 - 这个方法
//        //如果传“实例对象”进去，就返回“类对象”
//        //如果传“类对象”进去，就可以获得“元类对象”
//        //如果传“元类对象”进去，返回NSObject（基类）meta-class对象
//        Class objectMetaClass = object_getClass(objectClass1);
//
//        //class方法返回的永远是类对象
//        Class objectMetaClass2 = [[[NSObject class] class] class];
//
//        NSLog(@"objectMetaClass = %p, objectMetaClass2 =  %p", objectMetaClass, objectMetaClass2);
//
//
//        //验证：
//        //以上都是类对象，类对象在内存中只会存储一份 , 下面打印出的地址都是一样的
//        NSLog(@"%p %p %p %p %p", objectClass1, objectClass2, objectClass3, objectClass4, objectClass5); // 0x1fc7b6e70 0x1fc7b6e70 0x1fc7b6e70 0x1fc7b6e70 0x1fc7b6e70
//
//        NSLog(@"objectMetaClass - %p, %d", objectMetaClass, class_isMetaClass(objectMetaClass)); //判断是否是一个元类对象
//
//    }
//}




//类对象在内存中存储的信息主要包括
//isa指针，superclass指针
//类的属性信息，类的对象方法信息 （注意不是类方法）
//类的协议信息，类的成员变量信息
//（注意，这里的成员变量信息，不是成员变量的值（这个存储在实例对象中），这里存储的是成员变量的名字，类型等信息，即对成员变量的描述信息，这些信息只需要存储一份）


//如何获取元类对象？
//Class objectMetaClass = object_getClass([NSObject class]); // Runtime API


//元类对象在内存中存储的主要信息包括
//isa指针
//superclass指针
//（*）类方法信息（class method）
//然后类对象中有的这里也有，比如属性信息，对象方法信息，协议信息，成员变量信息，只不过都是nil的
//就是，内存结构是一样的，只是都是空，然后加了一个类方法信息


//三个方法的区分：
//Class objc_getClass(const char* aClassName)
//1. 传入字符串类名
//2. 返回对应的类对象
//
//Class object_getClass(id obj)
//1.传入的可能是instance对象，class对象，meta-class对象
//返回的分别是类对象，元类对象，基类（NSObject）的元类对象那个
//
//class方法返回的就是类对象
