//
//  VideoCell.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/3.
//

#import <UIKit/UIKit.h>
#import "MYLabel.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VideoCell;

@protocol VideoCellDelegate <NSObject>

- (void)cellDidToggleExpansion:(VideoCell *)cell;

@end

@interface VideoCell : UITableViewCell

@property (nonatomic, weak) id<VideoCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIView *videoPlayerView;
@property (nonatomic, strong) UIButton *likesButton;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) MYLabel *descriptionLabel;
@property (nonatomic, strong) UIButton *expandButton; // 新增的按钮

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, assign) BOOL isExpanded; // 标记是否展开

@property (nonatomic, strong) UIButton *playPauseButton; // 播放按钮
//@property (nonatomic, strong) UIButton *pauseButton; // 暂停按钮

@end

NS_ASSUME_NONNULL_END
