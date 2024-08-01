//
//  MyObservableObject.h
//  KVO3
//
//  Created by chenglin on 2024/8/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyObservableObject : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *items;
@end

NS_ASSUME_NONNULL_END
