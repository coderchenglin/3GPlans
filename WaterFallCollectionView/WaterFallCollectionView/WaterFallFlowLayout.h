//
//  WaterFallFlowLayout.h
//  WaterFallCollectionView
//
//  Created by chenglin on 2024/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout> delegate; //其代理对象
@property (nonatomic, assign) NSInteger cellCount; //包含cell的个数
@property (nonatomic, strong) NSMutableArray *colArr; //存放每一个列的高度
@property (nonatomic, strong) NSMutableDictionary *attributeDict; //存放cell的位置信息

@end

NS_ASSUME_NONNULL_END
