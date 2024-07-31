//
//  YFLNotificationCenter.h
//  通知3
//
//  Created by chenglin on 2024/7/29.
//

#import <Foundation/Foundation.h>
#import "YFLObserverModel.h"
#import "YFLNotification.h"
NS_ASSUME_NONNULL_BEGIN

@interface YFLNotificationCenter : NSObject

@property (nonatomic, strong) NSDictionary *obsetvers;
+ (YFLNotificationCenter *)defaultCenter;

@end

NS_ASSUME_NONNULL_END
