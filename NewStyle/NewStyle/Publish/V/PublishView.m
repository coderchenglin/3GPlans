//
//  PublishView.m
//  NewStyle
//
//  Created by chenglin on 2024/2/12.
//

#import "PublishView.h"
#import "Masonry.h"
//系统相机
#import <AVFoundation/AVFoundation.h>
//系统相册
#import <AssetsLibrary/AssetsLibrary.h>
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PublishView () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *greenButton; //发布
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *mainTextView; //文字文本框
@property (nonatomic, strong) UILabel *addLabel;  //添加图片文字
@property (nonatomic, strong) UIButton *addButton; //添加图片按钮
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIButton *chaButton;

@end

@implementation PublishView

- (void)viewInit {
    [self titleInit];
    [self textViewInit];
    [self addLabelAndButtonInit];
    [self mainImageViewInit];
    [self imagePickerControllerInit];
}

- (void)imagePickerControllerInit {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
}

//标题栏初始化
- (void)titleInit {
    self.backgroundColor = [UIColor colorWithRed:(15.0f / 255.0f) green:(14.0f / 255.0f)blue:(18.0f / 255.0f) alpha:1.0f];
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.backButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"fanhui.png"]] forState:UIControlStateNormal];
    self.backButton.tag = 0;
    [self addSubview:self.backButton];
    //状态栏高度
    NSSet *set = [UIApplication sharedApplication].connectedScenes;
    UIWindowScene *windowScene = [set anyObject];
    UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
    [self.backButton mas_makeConstraints:^(MASConstraintMaker* make) {
        if (statusBarManager.statusBarFrame.size.height < 30) {
            make.top.equalTo(self).offset(43 - 20);
        } else {
            make.top.equalTo(self).offset(43);
        }
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.top.equalTo(self).offset(43);
        make.left.equalTo(self).offset(20);
    }];
    [self.backButton addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"发布动态";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        if (statusBarManager.statusBarFrame.size.height < 30) {
            make.top.equalTo(self).offset(45 - 20);
        } else {
            make.top.equalTo(self).offset(45);
        }
        make.height.equalTo(@30);
        make.width.equalTo(@(0.6 * SIZE_WIDTH));
        make.left.equalTo(self).offset(SIZE_WIDTH / 2 - 0.3 * SIZE_WIDTH);
    }];
    
    self.greenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.greenButton.backgroundColor = [UIColor colorWithRed:(26.0f / 255.0f) green:(183.0f / 255.0f)blue:(77.0f / 255.0f) alpha:1.0f];
    self.greenButton.layer.masksToBounds = YES;
    self.greenButton.layer.cornerRadius = 5;
    self.greenButton.tag = 1;
    [self.greenButton addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenButton setTitle:@"发表" forState:UIControlStateNormal];
    self.greenButton.tintColor = [UIColor whiteColor];
    [self addSubview:self.greenButton];
    [self.greenButton mas_makeConstraints:^(MASConstraintMaker* make) {
        if (statusBarManager.statusBarFrame.size.height < 30) {
            make.top.equalTo(self).offset(45 - 20);
        } else {
            make.top.equalTo(self).offset(45);
        }
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        make.left.equalTo(self).offset(SIZE_WIDTH - 70);
    }];
}

- (void)buttonReturn:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"publishButton" object:nil userInfo:@{@"button":button}];
}

- (void)textViewInit {
    self.mainTextView = [[UITextView alloc] init];
    self.mainTextView.frame = CGRectMake(5, 130, SIZE_WIDTH - 10, 150);
    self.mainTextView.backgroundColor = [UIColor whiteColor];
    self.mainTextView.textColor = [UIColor grayColor];
    self.mainTextView.layer.masksToBounds = YES;
    self.mainImageView.layer.cornerRadius = 5;
    self.mainTextView.font = [UIFont systemFontOfSize:20];
    self.mainTextView.text = @"这一刻的想法。。。。";
    self.mainTextView.delegate = self;
    self.mainTextView.tintColor = [UIColor blackColor];
    [self addSubview:self.mainTextView];
    
}

//动态实现placeholder方法
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"这一刻的想法。。。。";
        textView.textColor = [UIColor grayColor];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"这一刻的想法。。。。"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)addLabelAndButtonInit {
    self.addLabel = [[UILabel alloc] init];
    self.addLabel.text = @"点击添加图片";
    self.addLabel.font = [UIFont systemFontOfSize:21];
    self.addLabel.textColor = [UIColor whiteColor];
    self.addLabel.textAlignment = NSTextAlignmentLeft;
    self.addLabel.frame = CGRectMake(5, 290, 150, 50);
    [self addSubview:self.addLabel];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addButton setImage:[[UIImage imageNamed:@"jiahao.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.addButton.tag = 2;
    [self.addButton addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.frame = CGRectMake(140, 300, 30, 30);
    [self addSubview:self.addButton];
}

//图片初始化
- (void)mainImageViewInit {
    self.mainImageView = [[UIImageView alloc] init];
    self.mainImageView.frame = CGRectMake(5, 330, SIZE_WIDTH / 3 - 10, SIZE_WIDTH / 3 - 10);
    self.mainImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mainImageView];
    
    self.chaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.chaButton.frame = CGRectMake(5 + SIZE_WIDTH / 3 - 10 - 25, 330, 25, 25);
    [self.chaButton setImage:[[UIImage imageNamed:@"chacha2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.chaButton addTarget:self action:@selector(pressChaButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.chaButton];
    self.chaButton.hidden = YES;
}

- (void)pressChaButton {
    self.mainImageView.image = nil;
    self.chaButton.hidden = YES;
    self.addLabel.hidden = NO;
    self.addButton.hidden = NO;
}

//获取相册得到的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    self.image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!self.image) {
        self.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    [self testPhoto];
}

- (void)testPhoto {
    if (self.image) {
        self.mainImageView.image = self.image;
        self.addLabel.hidden = YES;
        self.addButton.hidden = YES;
        self.chaButton.hidden = YES;
    }
}

@end
