//
//  ColorGameModel.m
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import "ColorGameModel.h"

@implementation ColorGameModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentScore = 0;
        self.topScore = 0;
        self.level = 3;
        self.health = 3;
    }
    return self;
//    @property (nonatomic, assign)NSInteger currentScore;
//    @property (nonatomic, assign)NSInteger topScore;
//    @property (nonatomic, assign)NSInteger level;
//    @property (nonatomic, assign)NSInteger health;
}

@end
