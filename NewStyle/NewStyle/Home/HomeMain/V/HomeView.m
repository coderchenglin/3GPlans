//
//  HomeView.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "HomeView.h"
#import "Masonry.h"
#import "HomeViewController.h"
//系统相机
#import "AVFoundation/AVfoundation.h"
//系统相册
#import "AssetsLibrary/AssetsLibrary.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface HomeView () <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *titleImageView; //标题
@property (nonatomic, strong) UIScrollView *buttonScrollView; //上面按钮滑动视图
@property (nonatomic, strong) UIScrollView *imageScrollView; //下面图片滚动视图
@property (nonatomic, strong) UIButton *smallButton;//上方按钮
@property (nonatomic, strong) UILabel *nameLabel; //上方按钮名称
@property (nonatomic, strong) UIImageView *mainImageView; //下方图片
@property (nonatomic, strong) NSArray *nameArray; //名字数组
@property (nonatomic, strong) UIButton *alreadySelectButton; //记录上一次选择的按钮
@property (nonatomic, strong) NSMutableArray *buttonArray;
    //将循环创建的button存储起来
@property (nonatomic, assign) int alreadySelectPage; //记录上一次划到的页数
@property (nonatomic, strong) UILabel *imageLabel; //下方图片上文字

//动画图片
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;
@property (nonatomic, strong) UIImageView *fourImageView;
@property (nonatomic, strong) UIImageView *fiveImageView;
@property (nonatomic, strong) UIImageView *sixImageView;
@property (nonatomic, strong) UIImageView *sevenImageView;

@property (nonatomic, strong) UIImage *image; //从相册调取到的图片
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UIImageView *clearImageView; //图片点击事件
@property (nonatomic, assign) int numberOfFix; //确定是哪一个功能

@end


@implementation HomeView

- (void)viewInit {
    self.nameArray = @[@"旧图片修复", @"人像动漫化", @"图片去雾", @"增强对比度", @"图片清晰化", @"黑白图片上色", @"图片色彩增强"];
    self.alreadySelectPage = 0;
    [self addSubview:self.titleImageView];
    [self buttonScrollViewInit];
    [self imageScrollViewInit];
    [self imagePickerInit];
}

//头部标题初始化
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SIZE_WIDTH - 170) / 2, 45, 170, 40)];
        self.titleImageView.image = [UIImage imageNamed:@"title1.png"];
    }
    return _titleImageView;
}

//小的滚动视图初始化
- (void)buttonScrollViewInit {
    
    self.buttonScrollView = [[UIScrollView alloc] init];
    self.buttonScrollView.backgroundColor = [UIColor clearColor];
    self.buttonScrollView.tag = 666;
    self.buttonScrollView.delegate = self;
    self.buttonScrollView.scrollEnabled = YES;
    self.buttonScrollView.bounces = YES;
    self.buttonScrollView.showsVerticalScrollIndicator = NO;
    self.buttonScrollView.showsHorizontalScrollIndicator = NO;
    self.buttonScrollView.contentSize = CGSizeMake(1.75 * SIZE_WIDTH, 0);
    [self addSubview:self.buttonScrollView];
    [self.buttonScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView).offset(70);
        make.height.equalTo(@120);
        make.width.equalTo(@(SIZE_WIDTH));
        make.left.equalTo(self).offset(0);
    }];
    
    UIColor *groundColor = [UIColor colorWithRed:(32.0f / 255.0f) green:(31.0f / 255.0f) blue:(38.0f / 255.0f) alpha:1.0f];
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        self.smallButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.smallButton.layer.masksToBounds = YES;
        self.smallButton.tag = i;
        if (i == 0) {
            self.smallButton.backgroundColor = [UIColor colorWithRed:(67.0f / 255.0f) green:(64.0f / 255.0f)blue:(79.0f / 255.0f) alpha:1.0f];
            [self.smallButton setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"t%d.png", i]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            self.smallButton.layer.cornerRadius = (SIZE_WIDTH / 4 - 30) / 2;
            self.smallButton.frame = CGRectMake(15 + (SIZE_WIDTH / 4) * i, 5, SIZE_WIDTH / 4 - 30, SIZE_WIDTH / 4 - 30);
            self.alreadySelectButton = self.smallButton;
        } else {
            self.smallButton.backgroundColor = groundColor;
            [self.smallButton setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"s%d.png", i]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            self.smallButton.layer.cornerRadius = (SIZE_WIDTH / 4 - 30) / 2;
            self.smallButton.frame = CGRectMake(15 + (SIZE_WIDTH / 4) * i, 5, SIZE_WIDTH / 4 - 30, SIZE_WIDTH / 4 - 30);
        }
        [self.buttonArray addObject:self.smallButton];
        [self.smallButton addTarget:self action:@selector(pressSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonScrollView addSubview:self.smallButton];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.frame = CGRectMake(7.5 + (SIZE_WIDTH / 4) * i, 5 + SIZE_WIDTH / 4 - 30, SIZE_WIDTH / 4 - 30 + 15, 40);
        self.nameLabel.text = self.nameArray[i];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.buttonScrollView addSubview:self.nameLabel];
    }
}

//上方按钮点击
- (void)pressSelect:(UIButton *)button {
    
    [self.imageScrollView setContentOffset:CGPointMake(SIZE_WIDTH * button.tag, 0) animated:YES]; //下面跟着动
    if (![button isEqual:self.alreadySelectButton]) {
        //新点击按钮变色
        button.backgroundColor = [UIColor colorWithRed:(67.0f / 255.0f) green:(64.0f / 255.0f)blue:(79.0f / 255.0f) alpha:1.0f];
        [button setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"t%ld.png", (long)button.tag]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal]; //?
        
        //上一次点击按钮复原
        self.alreadySelectButton.backgroundColor = [UIColor colorWithRed:(32.0f / 255.0f) green:(31.0f / 255.0f)blue:(38.0f / 255.0f) alpha:1.0f];
        
        [self.alreadySelectButton setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"s%ld.png", (long)self.alreadySelectButton.tag]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        //更新上一次点击的按钮
        self.alreadySelectButton = button;
        
        //按钮的位置移植中间
        if (button.tag == 0 || button.tag == 1) {
            [self.buttonScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } else if (button.tag <= 4) {
            [self.buttonScrollView setContentOffset:CGPointMake((SIZE_WIDTH / 4) * (button.tag - 2) + SIZE_WIDTH / 8, 0) animated:YES];
        } else {
            [self.buttonScrollView setContentOffset:CGPointMake(0.75 * SIZE_WIDTH, 0) animated:YES];
        }
        self.alreadySelectPage = (int)button.tag;
    }
    
}

//大的滚动视图初始化
- (void)imageScrollViewInit {
    self.imageScrollView = [[UIScrollView alloc] init];
    self.imageScrollView.contentSize = CGSizeMake(SIZE_WIDTH * 7, 0);
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    self.imageScrollView.tag = 999;
    self.imageScrollView.delegate = self;
    self.imageScrollView.userInteractionEnabled = YES;
    self.imageScrollView.scrollEnabled = YES;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.bounces = YES;
    self.imageScrollView.showsVerticalScrollIndicator = NO;
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.imageScrollView];
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonScrollView).offset(130);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-110);
    }];
    
    for (int i = 0; i < 7; i++) {
        self.mainImageView = [[UIImageView alloc] init];
        self.mainImageView.frame = CGRectMake(20 + SIZE_WIDTH * i, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.mainImageView.backgroundColor = [UIColor yellowColor];
        self.mainImageView.layer.masksToBounds = YES;
        self.mainImageView.layer.cornerRadius = 30;
        self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%d.jpg",i]];
        [self.imageScrollView addSubview:self.mainImageView];
        
        self.imageLabel = [[UILabel alloc] init];
        self.imageLabel.text = self.nameArray[i];
        self.imageLabel.textAlignment = NSTextAlignmentCenter;
        self.imageLabel.backgroundColor = [UIColor clearColor];
        self.imageLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:25];
        self.imageLabel.textColor = [UIColor colorWithRed:(195.0f / 255.0f) green:(92.0f / 255.0f)blue:(146.0f / 255.0f) alpha:1.0f];
        self.imageLabel.frame = CGRectMake(40 + SIZE_WIDTH * i, SIZE_HEIGHT - 420, SIZE_WIDTH - 80, 100);
        [self.imageScrollView addSubview:self.imageLabel];
    }
    
    self.firstImageView = [[UIImageView alloc] init];
    self.secondImageView = [[UIImageView alloc] init];
    self.thirdImageView = [[UIImageView alloc] init];
    self.fourImageView = [[UIImageView alloc] init];
    self.fiveImageView = [[UIImageView alloc] init];
    self.sixImageView = [[UIImageView alloc] init];
    self.sevenImageView = [[UIImageView alloc] init];
    
    self.firstImageView.layer.masksToBounds = YES;
    self.firstImageView.layer.cornerRadius = 20;
    self.firstImageView.frame = CGRectMake((SIZE_WIDTH - 20) / 2, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.firstImageView.image = [UIImage imageNamed:@"aa0.jpg"];
    [self.imageScrollView addSubview:self.firstImageView];
    
    self.secondImageView.layer.masksToBounds = YES;
    self.secondImageView.layer.cornerRadius = 20;
    self.secondImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 1, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.secondImageView.image = [UIImage imageNamed:@"aa1.jpg"];
    [self.imageScrollView addSubview:self.secondImageView];
    
    self.thirdImageView.layer.masksToBounds = YES;
    self.thirdImageView.layer.cornerRadius = 20;
    self.thirdImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 2, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.thirdImageView.image = [UIImage imageNamed:@"aa2.jpg"];
    [self.imageScrollView addSubview:self.thirdImageView];
    
    self.fourImageView.layer.masksToBounds = YES;
    self.fourImageView.layer.cornerRadius = 20;
    self.fourImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 3, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.fourImageView.image = [UIImage imageNamed:@"aa3.jpg"];
    [self.imageScrollView addSubview:self.fourImageView];
    
    self.fiveImageView.layer.masksToBounds = YES;
    self.fiveImageView.layer.cornerRadius = 20;
    self.fiveImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 4, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.fiveImageView.image = [UIImage imageNamed:@"aa4.jpg"];
    [self.imageScrollView addSubview:self.fiveImageView];
    
    self.sixImageView.layer.masksToBounds = YES;
    self.sixImageView.layer.cornerRadius = 20;
    self.sixImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 5, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.sixImageView.image = [UIImage imageNamed:@"aa5.jpg"];
    [self.imageScrollView addSubview:self.sixImageView];
    
    self.sevenImageView.layer.masksToBounds = YES;
    self.sevenImageView.layer.cornerRadius = 20;
    self.sevenImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2  + SIZE_WIDTH * 6, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    self.sevenImageView.image = [UIImage imageNamed:@"aa6.jpg"];
    [self.imageScrollView addSubview:self.sevenImageView];
    
    [self imageAnimation];
    
    //加一层透明图片用于点击事件
    for (int i = 0; i < 7; i++) {
        self.clearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + SIZE_WIDTH * i, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400)];
        self.clearImageView.backgroundColor = [UIColor clearColor];
        self.clearImageView.userInteractionEnabled = YES;
        [self bringSubviewToFront:self.clearImageView];
        self.clearImageView.tag = i;
        [self.imageScrollView addSubview:self.clearImageView];
        
        self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImage:)];
        [self.clearImageView addGestureRecognizer:self.singleTap];
    }
    
}

//图片的点击事件
- (void)pressImage:(UITapGestureRecognizer *)gestureRecognizer {
    self.numberOfFix = (int)gestureRecognizer.view.tag;
    [self.imageDelegate presentAlert];
}

//下方图片滚动视图滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 999) {
        int page = self.imageScrollView.contentOffset.x / SIZE_WIDTH;
        if (self.alreadySelectPage != page) {
            //临时button赋值
            UIButton *temporaryButton = self.buttonArray[page];
            //新点击按钮变色
            temporaryButton.backgroundColor = [UIColor colorWithRed:(67.0f / 255.0f) green:(64.0f / 255.0f)blue:(79.0f / 255.0f) alpha:1.0f];
            [temporaryButton setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"t%ld.png", (long)temporaryButton.tag]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            //上一次点击按钮复原
            self.alreadySelectButton.backgroundColor = [UIColor colorWithRed:(32.0f / 255.0f) green:(31.0f / 255.0f)blue:(38.0f / 255.0f) alpha:1.0f];
            [self.alreadySelectButton setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"s%ld.png", (long)self.alreadySelectButton.tag]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

            //更新上一次点击的按钮
            self.alreadySelectButton = temporaryButton;
            
            //按钮的位置移植中间
            if (temporaryButton.tag == 0 || temporaryButton.tag == 1) {
                [self.buttonScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            } else if (temporaryButton.tag <= 4) {
                [self.buttonScrollView setContentOffset:CGPointMake((SIZE_WIDTH / 4) * (temporaryButton.tag - 2) + SIZE_WIDTH / 8, 0) animated:YES];
            } else {
                [self.buttonScrollView setContentOffset:CGPointMake(0.75 * SIZE_WIDTH, 0) animated:YES];
            }
            self.alreadySelectPage = page;
        }
    }
    
}

//图片动画
//放大时
- (void)imageAnimation {
    [UIImageView animateWithDuration:4 animations:^{
        self.firstImageView.frame = CGRectMake(20 + SIZE_WIDTH * 0, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.secondImageView.frame = CGRectMake(20 + SIZE_WIDTH * 1, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.thirdImageView.frame = CGRectMake(20 + SIZE_WIDTH * 2, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.fourImageView.frame = CGRectMake(20 + SIZE_WIDTH * 3, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.fiveImageView.frame = CGRectMake(20 + SIZE_WIDTH * 4, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.sixImageView.frame = CGRectMake(20 + SIZE_WIDTH * 5, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
        self.sevenImageView.frame = CGRectMake(20 + SIZE_WIDTH * 6, 10, SIZE_WIDTH - 40, SIZE_HEIGHT - 400);
    } completion:^(BOOL finished) {
        [self secondImageAnimation];
    }];
}

//图片动画
//缩小时
- (void)secondImageAnimation {
    [UIImageView animateWithDuration:4 animations:^{
        self.firstImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 0, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.secondImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 1, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.thirdImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 2, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.fourImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 3, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.fiveImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 4, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.sixImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 5, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
        self.sevenImageView.frame = CGRectMake((SIZE_WIDTH - 20)/ 2 + SIZE_WIDTH * 6, 10 + (SIZE_HEIGHT - 400) / 2, (SIZE_WIDTH - 40) / 1000, (SIZE_HEIGHT - 400) / 1000);
    } completion:^(BOOL finished) {
        [self imageAnimation];
    }];
}
//放大缩小循环

//调相册初始化
- (void)imagePickerInit {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
}

//获取相册的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    self.image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!self.image) {
        self.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    //使用协议传值，让delegate，即controller来执行后面的函数
    [self.photoFixDelegate getPhotoFixNumber:self.numberOfFix image:self.image];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
