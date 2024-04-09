//
//  FirstViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import "FirstViewController.h"
#import "FirstModel.h"
#import "FirstView.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ButtonTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "FourthTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "TimerViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeModel = [[FirstModel alloc] init];
    
    [self initHomeView];
    [self registeTableViewCell];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoWithURL:) name:@"playVideo" object:nil];

}

#pragma mark 播放视频
- (void)playVideoWithURL:(NSNotification *)send {
    NSURL *url = send.userInfo[@"key"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = player;
    
    // 在当前视图控制器上模态展示播放器视图控制器
    [self presentViewController:playerViewController animated:YES completion:^{
        [player play];
    }];
}

- (void)registeTableViewCell {
    [self.homeView.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"first"];
    [self.homeView.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"second"];
    [self.homeView.tableView registerClass:[ButtonTableViewCell class] forCellReuseIdentifier:@"button"];
    [self.homeView.tableView registerClass:[ThirdTableViewCell class] forCellReuseIdentifier:@"third"];
    [self.homeView.tableView registerClass:[FourthTableViewCell class] forCellReuseIdentifier:@"fourth"];
}

- (void)initHomeView {
    self.homeView = [[FirstView alloc] initWithFrame:self.view.bounds];
    self.homeView.Date.text = [self.homeModel getDate];
    self.homeView.Month.text = [self.homeModel getMonth];
    self.homeView.Tip.text = [self.homeModel getClockTip];
    self.homeView.tableView.dataSource = self;
    self.homeView.tableView.delegate = self;
    [self.view addSubview:_homeView];
}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 100;
    } else if(indexPath.section == 0){
        return 225;
    } else if (indexPath.section == 4) {
        return 255;
    } else {
        return 240;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [self.homeView.tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
        return cell;

    } else if (indexPath.section == 2){
        SecondTableViewCell *cell = [self.homeView.tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
        cell.titleLabel.text = @"Albums";
        cell.seeLabel.text = @"See All";
        return cell;
    } else if (indexPath.section == 1) {
        ButtonTableViewCell *cell = [self.homeView.tableView dequeueReusableCellWithIdentifier:@"button" forIndexPath:indexPath];
        [cell.btn1 addTarget:self action:@selector(jumpToTimerVC1) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(jumpToTimerVC2) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(jumpToTimerVC3) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector(jumpToTimerVC4) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    } else if (indexPath.section == 3) {
        ThirdTableViewCell *cell = [self.homeView.tableView dequeueReusableCellWithIdentifier:@"third" forIndexPath:indexPath];
        cell.titleLabel.text = @"Health";
        cell.seeLabel.text = @"See All";
        return cell;
    } else {
        FourthTableViewCell *cell = [self.homeView.tableView dequeueReusableCellWithIdentifier:@"fourth" forIndexPath:indexPath];
        cell.titleLabel.text = @"Health";
        cell.seeLabel.text = @"See All";
        return cell;
    }
    return 0;
}

#pragma mark 计时
- (void)jumpToTimerVC1{
    TimerViewController *t = [[TimerViewController alloc] init];
//    t.modalPresentationStyle = UIModalPresentationFullScreen;
    t.topicName = @"专注";
    [self presentViewController:t animated:YES completion:nil];
}
- (void)jumpToTimerVC2{
    TimerViewController *t = [[TimerViewController alloc] init];
//    t.modalPresentationStyle = UIModalPresentationFullScreen;
    t.topicName = @"睡眠";
    [self presentViewController:t animated:YES completion:nil];
}
- (void)jumpToTimerVC3{
    TimerViewController *t = [[TimerViewController alloc] init];
//    t.modalPresentationStyle = UIModalPresentationFullScreen;
    t.topicName = @"小憩";
    [self presentViewController:t animated:YES completion:nil];
}
- (void)jumpToTimerVC4{
    TimerViewController *t = [[TimerViewController alloc] init];
//    t.modalPresentationStyle = UIModalPresentationFullScreen;
    t.topicName = @"呼吸";
    [self presentViewController:t animated:YES completion:nil];
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
