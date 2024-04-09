//
//  View.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/2.
//

#import "View.h"
#import "FifthViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "Masonry.h"
@implementation View
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addScrollView];
    [self addAvplayer];
    
    return self;
}



- (void)addScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //是否按照整页来滚动
    self.scrollView.pagingEnabled = YES;
    //是否可以开启滚动效果
    self.scrollView.scrollEnabled = YES;
    //设置画布的大小，画布显示在滚动视图内部，一般大雨Frame的大小
    //通过足够大的画布来承受足够多的图片
    //高增大会增大纵向滚动条
    self.scrollView.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width) * 5, [UIScreen mainScreen].bounds.size.height);
    self.scrollView.bounces = YES;
    //开启横向弹动效果
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    //设置背景颜色
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.layer.masksToBounds = YES;
    self.scrollView.tag = 100;
    [self addSubview:_scrollView];
}

- (void)addAvplayer {
    self.playersArray = [[NSMutableArray alloc] init];
    NSArray *videoArray = @[@"https://rxsss.oss-cn-beijing.aliyuncs.com/video/gbhf441.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/fgsdg.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/qwewq53.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/test3.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/qweq4.mp4"];
    for (int i = 0; i < 5; i++) {
        // 指定本地视频文件的路径
        // 正确处理文件名
//        NSString *fileName = [NSString stringWithFormat:@"%d", (101 + i)]; // 你的文件名应该是 101.mov, 102.mov 等
//        NSLog(@"%@", fileName);
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mov"];
//        NSURL *videoURL = [NSURL fileURLWithPath:filePath];
        
        //播放网络视频
        NSURL *videoURL = [NSURL URLWithString:videoArray[i]];
        
        self.playerItem = [AVPlayerItem playerItemWithURL:videoURL];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        
        // 创建AVPlayerLayer并将其作为子层添加到当前视图的层上
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = CGRectMake(i * SIZE_WIDTH, 0, SIZE_WIDTH, SIZE_HEIGHT);
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; // 设置视频填充模式
        
        
        [self.scrollView.layer addSublayer:playerLayer];
        [self.playersArray addObject:self.player];
        //视频播放完毕
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
        

        // 播放视频
        if (i == 0)
        [self.player play];
        
#pragma mark 播放按钮
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button1.frame = CGRectMake(i * SIZE_WIDTH, 80, SIZE_WIDTH, SIZE_HEIGHT / 2 + 160);
        self.button1.imageView.hidden = YES;
        self.button1.tag = i;
        [self.button1 setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateSelected]; // 显示图片
        [self.button1 setImage:nil forState:UIControlStateNormal]; // 隐藏图片

//        [self.button1 setTitle:@"111" forState:UIControlStateNormal];
        [self.button1 addTarget:self action:@selector(pressAct:) forControlEvents:UIControlEventTouchUpInside];
        self.isPlaying = YES;
        [self.scrollView addSubview:self.button1];
        
    #pragma mark 自定义字体More(登陆成功后可以点击)
//        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _moreButton.frame = CGRectMake(20, 650, SIZE_WIDTH - 40, 100);
//        [_moreButton setTitle:@"More" forState:UIControlStateNormal];
//        //    [_moreButton setFont:[UIFont fontWithName:@"NoMoreNich" size:30]];
//        UIFont *customFont_1 = [UIFont fontWithName:@"NoMoreNich" size:60];
//        [_moreButton.titleLabel setFont:customFont_1];
//        [self addSubview:_moreButton];
//        [self byteDance:_moreButton];
#pragma mark 登陆
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _loginBtn.frame = CGRectMake(40, 620, self.frame.size.width - 80, 60);
        _loginBtn.layer.cornerRadius = _loginBtn.frame.size.height / 6.0;
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.borderWidth = 2.0;
        _loginBtn.layer.borderColor = [UIColor redColor].CGColor;
        _loginBtn.backgroundColor = [UIColor systemRedColor];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.tintColor = [UIColor whiteColor];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:22];
//        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
        
//#pragma mark 注册
//        UIButton *registeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        registeBtn.frame = CGRectMake(self.frame.size.width - 160, 620, 120, 60);
//        registeBtn.layer.cornerRadius = registeBtn.frame.size.height / 6.0;
//        registeBtn.layer.masksToBounds = YES;
//        registeBtn.layer.borderWidth = 2.0;
//        registeBtn.backgroundColor = [UIColor redColor];
//        registeBtn.layer.borderColor = [UIColor redColor].CGColor;
//        [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
//        registeBtn.tintColor = [UIColor whiteColor];
//        registeBtn.titleLabel.font = [UIFont systemFontOfSize:22];
//        //添加注册时间
////        [registeBtn addTarget:self action:@selector(registe) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:registeBtn];

    #pragma mark 自定义字体slideyouran-Regular  躁愈
        _ZaoYu = [[UILabel alloc] init];
        self.ZaoYu.text = @"躁愈";
        UIFont *customFont_2 = [UIFont fontWithName:@"slideyouran-Regular" size:60];
        _ZaoYu.font = customFont_2;
        _ZaoYu.frame = CGRectMake(SIZE_WIDTH / 2 - 100 + i * SIZE_WIDTH, 150, 200, 50);
        _ZaoYu.textColor = [UIColor whiteColor];
        _ZaoYu.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:_ZaoYu];
        
        _zaoYuSub = [[UILabel alloc] init];
        self.zaoYuSub.text = @"因为关心，所以躁愈 因为陪伴，所以温暖";
        UIFont *customFont_3 = [UIFont fontWithName:@"slideyouran-Regular" size:22.5];
        _zaoYuSub.font = customFont_3;
        _zaoYuSub.numberOfLines = 2;
        _zaoYuSub.frame = CGRectMake(SIZE_WIDTH / 2 - 100 + i * SIZE_WIDTH, 200, 200, 100);
        _zaoYuSub.textColor = [UIColor whiteColor];
        _zaoYuSub.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:_zaoYuSub];
        
        
        [self addLoad];
        //方法二监听属性
//        [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    }
}



#pragma mark 字体跳动效果
- (void)byteDance:(UIButton *)More {
    // 配置动画参数
    CGFloat duration = 0.5; // 动画持续时间
    CGFloat delay = 0; // 延迟时间
    CGFloat springDamping = 0.7; // 阻尼系数（越小效果越明显）
    CGFloat initialSpringVelocity = 0.5; // 初始速度
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction;

    // 开始动画
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:springDamping
          initialSpringVelocity:initialSpringVelocity
                        options:options
                     animations:^{
                         // 放大
                        More.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     } completion:^(BOOL finished) {
                         // 恢复原样
                         More.transform = CGAffineTransformIdentity;
                     }];
}

#pragma mark 播放按钮事件
- (void)pressAct:(UIButton*)btn {
//    NSLog(@"1");
    NSInteger pageIndex = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (btn.tag == pageIndex) {
//        NSLog(@"%ld", btn.tag);
//        NSLog(@"%d", btn.isSelected);
        AVPlayer *player = self.playersArray[pageIndex];
        if (!btn.selected) {
            [player pause];
            //        if (btn.tag == pageIndex)
//            [btn setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateSelected]; // 显示图片
        } else {
            [player play];
//            [btn setImage:nil forState:UIControlStateNormal]; // 隐藏图片
        }
        NSLog(@"%ld %d", btn.tag, btn.selected);

        //暂停后是yes,前是no
        btn.selected = !btn.selected;
        self.isPlaying = !self.isPlaying; // 切换播放状态
    }

}

#pragma mark 结束播放后重新循环播放
- (void)videoDidFinishPlaying:(NSNotification *)notification {
    AVPlayerItem *finishedPlayerItem = notification.object;
    [self.playersArray enumerateObjectsUsingBlock:^(AVPlayer *player, NSUInteger idx, BOOL *stop) {
        if ([player.currentItem isEqual:finishedPlayerItem]) {
            // 找到了对应的播放器，从头开始播放
            [player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
                if (finished) {
                    [player play];
                }
            }];
            *stop = YES; // 停止遍历
        }
    }];
}

#pragma mark 加载菊花
- (void)addLoad {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleLarge)];
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor blackColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor clearColor];
}

#pragma mark 加载动画
- (void)showLoadMoreView {
    // 创建和配置加载动画视图
    [self addSubview:self.activityIndicator];
    [_activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.activityIndicator.tag = 123; // 设置一个标记以便后续移除
    [self.activityIndicator startAnimating];
    // 将加载动画视图添加到UIScrollView的底部
    self.tableView.tableFooterView = self.activityIndicator;
}
- (void)hideLoadMoreView {
    // 停止加载动画
    UIActivityIndicatorView *activityIndicator = [self.tableView.tableFooterView viewWithTag:123];
    [activityIndicator stopAnimating];
    
    // 隐藏加载动画视图
    self.tableView.tableFooterView = nil;
}



@end
