//
//  Dog.h
//  持久化
//
//  Created by chenglin on 2024/7/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject <NSSecureCoding>
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
