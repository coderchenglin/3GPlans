//
//  MJStudent.m
//  Runtime
//
//  Created by chenglin on 2024/5/29.
//

#import "MJStudent.h"

@implementation MJStudent

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@", [self class]);  //MJStudent
        NSLog(@"%@", [self superclass]); //MJPerson
        
        NSLog(@"%@", [super class]); //MJStudent
        NSLog(@"%@", [super superclass]); //MJPerson
    }
    return self;
}

@end


//[super class]
//super关键字的意思是，从父类的类方法开始向上找
//但是消息接受者依然是self
//class方法是NSObject类的方法
//结论：消息结束者仍然是子类对象，只是从父类的方法列表开始找

//[super message]底层实现
//1.消息接受者还是子类对象
//2.只是从父类开始找方法实现


//isMemberOfClass
//isKindOfClass
//这两个方法的实例方法：是拿该对象的类与传进来的类进行比较，member是直接比较是否相等，kind回沿着super往上查找
//这两个方法的类方法：是拿该类的元类与传进来的类进行比较，同样member是直接比较是否相等，kind回沿着super往上查找
//所以，正确的使用方法应该是：如果调用者是实例对象，就传类进行比较。如果调用者是类对象，就传元类进行比较。
//
//注意坑：[NSObjcet class]，沿着元类的super一直往上找，最后一层就是NSObject类

