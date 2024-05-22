//
//  Person.m
//  Catagory
//
//  Created by chenglin on 2024/5/20.
//

#import "Person.h"

//扩展声明
@interface Person ()

//私有属性
@property (nonatomic, assign) NSInteger age;

//私有方法
- (void)printAge;

@end

@implementation Person

//实现公开的方法
- (void)printGreeting {
    NSLog(@"Hello, my name is %@.", self.name);
    [self printAge];
}

//实现私有的方法
- (void)printAge {
    NSLog(@"I am %ld years old.", (long)self.age);
}

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}

@end
