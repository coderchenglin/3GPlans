//
//  FollowTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface FollowTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIColor *goodColor;

@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@end

NS_ASSUME_NONNULL_END
