//
//  MyCollectionViewCell.h
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewCell : UICollectionViewCell

- (void)setImage:(UIImage *)image and:(NSInteger)buttonTag;
@property (nonatomic, strong) UIButton *deleteButton;

@end

NS_ASSUME_NONNULL_END
