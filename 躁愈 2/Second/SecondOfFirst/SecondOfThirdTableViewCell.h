//
//  SecondOfThirdTableViewCell.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/10.
//

#import <UIKit/UIKit.h>
@class PageOneModel;
NS_ASSUME_NONNULL_BEGIN

@interface SecondOfThirdTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *seeLabel;
@property (strong, nonatomic) UICollectionView *customCollectionView;
@property (nonatomic, strong) PageOneModel *pageOneModel;

@end

NS_ASSUME_NONNULL_END
