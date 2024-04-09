//
//  myCollectionViewCell.h
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* imageview;
@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIImageView* avatarimageview;
@property (nonatomic, strong) UIButton* likebutton;
@property (nonatomic, strong) UILabel* authorlable;

@end

NS_ASSUME_NONNULL_END
