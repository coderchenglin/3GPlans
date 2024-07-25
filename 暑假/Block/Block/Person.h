//
//  Person.h
//  Block
//
//  Created by chenglin on 2024/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)dealloc;

- (void)someMethod;

- (void)executeBlock:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
