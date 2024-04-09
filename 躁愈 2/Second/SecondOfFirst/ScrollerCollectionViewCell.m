//
//  ScrolllerCollectionViewCell.m
//  collectionView无限轮播图
//
//  Created by 夏楠 on 2024/3/5.
//

#import "ScrollerCollectionViewCell.h"
#import "Masonry.h"

@implementation ScrollerCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView，titleLabel，subtitleLabel和detailLabel
        self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = [UIColor whiteColor];
 
        // 添加视图到contentView
        [self.contentView addSubview:self.bigImageView];
//        [self.contentView addSubview:self.smallImageView];
        [self.contentView addSubview:self.titleLabel];
        
        // 设置视图的约束或frame（这里可以使用Auto Layout或者手动设置frame）
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(25, 0,[UIScreen mainScreen].bounds.size.width - 50 , 225);
    self.bigImageView.layer.cornerRadius = 10;
    self.bigImageView.layer.masksToBounds = YES;

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bigImageView).offset(20);
            make.right.equalTo(self.bigImageView);
            make.top.equalTo(self.bigImageView.mas_bottom).offset(-60);
            make.height.equalTo(@40);
    }];

}
@end
