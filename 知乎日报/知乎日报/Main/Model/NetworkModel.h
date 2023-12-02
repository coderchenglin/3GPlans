//
//  NetworkModel.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//
//
//#import <Foundation/Foundation.h>
//#import "NetworkJSONModel.h"
//
//typedef void (^NetworkBlock)(NetworkJSONModel * _Nullable networkModel);
//typedef void (^ErrorBlock)(NSError * _Nullable error);
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface NetworkModel : NSObject
//
//+ (instancetype)shareNetworkModel; //创建一个网络的单例类
//- (void)NetworkModelData:(NetworkBlock)networkDataBlock andError:(ErrorBlock)errorBlock;
//
//
//@end
//
//NS_ASSUME_NONNULL_END


#import <Foundation/Foundation.h>
#import "NetworkJSONModel.h"

typedef void (^NetworkBlock)(NetworkJSONModel * _Nullable networkModel);
typedef void (^ErrorBlock)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface NetworkModel : NSObject

+ (instancetype)shareNetworkModel;
- (void)NetworkModelData:(NetworkBlock)networkDataBlock andError:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
