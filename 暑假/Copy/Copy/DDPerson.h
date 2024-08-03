//
//  DDPerson.h
//  Copy
//
//  Created by chenglin on 2024/8/2.
//

#import <Foundation/Foundation.h>
#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPerson : NSObject <NSCopying, NSMutableCopying, NSSecureCoding>

@property (nonatomic, assign) int age;
@property (nonatomic, strong) Car *car;
@property (nonatomic, strong) NSMutableArray <Car *> *cars;

@end

NS_ASSUME_NONNULL_END
