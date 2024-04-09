//
//  ThirdTableViewCell.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *seeLabel;
@property (strong, nonatomic) UICollectionView *customCollectionView;

@end

NS_ASSUME_NONNULL_END
