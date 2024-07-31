//
//  MyClass+MyProperty.h
//  Category
//
//  Created by chenglin on 2024/7/23.
//

#import "MyClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyClass (MyProperty)
@property (nonatomic, copy) NSString *myProperty;
- (void)test;
@end

NS_ASSUME_NONNULL_END
