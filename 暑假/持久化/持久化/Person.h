//
//  Person.h
//  持久化
//
//  Created by chenglin on 2024/7/31.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) double weight;
@property (nonatomic, strong) Dog *dog;

@end

NS_ASSUME_NONNULL_END
