//
//  ColorGameModel.h
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorGameModel : NSObject

@property (nonatomic, assign)NSInteger currentScore;
@property (nonatomic, assign)NSInteger topScore;
@property (nonatomic, assign)NSInteger level;
@property (nonatomic, assign)NSInteger health;

@end

NS_ASSUME_NONNULL_END
