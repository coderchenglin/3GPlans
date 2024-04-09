//
//  User.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, assign) NSInteger points;
+ (instancetype)shareUser;
@end

NS_ASSUME_NONNULL_END
