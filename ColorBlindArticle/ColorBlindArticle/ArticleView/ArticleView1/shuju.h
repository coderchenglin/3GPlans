//
//  shuju.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shuju : NSObject

@property (nonatomic, strong) NSMutableArray* titleArray;
@property (nonatomic, strong) NSMutableArray* contentArray;
@property (nonatomic, strong) NSArray *authorArray;

@end

NS_ASSUME_NONNULL_END
