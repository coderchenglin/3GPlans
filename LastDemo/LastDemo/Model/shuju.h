//
//  shuju.h
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shuju : NSObject
@property (nonatomic, strong) NSMutableArray* arraytitle;
@property (nonatomic, strong) NSMutableArray* arraycontent;
@property (nonatomic, strong) NSArray* arrayauthor;
- (instancetype) init;
@end

NS_ASSUME_NONNULL_END
