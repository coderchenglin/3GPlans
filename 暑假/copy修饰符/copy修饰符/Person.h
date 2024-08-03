//
//  Person.h
//  copy修饰符
//
//  Created by chenglin on 2024/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NSCopying>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@end

NS_ASSUME_NONNULL_END
