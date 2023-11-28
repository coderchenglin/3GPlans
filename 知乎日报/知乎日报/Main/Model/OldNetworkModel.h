//
//  OldNetworkModel.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import <Foundation/Foundation.h>
#import "OldNetworkJSONModel.h"

//定义两个块
typedef  void (^OldNetworkBlock)(OldNetworkJSONModel * _Nullable oldNetworkModel);
typedef  void (^ErrorOldBlock)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface OldNetworkModel : NSObject

@property (nonatomic, copy) NSString *nowDate;

+ (instancetype)shareOldNetworkModel;
- (void)getNotification;
- (void)OldNetworkModelData:(OldNetworkBlock)oldNetworkDataBlock andError:(ErrorOldBlock)errorOldBlock;

@end

NS_ASSUME_NONNULL_END
