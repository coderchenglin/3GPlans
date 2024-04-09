//
//  FirstCollectionViewCell.h
//  CollectionView
//
//  Created by 夏楠 on 2024/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UIImageView *smallImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@end

NS_ASSUME_NONNULL_END
