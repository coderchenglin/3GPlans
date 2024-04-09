//
//  Manager.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/25.
//


#import <Foundation/Foundation.h>
#import "ColorTestModel.h"
#import "OptionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TestModelBlock)(ColorTestModel *colorTestModel);
typedef void(^OptionModelBlock)(OptionModel* optionModel);
typedef void(^ErrorBlock)(NSError *error);

@interface Manager : NSObject

+ (instancetype)sharedManager;

- (void)requestColorBlindTest: (NSString *)token success:(TestModelBlock)success failure:(ErrorBlock)failure;

- (void)postColorBlindOptionArray: (NSString *)token success:(OptionModelBlock)success failure:(ErrorBlock)failure didSelectOption:(NSArray *)optionArray;

@end

NS_ASSUME_NONNULL_END
