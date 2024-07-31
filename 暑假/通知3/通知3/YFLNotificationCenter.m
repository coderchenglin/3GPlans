//
//  YFLNotificationCenter.m
//  通知3
//
//  Created by chenglin on 2024/7/29.
//

#import "YFLNotificationCenter.h"

@implementation YFLNotificationCenter

+ (YFLNotificationCenter*)defaultCenter
{
    static YFLNotificationCenter *singleton;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        singleton = [[self alloc] initSingleton];
    });
    
    return singleton;
}


- (instancetype)initSingleton
{

    if ([super init]) {
    
        _obsetvers = [[NSMutableDictionary alloc]init];
    
    }
    
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString*)aName object:(nullable id)anObject
{
    
    //如果不存在，那么即创建
    if (![self.obsetvers objectForKey:aName]) {
        
        NSMutableArray *arrays = [[NSMutableArray alloc]init];
       
        // 创建数组模型
        YFLObserverModel *observerModel = [[YFLObserverModel alloc]init];
        observerModel.observer = observer;
        observerModel.selector = aSelector;
        observerModel.notificationName = aName;
        observerModel.object = anObject;
        [arrays addObject:observerModel];
        
        //填充进入数组
        [self.obsetvers setObject:arrays forKey:aName];
    }else{
        //如果存在，取出来，继续添加进去即可
        NSMutableArray *arrays = (NSMutableArray*)[self.obsetvers objectForKey:aName];
        // 创建数组模型
        YFLObserverModel *observerModel = [[YFLObserverModel alloc]init];
        observerModel.observer = observer;
        observerModel.selector = aSelector;
        observerModel.notificationName = aName;
        observerModel.object = anObject;
        [arrays addObject:observerModel];
    }
}

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(YFLNotification *note))block
{
    //如果不存在，那么即创建
    if (![self.obsetvers objectForKey:name]) {
        
        NSMutableArray *arrays = [[NSMutableArray alloc]init];
        
        // 创建数组模型
        YFLObserverModel *observerModel = [[YFLObserverModel alloc]init];
        observerModel.block = block;
        observerModel.notificationName = name;
        observerModel.object = obj;
        observerModel.operationQueue = queue;
        [arrays addObject:observerModel];
        
        //填充进入数组
        [self.obsetvers setObject:arrays forKey:name];
    }else{
        //如果存在，取出来，继续添加即可
        NSMutableArray *arrays = (NSMutableArray*)[self.obsetvers objectForKey:name];
        
        // 创建数组模型
        YFLObserverModel *observerModel = [[YFLObserverModel alloc]init];
        observerModel.block = block;
        observerModel.notificationName = name;
        observerModel.object = obj;
        observerModel.operationQueue = queue;
        [arrays addObject:observerModel];
    }
    return nil;
}

- (void)postNotification:(YFLNotification *)notification
{
    //name 取出来对应观察者数组，执行任务
    NSMutableArray *arrays = (NSMutableArray*)[self.obsetvers objectForKey:notification.name];
    
    [arrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
        //取出数据模型
        YFLObserverModel *observerModel = obj;
        id observer = observerModel.observer;
        SEL secector = observerModel.selector;
        
        if (!observerModel.operationQueue) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [observer performSelector:secector withObject:notification];
#pragma clang diagnostic pop
        }else{

            //创建任务
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
               
                //这里用block回调出去
                observerModel.block(notification);
                
            }];
            
            // 如果添加观察者 传入 队列，那么就任务放在队列中执行(子线程异步执行)
            NSOperationQueue *operationQueue = observerModel.operationQueue;
            [operationQueue addOperation:operation];
        }
    }];
}




@end
