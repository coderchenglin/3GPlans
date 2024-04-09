//
//  AVViewController.m
//  AVDemo
//
//  Created by chenglin on 2024/4/2.
//

#import "AVViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "PlayView.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface AVViewController ()

@property (nonatomic, strong) AVPlayerViewController *playerViewController;

@end

@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    PlayView *playView = [[PlayView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
//    [playView playWith:[NSURL URLWithString:@"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]];
//    [self.view addSubview:playView];
    
    
    // 初始化AVPlayer
    NSURL *videoURL = [NSURL URLWithString:@"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];

    // 初始化AVPlayerViewController并设置AVPlayer
    self.playerViewController = [[AVPlayerViewController alloc] init];
    self.playerViewController.player = player;

    // 设置AVPlayerViewController的frame，并将其添加到视图层次结构中
    self.playerViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.playerViewController];
    [self.view addSubview:self.playerViewController.view];

    // 开始播放视频
    [player play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
