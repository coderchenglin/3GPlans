//
//  myCollectionView4.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>
@class shuju4;

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionView4 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) shuju4 *data;
@property (nonatomic, assign) NSInteger tag;

@end

NS_ASSUME_NONNULL_END
