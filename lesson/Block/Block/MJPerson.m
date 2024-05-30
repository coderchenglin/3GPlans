//
//  MJPerson.m
//  Block
//
//  Created by chenglin on 2024/5/24.
//

#import "MJPerson.h"

@implementation MJPerson


- (void)test {
    void (^block)(void) = ^{
        NSLog(@"-------%p", self->_name);
    };
    block();
}

//这里捕获的不是_name，而是直接将self变量给捕获，再通过self变量去访问_name

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

-(void) dealloc {

    NSLog(@"MJPerson dealloc ---");
    [super dealloc];
}

@end
