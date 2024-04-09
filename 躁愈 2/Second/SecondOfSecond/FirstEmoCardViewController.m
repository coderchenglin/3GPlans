//
//  ViewController.m
//  情绪卡片
//
//  Created by 夏楠 on 2024/3/28.
//

#import "FirstEmoCardViewController.h"
#import "SecondEmoCardViewController.h"

@interface FirstEmoCardViewController ()

@end

@implementation FirstEmoCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Add the label at the top of the view controller.
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, 40)];
    questionLabel.text = @"你感觉怎么样？";
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:questionLabel];

    // Add the date label below the question.
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 195, self.view.bounds.size.width, 30)];
    dateLabel.text = @"今天, 3月28日 星期二";
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = [UIColor greenColor];
    [self.view addSubview:dateLabel];

    // Mood buttons and labels
    _moodTitles = @[@"挺棒", @"还行", @"一般", @"不爽", @"超糟"];
//    NSArray *moodColors = @[[UIColor greenColor], [UIColor lightGrayColor], [UIColor blueColor], [UIColor orangeColor], [UIColor redColor]];
    
    CGFloat buttonSize = 60.0;
    CGFloat padding = 20.0;
    CGFloat startX = (self.view.bounds.size.width - (buttonSize * _moodTitles.count + padding * (_moodTitles.count - 1))) / 2;
    
    _moodImages = @[@"kuangxi.png", @"haixing.png", @"yiban.png", @"bushuang.png", @"chaolan.png"];
    
    for (int i = 0; i < _moodTitles.count; i++) {
        UIButton *moodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        moodButton.frame = CGRectMake(startX + (buttonSize + padding) * i - 10, 330, buttonSize + 20, buttonSize + 15);
//        moodButton.backgroundColor = moodColors[i];
        moodButton.layer.cornerRadius = buttonSize / 2;
        moodButton.clipsToBounds = YES;
        moodButton.tag = i; // Tag button to identify it later
        [moodButton addTarget:self action:@selector(moodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *tt = [UIImage imageNamed:_moodImages[i]];
        tt = [tt imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        [moodButton setImage:tt forState:UIControlStateNormal];
        [self.view addSubview:moodButton];
        
        UILabel *moodLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX + (buttonSize + padding) * i, 400, buttonSize, 20)];
        moodLabel.text = _moodTitles[i];
        moodLabel.textAlignment = NSTextAlignmentCenter;
        moodLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:moodLabel];
    }
    
}

- (void)moodButtonPressed:(UIButton *)sender {
    // Do something when a mood button is pressed
    NSLog(@"Mood button pressed: %ld", sender.tag);
    SecondEmoCardViewController *t = [[SecondEmoCardViewController alloc] init];
    t.emojyName = _moodTitles[sender.tag];
    t.emojyImage = _moodImages[sender.tag];
    t.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:t animated:YES completion:nil];
}


@end
