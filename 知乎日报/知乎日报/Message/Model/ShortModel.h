//
//  ShortModel.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
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
