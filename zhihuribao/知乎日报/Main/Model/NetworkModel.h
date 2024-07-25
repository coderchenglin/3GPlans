//
//  NetworkModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/18.
//

#import <Foundation/Foundation.h>
#import "NetworkJSONModel.h"

//定义一个块类型
//参数是NetworkJSONModel类型，返回值为void
typedef void (^NetworkBlock)(NetworkJSONModel * _Nullable networkModel);
typedef void (^ErrorBlock)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface NetworkModel : NSObject

//单例方法
+ (instancetype)shareNetworkModel;
//网络请求的方法
- (void)NetworkModelData:(NetworkBlock)networkDataBlock andError:(ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
