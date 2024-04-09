//
//  ColorGameController.h
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>
#import "ColorGameView.h"
#import "ColorGameModel.h"
#import "ColorBlockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColorGameController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)ColorGameView* colorGameView;
@property (nonatomic, strong)ColorGameModel* colorGameModel;
@property (nonatomic, strong)NSMutableArray<ColorBlockModel *>* blocks;

@property (nonatomic, weak)NSTimer* gameTimer;
@property (nonatomic, assign)CGFloat currentTime;

@end

NS_ASSUME_NONNULL_END
