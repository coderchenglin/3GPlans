//
//  View.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/2.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
NS_ASSUME_NONNULL_BEGIN

@interface View : UIView<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
- (void)addScrollView;
- (void)addAvplayer;

@property (nonatomic, strong) NSMutableArray *playersArray;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSArray *arrayData;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UIButton *moreButton;
@property (nonatomic, strong)UIButton *loginBtn;

@property (nonatomic, strong)UILabel *ZaoYu;
@property (nonatomic, strong)UILabel *zaoYuSub;
- (void)byteDance:(UIButton *)More;
- (void)createTabToJump;

#pragma mark 登录加载
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;//小菊花
- (void)showLoadMoreView;
- (void)hideLoadMoreView;
@end

NS_ASSUME_NONNULL_END
