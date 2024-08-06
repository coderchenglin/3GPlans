//
//  MyArrayManager.h
//  KVO4
//
//  Created by chenglin on 2024/8/3.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyArrayManager : NSObject

@property (nonatomic, strong) NSMutableArray<MyModel *> *models;

- (void)addModel:(MyModel *)model;
- (void)removeModelAtIndex:(NSUInteger)index;
- (void)replaceModelAtIndex:(NSUInteger)index withModel:(MyModel *)model;

@end

NS_ASSUME_NONNULL_END
