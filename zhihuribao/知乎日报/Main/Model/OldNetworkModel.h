//
//  OldNetworkModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/23.
//

#import <Foundation/Foundation.h>
#import "OldNetworkJSONModel.h"

typedef void (^OldNetworkBlock)(OldNetworkJSONModel * _Nullable oldNetworkModel);
typedef void (^ErrorOldBlock)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface OldNetworkModel : NSObject

@property (nonatomic, copy) NSString *nowDate;

+ (instancetype)shareOldNetworkModel;
//- (void)getNotification;
- (void)OldNetworkModelData:(OldNetworkBlock)oldNetworkDataBlock andError:(ErrorOldBlock)errorOldBlock;

@end

NS_ASSUME_NONNULL_END
