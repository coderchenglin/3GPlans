//
//  ViewController.h
//  计时器
//
//  Created by 夏楠 on 2024/3/31.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TimerViewController : UIViewController
@property (copy, nonatomic) NSString *topicName;
@property (strong, nonatomic) UIDatePicker *timePicker;
@property (strong, nonatomic) UILabel *timerLabel;
@property (strong, nonatomic) UILabel *topic;
@property (strong, nonatomic) UIButton *startStopButton;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger remainingTime;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
- (void)updateTimerLabel;
- (void)startStopButtonTapped;
- (void)timerFired;

@end

