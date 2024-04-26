//
//  GameViewController.m
//  game
//
//  Created by chenglin on 2024/4/24.
//

#import "GameViewController.h"
#import <UIKit/UIKit.h>
#import "UIImage+GIF.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景图
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:@"background1.jpg"];
    [self.view addSubview:self.backgroundImageView];
    
    // 设置小人图
    // 设定位置和大小
    // 设置GIF动图URL
    self.characterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 700, 50, 50)];
//    NSURL *gifURL = [NSURL URLWithString:@"https://s1.aigei.com/src/img/gif/27/2706624c99614e778cad47e3d5944f95.gif?imageMogr2/auto-orient/thumbnail/!282x282r/gravity/Center/crop/282x282/quality/85/%7CimageView2/2/w/282&e=1735488000&token=P7S2Xpzfz11vAkASLTkfHN7Fw-oOZBecqeJaxypL:dDbf5P5UM-K40Gc573osUKn1Oyo="];
    NSURL *gifURL = [NSURL URLWithString:@"https://wimg.588ku.com/gif/21/08/30/c4aa2ea5bc8bc3b048970e80d1d15a6f.gif"];

    [self.characterImageView sd_setImageWithURL:gifURL];
//    self.characterImageView.image = [UIImage imageNamed:@"小人.gif"];
    [self.view addSubview:self.characterImageView];
    
    // 设置透明按钮
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(45, 530, 90, 120)];
    self.button1.backgroundColor = [UIColor clearColor];

    [self.button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    
//    // 设置下一步按钮
//    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 100, 40, 80, 40);
//    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    [self.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.nextButton];
    
}

//- (void)nextButtonTapped:(UIButton *)button {
//    if (self.num == 0) {
//        self.num++;
//        NSString *string1 = @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
//        [self setLabel:string1];
//
//    } else if (self.num == 1) {
//        self.num++;
//        NSString *string2 = @"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc";
//        [self setLabel:string2];
//    } else if (self.num == 2) {
//        self.num++;
//        NSString *string2 = @"dddddd";
//        [self setLabel:string2];
//    }
//}

//- (void)setLabel:(NSString *)string {
//    [self.label1 removeFromSuperview];
//
//
//
//
//    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(160, 150, 200, 100)];
////        self.label1.backgroundColor = [UIColor redColor];
//    self.label1.layer.borderWidth = 0.5;
//    self.label1.layer.borderColor = [UIColor blackColor].CGColor;
//    self.label1.numberOfLines = 0;
//    self.label1.font = [UIFont systemFontOfSize:20.0];
////        [self.label1 sizeToFit];
//    self.label1.layer.cornerRadius = 10.0;
//    self.label1.layer.masksToBounds = YES;
//    self.label1.text = string;
//
//    [self.view addSubview:self.label1];
//}

- (void)button1Tapped:(UIButton *)button {
    
    [UIView animateWithDuration:3.0 animations:^{
        self.characterImageView.frame = CGRectMake(70, 600, 50, 50);
    } completion:^(BOOL finished) {
        
        double delayInSeconds = 0.5;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            // 在延迟后执行的代码块
            NSLog(@"延迟1秒后执行的代码");
            // 这里可以添加需要延迟执行的任务
            
            NewViewController *newViewController = [[NewViewController alloc] init];
            newViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:newViewController animated:YES completion:nil];
            
//            self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 200, 50, 50)];
//            self.imageView1.image = [UIImage imageNamed:@"对话人物.jpg"];
//            [self.view addSubview:self.imageView1];
//
//            NSString* string = @"000000000";
//            [self setLabel:string];
        });
        
    }];
}

@end
