//
//  MyObserver.h
//  KVO3
//
//  Created by chenglin on 2024/8/1.
//

#import <Foundation/Foundation.h>
#import "MyObservableObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyObserver : NSObject
@property (nonatomic, strong) MyObservableObject *observableObject;

@end

NS_ASSUME_NONNULL_END
