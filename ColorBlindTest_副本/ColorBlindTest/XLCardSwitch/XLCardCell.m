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

        [self buildUI];
    }
    return self;
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
    
//    self.testButton1.tag = 0;
//    self.testButton2.tag = 1;
//    self.testButton3.tag = 2;
//    self.testButton4.tag = 3;
    
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


// 按钮点击事件处理
- (void)optionButtonTapped:(UIButton *)optionButton {
    
    NSIndexPath *indexPath;  //第几个cell
    if ([self.delegate respondsToSelector:@selector(buttonTappedInCell:)]) {
        indexPath = [self.delegate buttonTappedInCell:self];
    }
//    NSLog(@"indexPath.item = %ld", (long)indexPath.item);
    // 找到按钮在数组中的索引
    self.selectedIndex = optionButton.tag - (indexPath.item * 4);
    NSLog(@"self.selectedIndex = %ld", self.selectedIndex);
    
//    for (UIButton *button in self.contentView.subviews) {
//        if ([button isKindOfClass:[UIButton class]]) {
//            button.backgroundColor = (button.tag == self.selectedIndex) ? [UIColor grayColor] : [UIColor whiteColor];
//        }
//    }
    XLCardCell *cell = [self collectionViewCellForButton:optionButton];
    if (self.selectedIndex == 1) {
        cell.testButton1.backgroundColor = [UIColor grayColor];
    } if (self.selectedIndex == 2) {
        cell.testButton2.backgroundColor = [UIColor grayColor];
    } if (self.selectedIndex == 3) {
        cell.testButton3.backgroundColor = [UIColor grayColor];
    } if (self.selectedIndex == 4) {
        cell.testButton4.backgroundColor = [UIColor grayColor];
    }
    
    
    NSInteger cellIndex = indexPath.item; //第几个cell的按钮（下标）
    NSInteger optionIndex = optionButton.tag - (indexPath.item * 4);  //当前cell的第几个按钮（下标）
    // 获取选项字符
    NSString *option = [self optionForButtonIndex:optionIndex];
//    NSLog(@"option = %@",option);

// 通知代理 用户点击了选项按钮,存储,变色
    [self updateButtonSelectionAtCellIndex:cellIndex optionIndex:optionIndex withOption:option];
}

- (XLCardCell *)collectionViewCellForButton:(UIButton *)button {
    // 初始化一个视图变量，从当前按钮的父视图开始
    UIView *superview = button.superview;
    
    // 循环查找父视图，直到找到 UICollectionViewCell 或者父视图为 nil
    while (superview && ![superview isKindOfClass:[XLCardCell class]]) {
        superview = superview.superview;
    }
    
    // 如果找到了 UICollectionViewCell，则返回该单元格，否则返回 nil
    if ([superview isKindOfClass:[XLCardCell class]]) {
        return (XLCardCell *)superview;
    } else {
        return nil;
    }
}


- (void)updateButtonSelectionAtCellIndex:(NSInteger)cellIndex optionIndex:(NSInteger)optionIndex withOption:(NSString *)option {

    optionArray[cellIndex] = option; //存放8个cell选了什么的数组
    
    //判断是否所有题目都有选择
    BOOL allQuestionAnswered = ![optionArray containsObject:@""];

    if (allQuestionAnswered) {
        //所有题目都有选择，通知代理显示提示按钮
        [self.delegate cardCellDidSelectAllOptions:self isAll:allQuestionAnswered];
    }
}

- (NSString *)optionForButtonIndex:(NSInteger)optionIndex {
    switch (optionIndex) {
        case 1:
            return @"A";
        case 2:
            return @"B";
        case 3:
            return @"C";
        case 4:
            return @"D";
        default:
            return nil;
    }
}

- (void)layoutSubviews {
    
    [self.testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.width.equalTo(self.mas_width);
        make.width.equalTo(self);
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageName]];
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
}

@end
