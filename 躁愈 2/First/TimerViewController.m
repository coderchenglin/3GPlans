//
//  ViewController.m
//  计时器
//
//  Created by 夏楠 on 2024/3/31.
//

#import "TimerViewController.h"
#import "Masonry.h"
extern UIColor *darkerColorOfBack;
@interface TimerViewController ()

@end

@implementation TimerViewController

// 在 ViewController.m 的 viewDidLoad 方法中设置 UI 组件
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self updateTimerLabel];
    [self setupAudioPlayer];
}

- (void)initView {
    self.view.backgroundColor = darkerColorOfBack;
    // 时间选择器
    self.timePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    self.timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    self.timePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
//    self.timePicker.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
    [self.view addSubview:self.timePicker];
    [self.timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);;
        make.centerY.equalTo(self.view.mas_centerY).offset(-50);
            make.width.equalTo(@400);
            make.height.equalTo(@400);
    }];
    
    // 时间显示标签
    self.timerLabel = [[UILabel alloc] init];
    self.timerLabel.font = [UIFont systemFontOfSize:60];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timerLabel];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);;
        make.centerY.equalTo(self.view.mas_centerY).offset(-50);
            make.width.equalTo(@400);
            make.height.equalTo(@400);
    }];
    self.timerLabel.hidden = YES;
    
    // 开始/停止按钮
    self.startStopButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.startStopButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.startStopButton setImage:[UIImage imageNamed:@"kaishi.png"] forState:UIControlStateNormal];
    [self.startStopButton addTarget:self action:@selector(startStopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startStopButton];
    [self.startStopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timePicker.mas_bottom).offset(-20);
            make.centerX.equalTo(self.timePicker.mas_centerX);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
    }];
    
    self.topic = [[UILabel alloc] init];
    [self.view addSubview:self.topic];
    self.topic.text = _topicName;
    [_topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view).offset(20);
            make.width.equalTo(@100);
            make.height.equalTo(@50);
    }];
    _topic.textAlignment = NSTextAlignmentCenter;
    _topic.font = [UIFont systemFontOfSize:20];
}

#pragma mark 初始化AVAudioPlayer
- (void)setupAudioPlayer {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"白噪音-雨滴声" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
    
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    if (error) {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else {
        self.audioPlayer.numberOfLoops = 0; // 不循环播放
        [self.audioPlayer prepareToPlay];
    }
}

- (void)startStopButtonTapped {
    // 用户点击开始/停止按钮
    if (self.timer.isValid) {
        // 如果定时器已经在运行，则停止定时器和音乐
        [self stopTimer];
        [self.audioPlayer pause]; // 暂停音乐
        [self.startStopButton setImage:[UIImage imageNamed:@"kaishi.png"] forState:UIControlStateNormal];
        self.timerLabel.hidden = YES;
        self.timePicker.hidden = NO;
    } else {
        // 如果定时器不在运行，读取时间选择器的时间，然后开始定时器和音乐
        self.remainingTime = (NSInteger)self.timePicker.countDownDuration;
        [self updateTimerLabel];
        [self startTimer];
        [self.audioPlayer play]; // 播放音乐
        [self.startStopButton setImage:[UIImage imageNamed:@"zanting.png"] forState:UIControlStateNormal]; // 假设你有一个名为zanting.png的暂停图标
        self.timerLabel.hidden = NO;
        self.timePicker.hidden = YES;
    }
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [self.timePicker setHidden:YES]; // 隐藏时间选择器
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self.timePicker setHidden:NO]; // 显示时间选择器
}

- (void)timerFired {
    // 定时器触发
    if (self.remainingTime > 0) {
        self.remainingTime--;
        [self updateTimerLabel];
    } else {
        [self stopTimer];
        [self.startStopButton setTitle:@"开始" forState:UIControlStateNormal];
        // 可以在这里添加额外的计时结束时的操作
        self.timerLabel.hidden = YES;
        self.timePicker.hidden = NO;
    }
}

- (void)updateTimerLabel {
    // 更新计时器的显示
    NSInteger minutes = self.remainingTime / 60;
    NSInteger seconds = self.remainingTime % 60;
    self.timerLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}



#pragma mark 数据持久化
//    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsPath = [docPath objectAtIndex:0];
//    NSLog(@"Documents目录：%@",documentsPath);
//
//    NSString *homePath = NSHomeDirectory();
//    NSLog(@"Home目录：%@",homePath);
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"PointsSystem.plist"];
//
//    // 正确初始化NSMutableDictionary对象
//    NSMutableDictionary *userPointsInfo = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
//
//    // 确保userPointsInfo不为空
//    if (!userPointsInfo) {
//        userPointsInfo = [[NSMutableDictionary alloc] init];
//    }
//
//    [userPointsInfo setObject:@"张三" forKey:@"name"];
//    [userPointsInfo setObject:@"155xxxxxxx" forKey:@"phone"];
//    [userPointsInfo setObject:@"29" forKey:@"age"];
//
//    // 将字典持久化到文件中
//    BOOL writeSuccess = [userPointsInfo writeToFile:filePath atomically:YES];
//
//    // 检查写入是否成功
//    if (writeSuccess) {
//        NSLog(@"写入文件成功");
//    } else {
//        NSLog(@"写入文件失败");
//    }
//
//    NSLog(@"%@", filePath);

@end
