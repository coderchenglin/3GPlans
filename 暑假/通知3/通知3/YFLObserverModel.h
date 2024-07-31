//
//  YFLObserverModel.h
//  通知3
//
//  Created by chenglin on 2024/7/29.
//

#import <Foundation/Foundation.h>
#import "YFLNotification.h"

typedef void (^OperationBlock)(YFLNotification *note);

NS_ASSUME_NONNULL_BEGIN

@interface YFLObserverModel : NSObject

@property (nonatomic, strong) id observer;  //观察者对象
@property (nonatomic, assign) SEL selector; //执行的方法
@property (nonatomic, copy) NSString *notificationName; //通知名字
@property (nonatomic, strong) id object; //携带参数
@property (nonatomic, strong) NSOperationQueue *operationQueue; //队列
@property (nonatomic, copy) OperationBlock block;


@end

NS_ASSUME_NONNULL_END
