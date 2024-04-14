//
//  ReturnModel.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/28.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReturnModel : JSONModel

@property (nonatomic, strong) NSString *Key;

@property (nonatomic, strong) NSString *Mykey;

@property (nonatomic, strong) NSString *Image;

@property (nonatomic, strong) NSString *Point;

@property (nonatomic, strong) NSString *Flag;

@end

NS_ASSUME_NONNULL_END
