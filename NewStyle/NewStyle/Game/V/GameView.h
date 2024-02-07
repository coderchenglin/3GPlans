//
//  GameView.h
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameView : UIView

- (void)viewInit;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) int flagOfPhoto;  //图片下标
@property (nonatomic, assign) int flagOfDelete;

- (void)insertPhotoDataBase:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
