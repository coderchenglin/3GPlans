//
//  ZLObject.h
//  内存对齐
//
//  Created by chenglin on 2024/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLObject : NSObject

@property (nonatomic, strong, nullable) NSString *name;
@property (nonatomic, assign) int age;

- (void)doSomething;

@end

NS_ASSUME_NONNULL_END
