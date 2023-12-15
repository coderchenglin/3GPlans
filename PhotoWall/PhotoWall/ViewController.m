//
//  ViewController.m
//  PhotoWall
//
//  Created by chenglin on 2023/12/15.
//

#import "ViewController.h"
#import "PhotoViewController.h"

@interface ViewController ()<TransitionPhotoDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
}

- (void)creatView {
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoButton.backgroundColor = [UIColor grayColor];
    [self.photoButton setTitle:@"请添加图片" forState:UIControlStateNormal];
    [self.photoButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.photoButton];
    [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置宽和高
        //make.width.mas_equalTo(100);
        //make.height.mas_equalTo(50);
        
        //使用链式语法同时设置宽和高
        make.size.mas_equalTo(CGSizeMake(300, 200));
        
        //使用链式语法同时设置上边界和左边界
        //make.left.top.mas_equalTo(20);
        
        //使用链式语法同时设置所有边界
        //make.edges.mas_equalTo(UIEdgeInsetsMake(300, 40, 300, 40));
        
        //中心点
        //设置视图相对于父视图的水平中心点和垂直中心点
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(100);
        
        //设置中心点与俯视图相同
        //make.center.mas_equalTo(self.view);
    }];
    
}

- (void)pressButton:(UIButton *)button {
    PhotoViewController *photo = [[PhotoViewController alloc] init];
    photo.modalPresentationStyle = UIModalPresentationFullScreen;
    photo.delegate = self;
    [self presentViewController:photo animated:YES completion:nil];
}

//实现协议函数
- (void)changePhoto:(NSMutableArray *)imageArray {
    
    if (self.quantity.tag == 1) {
        [self.quantity removeFromSuperview];
    }
    
    UIButton *button = imageArray[0];
    NSString *imageName = [[NSString alloc] initWithFormat:@"1-%ld.jpeg", button.tag - 1];
    NSInteger sum = imageArray.count;
    [self.photoButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString* number = [[NSString alloc] initWithFormat:@"%ld", sum];
    self.quantity = [[UILabel alloc] init];
    self.quantity.text = number;
    self.quantity.textColor = [UIColor redColor];
    self.quantity.tag = 1;
    self.quantity.backgroundColor = [UIColor whiteColor];
    //self.quantity.frame = CGRectMake(240, 3, 18, 18);
    [self.photoButton addSubview:self.quantity];
    [self.quantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.photoButton).offset(-20);
        make.top.equalTo(self.photoButton).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
}


@end
