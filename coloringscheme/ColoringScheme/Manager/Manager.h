//
//  Manager.h
//  ColoringScheme
//
//  Created by chenglin on 2024/3/23.
//

#import <Foundation/Foundation.h>
#import "ColorModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ColorModelBlock)(ColorModel *colorModel);
typedef void(^ErrorBlock)(NSError *error);

@interface Manager : NSObject

+ (instancetype)sharedManager;

- (void)requestColoringScheme: (NSString *)token success:(ColorModelBlock)success failure:(ErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
