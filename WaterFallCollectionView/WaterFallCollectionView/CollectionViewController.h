//
//  CollectionViewController.h
//  WaterFallCollectionView
//
//  Created by chenglin on 2024/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

NS_ASSUME_NONNULL_END
