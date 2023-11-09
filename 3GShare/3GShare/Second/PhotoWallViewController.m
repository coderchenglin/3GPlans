//
//  PhotoWallViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import "PhotoWallViewController.h"

@interface PhotoWallViewController ()

@end

@implementation PhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageArray = [[NSMutableArray alloc] init];
    self.title = @"选择图片";
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pressSure:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor blackColor];
    
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    leftButton.tintColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _scrollView.contentSize = CGSizeMake(width, height);
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    int sum = 1;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            NSString* imageName = [[NSString alloc] initWithFormat:@"do%d.png", sum];
            _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_selectButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [_selectButton addTarget:self action:@selector(selectSure:) forControlEvents:UIControlEventTouchUpInside];
            _selectButton.frame = CGRectMake(10 + 190 * j, 120 * i, 178, 100);
            [_selectButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
            _selectButton.layer.masksToBounds = YES;
            _selectButton.layer.cornerRadius = 5.0;
            _selectButton.tag = 101 + sum;
            [_scrollView addSubview:_selectButton];
            sum++;
        }
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)pressSure:(UIButton*)rightbutton {
    if (_imageArray.count > 0) {
        for (UIButton *button in _imageArray) {
//            if (button.tag == 201) {
            if (button.tag == 201 ) {
                [_imageArray removeObject:button];
            }
        }
        UIAlertController* tipView = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功" preferredStyle:UIAlertControllerStyleAlert];
        [tipView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:tipView animated:YES completion:nil];
        [_delegate changePhoto:_imageArray];
    } else {
        //创建警告对话框
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"您没有选择要上传的图片，请重新选择您需要上传的图片" preferredStyle:UIAlertControllerStyleAlert];
        [warning addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:warning animated:YES completion:nil];
    }
}

- (void)pressReturn:(UIButton*)leftbutton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectSure:(UIButton*)selectButton {
    int i = 0;
    i++;

    //改bug：
    //NSLog(@"tag = %d",selectButton.tag); //这个是行参变量，也就是我选中的变量，我应该操作的是这个！
    //NSLog(@"tag = %d",_selectButton.tag);  //这个是全局属性！！！！！刚好跟这个行参名弄混了呜呜呜，改了半小时
    
    //选中
    if (selectButton.tag > 100) {
        UIImage* image = [UIImage imageNamed:@"download.png"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = 1; //用tag值，方便后面的删除
        imageView.frame = CGRectMake(160, 10, 16, 16);
        selectButton.tag -= 100;
        //NSLog(@"%d",selectButton.tag);
        //NSLog(@"i = %d",i);
        [_imageArray addObject:selectButton]; //这是一个全局的属性，用来记录被选中的button
        [selectButton addSubview:imageView];
    } else { //取消选中
//        for (UIImageView *view in selectButton.subviews) {
//            if (view.tag == 1) {
//                [view removeFromSuperview];
//            }
//        }
//        [_imageArray removeObject:selectButton];
//        selectButton.tag += 100;
        
        for (UIImageView *view in selectButton.subviews) {
            if (view.tag == 1) {
                [view removeFromSuperview];
            }
        }
        NSLog(@"%d",_imageArray.count);
        [_imageArray removeObject:selectButton];
        selectButton.tag += 100;
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
