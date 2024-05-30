//
//  MJPerson.h
//  Block
//
//  Created by chenglin on 2024/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJPerson : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name;
- (void)test;

@end

NS_ASSUME_NONNULL_END
