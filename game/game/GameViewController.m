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

@interface GameViewController ()

@property (nonatomic, strong) CALayer *circleLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

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
    NSURL *gifURL = [NSURL URLWithString:@"https://wimg.588ku.com/gif/21/08/30/c4aa2ea5bc8bc3b048970e80d1d15a6f.gif"];

    [self.characterImageView sd_setImageWithURL:gifURL];
    [self.view addSubview:self.characterImageView];
    // 创建一个 UITapGestureRecognizer 手势识别器
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    // 将手势识别器添加到视图上
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // 设置透明按钮
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(45, 530, 90, 120)];
    self.button1.backgroundColor = [UIColor clearColor];

    [self.button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    // 创建一个圆形图层
    self.circleLayer = [CALayer layer];
    _circleLayer.bounds = CGRectMake(90, 590, 50, 50);
    _circleLayer.cornerRadius = 25;
    _circleLayer.position = CGPointMake(90, 590);
    _circleLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _circleLayer.opacity = 0; // 初始透明度为0，不可见

    // 将圆形图层添加到父视图中
    [self.view.layer addSublayer:_circleLayer];

    // 创建动画
    self.animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    _animation.duration = 1; // 动画持续时间
    _animation.fromValue = @(1); // 初始透明度
    _animation.toValue = @(0); // 目标透明度
//    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; // 缓动函数
}

- (void)button1Tapped:(UIButton *)button {
    // 获取点击位置
    CGPoint touchPoint = [button convertPoint:CGPointMake(CGRectGetWidth(button.bounds) / 2, CGRectGetHeight(button.bounds) / 2) toView:self.view];
    NSLog(@"%f, %f", touchPoint.x, touchPoint.y);
    // 更新圆形图层的位置
    _circleLayer.position = touchPoint;
    // 添加动画到图层
    [_circleLayer addAnimation:_animation forKey:@"opacityAnimation"];
    
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

        });
    }];
}

@end
