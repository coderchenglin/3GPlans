//
//  ColorGameView.h
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorGameView : UIView

@property (nonatomic, strong)UICollectionView* collectionView;

@property (nonatomic, strong)UILabel* scoreLabel;
@property (nonatomic, strong)UILabel* topScoreLabel;
@property (nonatomic, strong)UILabel* healthLabel;

@property (nonatomic, strong)UIProgressView* progressView;

@end

NS_ASSUME_NONNULL_END
