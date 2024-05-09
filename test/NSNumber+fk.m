//
//  NSNumber+fk.m
//  test
//
//  Created by chenglin on 2024/5/7.
//

#import "NSNumber+fk.h"

//为类别提供实现部分
@implementation NSNumber (fk)
//实现类别的接口部分定义的4个方法
- (NSNumber*) jia: (double) num2
{
    return [NSNumber numberWithDouble: ([self doubleValue] + num2)];
}
- (NSNumber*) jian: (double) num2
{
    return [NSNumber numberWithDouble: ([self doubleValue] - num2)];
}
- (NSNumber*) cheng: (double) num2
{
    return [NSNumber numberWithDouble: ([self doubleValue] * num2)];
}
- (NSNumber*) chu: (double) num2
{
    return [NSNumber numberWithDouble: ([self doubleValue] / num2)];
}
@end
