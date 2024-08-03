//
//  subArray.m
//  copy修饰符
//
//  Created by chenglin on 2024/8/2.
//

#import "subArray.h"

@implementation subArray

- (id)copyWithZone:(NSZone *)zone {
    // 创建一个新的数组实例，可能是一个浅拷贝或深拷贝
    subArray *copy = [[subArray allocWithZone:zone] initWithArray:self];
    return copy;
}


@end
