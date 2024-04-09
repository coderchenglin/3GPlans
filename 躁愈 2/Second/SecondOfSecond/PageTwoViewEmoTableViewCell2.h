//
//  replyTableViewCell.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/6.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageTwoViewEmoTableViewCell2 : UITableViewCell
@property (nonatomic, strong) UIImageView* commentHeadPhotoImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* contentLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIButton* pinglunButton;
@property (nonatomic, strong) UIStackView *verticalStackView;

@end

NS_ASSUME_NONNULL_END
