//
//  Person.h
//  Catagory
//
//  Created by chenglin on 2024/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;
- (void)printGreeting;

@end

NS_ASSUME_NONNULL_END
