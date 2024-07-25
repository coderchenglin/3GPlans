//
//  ShortModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import "ShortJSONModel.h"

typedef void (^GetShortModelBlock)(ShortJSONModel * _Nullable shortModel);
typedef void (^ErrorBlock)(NSError* _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ShortModel : NSObject

@property (nonatomic, copy) NSString *shortID;

+ (instancetype)shareShortModel;
- (void)NetworkGetShortData:(GetShortModelBlock)shortModelBlock andError:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
