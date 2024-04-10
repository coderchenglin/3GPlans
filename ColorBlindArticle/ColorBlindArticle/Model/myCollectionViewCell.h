//
//  myCollectionViewCell.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *authorLabel;

@end

NS_ASSUME_NONNULL_END
