//
//  VideoCell.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/3.
//

#import "VideoCell.h"

@implementation VideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 8.0;
    CGFloat width = CGRectGetWidth(self.contentView.frame) - 2 * padding;
    
    // Label布局
    CGSize labelSize = [self.descriptionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    self.descriptionLabel.frame = CGRectMake(padding, CGRectGetMaxY(self.expandButton.frame) + padding, CGRectGetWidth(self.contentView.frame) - 80, labelSize.height);
}

- (void)setupUI {
    //添加视图并进行布局
    //请根据实际需求自行调整布局和样式
    
    CGFloat padding = 8.0;
    CGFloat avatarSize = 40.0;
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, avatarSize, avatarSize)];
    self.avatarImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.avatarImageView];
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImageView.frame) + padding, padding, 200, avatarSize)];
    [self.contentView addSubview:self.usernameLabel];
    
    CGFloat screen = CGRectGetWidth([UIScreen mainScreen].bounds);
    
//    self.videoPlayerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.avatarImageView.frame) + padding, CGRectGetWidth(self.contentView.frame), 200)];
    self.videoPlayerView = [[UIView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.avatarImageView.frame) + padding, screen - padding * 2, 200)];
    [self.contentView addSubview:self.videoPlayerView];
    
    CGFloat buttonWidth = 80.0;
    CGFloat buttonHeight = 40.0;
    
    self.likesButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.likesButton.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - buttonWidth - padding, CGRectGetMaxY(self.videoPlayerView.frame) + padding, buttonWidth, buttonHeight);
//    [self.contentView addSubview:self.likesButton];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake(CGRectGetMinX(self.likesButton.frame) - buttonWidth - padding, CGRectGetMinY(self.likesButton.frame), buttonWidth, buttonHeight);
//    [self.contentView addSubview:self.collectButton];
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.commentButton.frame = CGRectMake(CGRectGetMinX(self.collectButton.frame) - padding, CGRectGetMinY(self.likesButton.frame), buttonWidth, buttonHeight);
//    [self.contentView addSubview:self.commentButton];
    
    //添加展开按钮
    self.expandButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.expandButton.frame = CGRectMake(padding, CGRectGetMinY(self.likesButton.frame) , 80, buttonHeight);
    [self.expandButton setTitle:@"点击展开" forState:UIControlStateNormal];
    [self.expandButton addTarget:self action:@selector(expandButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.expandButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.expandButton];
    
//    self.descriptionLabel = [[MYLabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.expandButton.frame) + padding, CGRectGetWidth(self.contentView.frame) - 2 * padding, 150)];
    
    self.descriptionLabel = [[MYLabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.expandButton.frame) + padding, CGRectGetWidth(self.contentView.frame) - 50, 150)];
    
    self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
    [self.descriptionLabel setVerticalAlignment:VerticalAlignmentTop];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
//    self.descriptionLabel.layer.borderWidth = 1.0;
//    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.descriptionLabel.numberOfLines = 1;  //默认显示一行
    
    [self.contentView addSubview:self.descriptionLabel];
    
    // 添加播放/暂停按钮
//    CGFloat buttonSize = CGRectGetWidth(self.videoPlayerView.frame);
    CGFloat pauseButtonWidth = CGRectGetWidth(self.videoPlayerView.frame);
    CGFloat pauseButtonHeight = CGRectGetHeight(self.videoPlayerView.frame);
    NSLog(@"pauseButtonWidth = %f,  pauseButtonHeight = %f", pauseButtonWidth, pauseButtonHeight);
    self.playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.playPauseButton.frame = CGRectMake(CGRectGetWidth(self.videoPlayerView.frame) / 2 - pauseButtonWidth / 2, CGRectGetHeight(self.videoPlayerView.frame) / 2 - pauseButtonHeight / 2, buttonWidth, buttonHeight);
    self.playPauseButton.frame = CGRectMake(padding, padding * 2 + avatarSize, pauseButtonWidth, pauseButtonHeight);
    
    [self.playPauseButton addTarget:self action:@selector(playPauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:self.playPauseButton];
    
//    // 添加播放按钮
//    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.playButton.frame = CGRectMake(CGRectGetWidth(self.videoPlayerView.frame) / 2 - buttonWidth / 2, CGRectGetHeight(self.videoPlayerView.frame) / 2 - buttonHeight / 2, buttonWidth, buttonHeight);
//    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
//    [self.playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoPlayerView addSubview:self.playButton];
//
//    // 添加暂停按钮
//    self.pauseButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.pauseButton.frame = CGRectMake(CGRectGetMinX(self.playButton.frame) - buttonWidth - padding, CGRectGetMinY(self.playButton.frame), buttonWidth, buttonHeight);
//    [self.pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
//    [self.pauseButton addTarget:self action:@selector(pauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoPlayerView addSubview:self.pauseButton];

}

- (void)setPlayer:(AVPlayer *)player {
    _player = player;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.videoPlayerView.bounds;
//    [self.videoPlayerView.layer addSublayer:self.playerLayer];
    [self.videoPlayerView.layer insertSublayer:self.playerLayer atIndex:0]; //将视频涂层插入到按钮图层下方
    
    //添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)playPauseButtonTapped:(UIButton *)sender {
    if (self.player.rate == 0) {
        // 播放
        [self.player play];
        [self.playPauseButton setImage:nil forState:UIControlStateNormal]; // 清除按钮图片
    } else {
        // 暂停
        [self.player pause];
        [self.playPauseButton setImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal]; // 设置按钮为播放图标
    }
}

//- (void)addObserverForPlayerItem:(AVPlayerItem *)playerItem {
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
//}

//- (void)playerItemDidPlayToEndTime:(NSNotification *)notification {
//    [self.player pause];
//    [self.playPauseButton setImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal];
//}

- (void)playDidFinishPlaying:(NSNotification *)notification {
    // 播放完成，暂停视频并将播放进度设置为0
    [self.player seekToTime:kCMTimeZero];
    [self.player pause];
    [self.playPauseButton setImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal]; // 设置按钮为播放图标
}


//- (void)playButtonTapped:(UIButton *)sender {
//    [self.player play];
//    self.playButton.hidden = YES;
//    self.pauseButton.hidden = NO;
//}
//
//- (void)pauseButtonTapped:(UIButton *)sender {
//    [self.player pause];
//    self.playButton.hidden = NO;
//    self.pauseButton.hidden = YES;
//}

- (void)setIsExpanded:(BOOL)isExpanded {
    _isExpanded = isExpanded;
    if (_isExpanded) {
        //展开状态
        [self.expandButton setTitle:@"点击收起" forState:UIControlStateNormal];
        self.descriptionLabel.numberOfLines = 0; //显示所有内容
    } else {
        // 收起状态
        [self.expandButton setTitle:@"点击展开" forState:UIControlStateNormal];
        self.descriptionLabel.numberOfLines = 1; //只显示一行
    }
    [self.contentView layoutIfNeeded];
}

- (void)expandButtonTapped:(UIButton *)sender {
    self.isExpanded = !self.isExpanded;
    // 触发代理方法通知TableView刷新高度
    if ([self.delegate respondsToSelector:@selector(cellDidToggleExpansion:)]) {
        [self.delegate cellDidToggleExpansion:self];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.player pause];
    [self.playerLayer removeFromSuperlayer];
    self.player = nil;
    self.playerLayer = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
