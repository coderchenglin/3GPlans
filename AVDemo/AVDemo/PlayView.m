//
//  PlayView.m
//  AVDemo
//
//  Created by chenglin on 2024/4/2.
//

#import "PlayView.h"
#import <AVFoundation/AVFoundation.h>



/**工具视图的高度*/
#define Tool_View_Height 40.0f
@interface PlayView ()
/**安放常用控件的view*/
@property (nonatomic, strong)UIView *toolView;
/**播放器*/
@property (nonatomic, strong)AVPlayer *player;
/**进度条*/
@property (nonatomic, strong)UISlider *progress;
/**播放暂停按钮*/
@property (nonatomic, strong)UIButton *playOrPauseBtn;

/**播放的状态*/
@property (nonatomic, assign)BOOL isPlay;
/**同步屏幕刷新计时器*/
@property (nonatomic, strong)CADisplayLink *link;
/**当前的播放状态*/
@property (nonatomic, assign)AVPlayerItemStatus status;
/**当前缓冲的时间*/
@property (nonatomic, assign)NSTimeInterval loadedTime;
/**菊花图*/
@property (nonatomic, strong)UIActivityIndicatorView *loadingView;
@end

@implementation PlayView
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.loadingView];
        self.loadingView.hidden = YES;
    }
    return self;
}
- (void)dealloc {
    //移除计时器
    [self.link invalidate];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
#pragma mark - 设置播放网址
- (void)playWith:(NSURL *)url {
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];

    //设置播放页面layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 2);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:layer];
    [self addSubview:self.toolView];
    [self.toolView addSubview:self.playOrPauseBtn];
    [self.toolView addSubview:self.progress];
    //设置监听播放器的状态
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //设置监听播放器的缓冲时间
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //设置计时器
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeProgress)];
    self.link.paused = YES;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
#pragma mark - 懒加载
- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingView.color = [UIColor blackColor];
        _loadingView.center = self.center;
        //仿射变换放大菊花图
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
        _loadingView.transform = transform;
    }
    return _loadingView;
}

- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - Tool_View_Height, self.bounds.size.width, Tool_View_Height)];
        _toolView.backgroundColor = [UIColor blackColor];
    }
    return _toolView;
}
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
        _playOrPauseBtn.imageView.tintColor = [UIColor whiteColor];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playOrPauseBtn;
}
- (UISlider *)progress {
    if (!_progress) {
        _progress = [[UISlider alloc]initWithFrame:CGRectMake(40, 10, self.bounds.size.width - 100, 20)];
        _progress.tintColor = [UIColor orangeColor];

//        UIImage *thumb_normal = [UIImage imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 5, 20)];
//        UIImage *thumb_selected = [UIImage imageWithColor:[UIColor orangeColor] rect:CGRectMake(0, 0, 5, 20)];
//        [_progress setThumbImage:thumb_normal forState:UIControlStateNormal];
//        [_progress setThumbImage:thumb_selected forState:UIControlStateHighlighted];
        [_progress addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _progress;
}

#pragma mark - 播放或者暂停
- (void)playOrPauseAction:(UIButton *)sender {
    if (sender.isSelected == NO) {
        sender.selected = YES;
        [self.player play];
        self.isPlay = YES;
        self.link.paused = NO;
    }else {
        sender.selected = NO;
        [self.player pause];
        self.isPlay = NO;
        self.link.paused = YES;
    }
}
#pragma mark - 播放器播放
- (void)playPlayer {
    [self.player play];
    self.playOrPauseBtn.selected = YES;
    self.isPlay = YES;
    self.link.paused = NO;
}
#pragma mark - 播放器暂停
- (void)pausePlayer {
    [self.player pause];
    self.playOrPauseBtn.selected = NO;
    self.isPlay = NO;
    self.link.paused = YES;
}
#pragma mark - 监听播放器
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        self.status = playerItem.status;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            NSLog(@"准备播放");
            self.link.paused = NO;
        }else {
            NSLog(@"没准备好播放");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSLog(@"缓冲时间发生了变化");
        self.loadedTime = [self getLoadedTime];
        
    }
}
#pragma mark - 改变进度条
- (void)changeProgress{
    //获取视频总时间
    NSTimeInterval totalTime = CMTimeGetSeconds(self.player.currentItem.duration);
    //获取视频的当前时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    self.progress.maximumValue = totalTime;
    [self.progress setValue:currentTime];
    //如果播放结束了
    if (totalTime == currentTime) {
        self.playOrPauseBtn.selected = NO;
    }
}
- (void)progressChanged:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    //暂停播放
    [self pausePlayer];
    if (self.status == AVPlayerItemStatusReadyToPlay) {
        //显示菊花
        self.loadingView.hidden = NO;
        [self.player seekToTime:CMTimeMake(slider.value, 1) completionHandler:^(BOOL finished) {
            [self playPlayer];
            //隐藏菊花
            self.loadingView.hidden = YES;
        }];
    }
    
    
}
#pragma mark - 获取已缓存的时间
- (NSTimeInterval)getLoadedTime {
    NSArray *loadedTimeRanges = [self.player.currentItem loadedTimeRanges];
    //获取缓冲区域
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    //缓存的进度
    return startSeconds + durationSeconds;
}
@end


