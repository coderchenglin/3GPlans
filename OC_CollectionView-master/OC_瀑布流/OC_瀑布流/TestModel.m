//
//  TestModel.m
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
