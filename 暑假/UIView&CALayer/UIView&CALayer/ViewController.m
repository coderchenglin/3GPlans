//
//  ViewController.m
//  UIView&CALayer
//
//  Created by chenglin on 2024/8/13.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) CALayer *myLayer;

@end

@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    blueView.backgroundColor = [UIColor blueColor];
//    UIView *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//    redLabel.backgroundColor = [UIColor redColor];
//    [self.view addSubview:blueView];
//    [blueView addSubview:redLabel];
//
//    NSLog(@"Frame: %@, Bounds: %@", NSStringFromCGRect(blueView.frame), NSStringFromCGRect(blueView.bounds));
//    NSLog(@"Frame: %@, Bounds: %@", NSStringFromCGRect(redLabel.frame), NSStringFromCGRect(redLabel.bounds));
//
//    blueView.bounds = CGRectMake(0, 0, 300, 300);
//
//    NSLog(@"Frame: %@, Bounds: %@", NSStringFromCGRect(blueView.frame), NSStringFromCGRect(blueView.bounds));
//    NSLog(@"Frame: %@, Bounds: %@", NSStringFromCGRect(redLabel.frame), NSStringFromCGRect(redLabel.bounds));
//
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 添加到控制器的视图之中
//    [self.view.layer addSublayer:self.myLayer];
//
//    // 设置图层的内容
//    self.myLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"headImg.jpg"].CGImage);
////    // 设置阴影的颜色
//    self.myLayer.shadowColor = [UIColor redColor].CGColor;
////    // 设置阴影的偏移
//    self.myLayer.shadowOffset = CGSizeMake(15, 10);
////    // 设置阴影的不透明度
//    self.myLayer.shadowOpacity = 0.6;
////    // 设置边角半径
//    self.myLayer.cornerRadius = 50;
////    // 设置裁剪
////    self.myLayer.masksToBounds = YES;
////    // 设置边框线的颜色
//    self.myLayer.borderColor = [UIColor greenColor].CGColor;
////    // 设置边框线条的宽度
//    self.myLayer.borderWidth = 5.0;
//
//}
//
//-(CALayer *)myLayer{
//
//    if (_myLayer ==nil) {
//        // 创建layer对象
//        _myLayer = [CALayer layer];
//        // 设置图层的frame
//        _myLayer.frame = CGRectMake(50, 100, 190, 145);
//        // 设置背景颜色
//        _myLayer.backgroundColor = [UIColor greenColor].CGColor;
//
//        self.myLayer = _myLayer;
//    }
//    return _myLayer;
//}


//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 创建一个图层
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 100, 100);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//
//    // 默认 anchorPoint 是 (0.5, 0.5)
//    layer.position = CGPointMake(150, 150); // layer的中心点在(150, 150)
//
//    // 如果改变 anchorPoint
//    layer.anchorPoint = CGPointMake(0, 0); // 现在 position 是左上角的点
//    layer.position = CGPointMake(150, 150); // layer的左上角在(150, 150)
//
//    NSLog(@"Frame: %@, Bounds: %@", NSStringFromCGRect(layer.frame), NSStringFromCGRect(layer.bounds));
//
//    [self.view.layer addSublayer:layer];
//
////    [self.view.layer addSublayer:self.myLayer];
//}

//- (CALayer *)myLayer {
//    if (_myLayer == nil) {
//        _myLayer = [CALayer layer];
//        _myLayer.frame = CGRectMake(100, 100, 100, 100);
//        _myLayer.backgroundColor = [UIColor redColor].CGColor;
//        self.myLayer = _myLayer;
//    }
//    return _myLayer;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.myLayer.anchorPoint = CGPointMake(0, 0);
//}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加到控制器的视图之中
    [self.view.layer addSublayer:self.myLayer];

}

-(CALayer *)myLayer{
    if (_myLayer ==nil) {
        _myLayer = [CALayer layer];
        _myLayer.frame = CGRectMake(100, 100, 100, 100);
        _myLayer.backgroundColor = [UIColor redColor].CGColor;
        self.myLayer = _myLayer;
    }
    return _myLayer;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    // 关闭隐式动画
    self.myLayer.anchorPoint = CGPointMake(0, 0);
    // 执行动画事务
    NSLog(@"2");
    [CATransaction commit];
    
    NSLog(@"2");
}


@end
