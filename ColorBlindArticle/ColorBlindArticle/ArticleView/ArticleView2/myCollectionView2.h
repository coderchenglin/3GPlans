//
//  myCollectionView2.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>
@class shuju2;

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionView2 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) shuju2 *data;
@property (nonatomic, assign) NSInteger tag;

@end

NS_ASSUME_NONNULL_END
