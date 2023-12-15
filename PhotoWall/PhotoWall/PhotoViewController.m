//
//  PhotoViewController.m
//  PhotoWall
//
//  Created by chenglin on 2023/12/15.
//

#import "PhotoViewController.h"

#define mywidth [UIScreen mainScreen].bounds.size.width
#define myheight [UIScreen mainScreen].bounds.size.height

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatPhoto];
}

- (void)creatPhoto {
    
    self.imageArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, mywidth, myheight)];
    self.scrollView.contentSize = CGSizeMake(mywidth, myheight + 110);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:self.backButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(40);
        make.top.equalTo(self.view).with.offset(50);
    }];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sureButton setTitle:@"上传" forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:self.sureButton];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-40);
        make.top.equalTo(self.view).with.offset(50);
    }];
    
    int sum = 1;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 5 ; j++) {
            NSString *imageName = [[NSString alloc] initWithFormat:@"1-%d.jpeg", i * 3 + j + 1];
            NSLog(@"%d",i * 3 + j + 1);
            self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.imageButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self.imageButton addTarget:self action:@selector(pressPhoto:) forControlEvents:UIControlEventTouchUpInside];
            self.imageButton.tag = 101 + sum;
            [self.scrollView addSubview:self.imageButton];
            
            
            [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.scrollView.mas_left).offset(30 + 185 * i);
                make.width.equalTo(@170);
                make.top.equalTo(self.scrollView.mas_top).offset(30 + 185 * j);
                make.height.equalTo(@170);
            }];
            
            sum++;
        }
    }
}

- (void)pressPhoto:(UIButton *)selectButton {
    if (selectButton.tag > 100) {
        UIImage *iamge = [UIImage imageNamed:@"download.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:iamge];
        imageView.tag = 1;
        imageView.frame = CGRectMake(150, 10, 16, 16);
        selectButton.tag -= 100;
        [self.imageArray addObject:selectButton];
        [selectButton addSubview:imageView];
    } else {
        for (UIImageView *view in selectButton.subviews) {
            if (view.tag == 1) {
                [view removeFromSuperview];
            }
        }
        [self.imageArray removeObject:selectButton];
        selectButton.tag += 100;
    }
}

- (void)back:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sure:(UIButton *)button {
    if (_imageArray.count > 0) {
        for (UIButton *button in _imageArray) {
            if (button.tag == 857) {
                [_imageArray removeObject:button];
            }
        }
        UIAlertController *tipView = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功" preferredStyle:UIAlertControllerStyleAlert];
        [tipView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:tipView animated:true completion:nil];
        [self.delegate changePhoto:self.imageArray];
    } else {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"您没有选择要上传的图片，请重新选择您需要上传的图片" preferredStyle:UIAlertControllerStyleAlert];
        [warning addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:warning animated:YES completion:nil];
    }
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
