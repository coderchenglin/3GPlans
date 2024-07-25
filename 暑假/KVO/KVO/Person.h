//
//  Person.h
//  KVO
//
//  Created by chenglin on 2024/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, strong) NSString *name; //被观察的类的属性
@end

NS_ASSUME_NONNULL_END
