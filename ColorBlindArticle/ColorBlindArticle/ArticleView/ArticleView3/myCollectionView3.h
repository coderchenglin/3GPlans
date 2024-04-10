//
//  myCollectionView3.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>
@class shuju3;

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionView3 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) shuju3 *data;
@property (nonatomic, assign) NSInteger tag;

@end

NS_ASSUME_NONNULL_END
