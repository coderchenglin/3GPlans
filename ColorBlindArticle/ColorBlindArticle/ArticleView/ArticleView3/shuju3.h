//
//  shuju3.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shuju3 : NSObject

@property (nonatomic, strong) NSMutableArray* titleArray;
@property (nonatomic, strong) NSMutableArray* contentArray;
@property (nonatomic, strong) NSArray *authorArray;

- (instancetype)initWithIndex: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
