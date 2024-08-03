//
//  Person2.h
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person2 : NSObject <NSCopying, NSMutableCopying>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
