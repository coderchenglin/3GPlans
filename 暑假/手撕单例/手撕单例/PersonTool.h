//
//  PersonTool.h
//  手撕单例
//
//  Created by chenglin on 2024/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonTool : NSObject <NSCopying, NSMutableCopying>

+ (instancetype)sharedInstance;

//- (NSString *)getName;



@end

//首先，.h里面要遵守NSCopying和NSMutableCopying协议
//然后定义一个sharedInstance方法

NS_ASSUME_NONNULL_END
