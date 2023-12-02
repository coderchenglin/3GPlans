//
//  LongModel.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <Foundation/Foundation.h>
#import "LongJSONModel.h"

typedef void (^GetLongModelBlock)(LongJSONModel * _Nullable longModel);
typedef void (^ErrorBlock)(NSError * _Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface LongModel : NSObject

@property (nonatomic, strong) NSString *LongID;

+ (instancetype)shareLongModel;
- (void)NetworkGetLongData:(GetLongModelBlock)longModelBlock andError:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
