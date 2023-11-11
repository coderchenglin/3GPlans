//
//  SetTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface SetTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *aImageView;
@property (nonatomic, strong) UIImageView *bImageView;
@property (nonatomic, strong) UILabel *mainLabel;

@end

NS_ASSUME_NONNULL_END
