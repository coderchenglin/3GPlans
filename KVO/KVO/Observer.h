//
//  Observer.h
//  KVO
//
//  Created by chenglin on 2024/4/21.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observer : NSObject

@property (nonatomic, strong) Person *person;

@end

NS_ASSUME_NONNULL_END
