//
//  XLCardCell.m
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import "XLCardCell.h"
#import "XLCardModel.h"
#import "Masonry.h"
#import <SDWebImage/SDWebImage.h>


@interface XLCardCell ()

//@property (nonatomic, strong) NSMutableArray<NSString *> *optionArray;

//@property (nonatomic, strong) NSArray<UIButton *> *optionButtons;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation XLCardCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.optionArray = [NSMutableArray arrayWithCapacity:4];
//
//        for (NSInteger i = 0; i < 2; i++) {
//            [self.optionArray addObject:@"F"];
//        }
//        NSLog(@"self.optionArray = %@",self.optionArray);
        [self buildUI];
    }
    return self;
}

- (void)updateButtonSelectionAtCellIndex:(NSInteger)cellIndex optionIndex:(NSInteger)optionIndex withOption:(NSString *)option {
    // 更新选项数组
//    if ([optionArray[cellIndex] isEqual:option]) {
//        optionArray[cellIndex] = @"";
//    } else {
//        optionArray[cellIndex] = option;
//    }
    optionArray[cellIndex] = option;
    NSLog(@"cellIndex = %ld, optionIndex = %ld, option = %@", (long)cellIndex, (long)optionIndex, option);
    NSLog(@"self.optionArray[%ld] = %@", cellIndex, optionArray[cellIndex]);
    
    // 更新按钮的背景颜色
//    UIButton *button = self.optionButtons[cellIndex];
//    if ([option isEqualToString:@""]) {
//        //选项为空时，恢复原样
//        button.backgroundColor = [UIColor whiteColor];
//    } else {
//        button.backgroundColor = [UIColor lightGrayColor];
//    }
    
    //判断是否所有题目都有选择
    BOOL allQuestionAnswered = ![optionArray containsObject:@""];
    NSLog(@"self.optionArray = %@", optionArray);
    NSLog(@"allQuestionAnswered = %d", allQuestionAnswered);
    if (allQuestionAnswered) {
        //所有题目都有选择，通知代理显示提示按钮
        [self.delegate cardCellDidSelectAllOptions:self isAll:allQuestionAnswered];
    }
}

//按钮点击事件处理
// 按钮点击事件处理
- (IBAction)optionButtonTapped:(UIButton *)sender {
    // 找到按钮在数组中的索引
    self.selectedIndex = sender.tag;
//    NSInteger index = [self.optionButtons indexOfObject:sender];
    NSIndexPath *indexPath;
    if ([self.delegate respondsToSelector:@selector(buttonTappedInCell:)]) {
        indexPath = [self.delegate buttonTappedInCell:self];
    }
    
    //按钮变色
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        sender.backgroundColor = [UIColor grayColor];
//        //设置按钮选中时的背景颜色
//        sender.backgroundColor = [UIColor grayColor];
//    } else {
//        //设置按钮非选中时的背景颜色
//        sender.backgroundColor = [UIColor whiteColor];
//    }
    
    for (UIButton *button in self.contentView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            button.backgroundColor = (button.tag == self.selectedIndex) ? [UIColor grayColor] : [UIColor whiteColor];
        }
    }
    
//    第几个cell的按钮（下标）
    NSInteger cellIndex = indexPath.item;
//    NSLog(@"index = %ld",(long)indexPath.item);
//    当前cell的第几个按钮（下标）
    NSInteger optionIndex = sender.tag;
    // 获取选项字符
    NSString *option = [self optionForButtonTag:sender.tag];
//    NSLog(@"option = %@",option);

// 通知代理 用户点击了选项按钮,存储,变色
    [self updateButtonSelectionAtCellIndex:cellIndex optionIndex:optionIndex withOption:option];
//    [self.delegate cardCell:self didSelectOption:option atIndex:cellIndex];
    
}

- (NSString *)optionForButtonTag:(NSInteger)tag {
    switch (tag) {
        case 0:
            return @"A";
        case 1:
            return @"B";
        case 2:
            return @"C";
        case 3:
            return @"D";
        default:
            return nil;
    }
}

- (void)buildUI {
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.749 blue:1.0 alpha:1.0];
//    self.backgroundColor = [UIColor clearColor];
    
    self.testImageView = [[UIImageView alloc] init];
    self.testButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.testImageView.backgroundColor = [UIColor redColor];
    self.testButton1.backgroundColor = [UIColor whiteColor];
    self.testButton2.backgroundColor = [UIColor whiteColor];
    self.testButton3.backgroundColor = [UIColor whiteColor];
    self.testButton4.backgroundColor = [UIColor whiteColor];

    self.testButton1.titleLabel.font = [UIFont systemFontOfSize:24];
    self.testButton2.titleLabel.font = [UIFont systemFontOfSize:24];
    self.testButton3.titleLabel.font = [UIFont systemFontOfSize:24];
    self.testButton4.titleLabel.font = [UIFont systemFontOfSize:24];
    
    self.testButton1.tag = 0;
    self.testButton2.tag = 1;
    self.testButton3.tag = 2;
    self.testButton4.tag = 3;
    
    [self.testButton1 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton2 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton3 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton4 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    //设置背景，圆角等
    self.testButton1.layer.cornerRadius = 10.0;
    self.testButton2.layer.cornerRadius = 10.0;
    self.testButton3.layer.cornerRadius = 10.0;
    self.testButton4.layer.cornerRadius = 10.0;
    
    self.testButton1.layer.masksToBounds = YES;
    self.testButton2.layer.masksToBounds = YES;
    self.testButton3.layer.masksToBounds = YES;
    self.testButton4.layer.masksToBounds = YES;
    
    self.testImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.testImageView];
    [self.contentView addSubview:self.testButton1];
    [self.contentView addSubview:self.testButton2];
    [self.contentView addSubview:self.testButton3];
    [self.contentView addSubview:self.testButton4];
    
}




- (void)layoutSubviews {
    
    [self.testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.width.equalTo(self.mas_width);
        make.width.equalTo(self);
//        make.height.equalTo(self.mas_height).multipliedBy(1.0/3.0);
        make.left.equalTo(self.mas_left);
    }];

    [self.testButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testImageView.mas_bottom).offset(10);
        make.height.equalTo(self.testImageView.mas_width).multipliedBy(1.0/6.0);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];

    [self.testButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testButton1.mas_bottom).offset(10);
        make.height.equalTo(self.testImageView.mas_width).multipliedBy(1.0/6.0);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];

    [self.testButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testButton2.mas_bottom).offset(10);
        make.height.equalTo(self.testImageView.mas_width).multipliedBy(1.0/6.0);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];

    [self.testButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testButton3.mas_bottom).offset(10);
        make.height.equalTo(self.testImageView.mas_width).multipliedBy(1.0/6.0);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];
}

- (void)setModel:(XLCardModel *)model {
    
//    self.testImageView.image = [UIImage imageNamed:model.imageName];
//    self.testImageView.image = [UIImage imageNamed:@"色盲.jpeg"];
//    NSURL *url = [NSURL URLWithString:@"https://img.nanrentu.cc/listImg/c2023/06/16/0biahefocfo.jpg"];
    

//    NSURL *url = [NSURL URLWithString:@"file:///Users/chenglin/Library/Containers/com.tencent.xinWeChat/Data/Library/Application%20Support/com.tencent.xinWeChat/2.0b4.0.9/94048adb9cce724b88ec628344d0bb11/Message/MessageTemp/d29f410141ef58adb2c8f8047eb0451a/Image/11001711538196_.pic.jpg"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageName]];
//    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/./Asset/Upload/Color/Red/171161834259627142.jpeg"];
//    NSLog(@"model.imageName = %@", url);
    
    
    [self.testImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"图片加载失败:%@",error);
        } else {
            NSLog(@"图片加载成功");
        }
    }];
    
    [self.testButton1 setTitle:model.OptionA forState:UIControlStateNormal];
    [self.testButton2 setTitle:model.OptionB forState:UIControlStateNormal];
    [self.testButton3 setTitle:model.OptionC forState:UIControlStateNormal];
    [self.testButton4 setTitle:model.OptionD forState:UIControlStateNormal];
    
    
//    self.testButton1.titleLabel = model.OptionA;
//    self.testButton2.titleLabel = model.OptionB;
//    self.testButton3.titleLabel = model.OptionC;
//    self.testButton4.titleLabel = model.OptionD;
    
//    self.imageView.image = [UIImage imageNamed:model.imageName];
//    self.textLabel.text = model.title;
}

@end
