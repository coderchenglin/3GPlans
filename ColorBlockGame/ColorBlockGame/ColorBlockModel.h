//
//  ColorBlockModel.h
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface ColorBlockModel : NSObject

@property (nonatomic, strong)UIColor* color;
@property (nonatomic, assign)BOOL isDifferent;

@end

NS_ASSUME_NONNULL_END
