//
//  subArray.h
//  copy修饰符
//
//  Created by chenglin on 2024/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface subArray : NSArray <NSCopying>

- (id)copyWithZone:(nullable NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
