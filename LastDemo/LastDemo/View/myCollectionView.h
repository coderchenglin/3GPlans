//
//  myCollectionView.h
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>
@class shuju;
NS_ASSUME_NONNULL_BEGIN

@interface myCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) shuju* shu;

@end

NS_ASSUME_NONNULL_END
