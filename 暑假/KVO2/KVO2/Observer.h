//
//  Observer.h
//  KVO2
//
//  Created by chenglin on 2024/8/1.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observer : NSObject

@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) NSDictionary *dic;

@end

NS_ASSUME_NONNULL_END
