//
//  FirstCollectionViewCell.m
//  CollectionView
//
//  Created by 夏楠 on 2024/2/22.
//

#import "FirstCollectionViewCell.h"
#import "Masonry.h"
@implementation FirstCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView，titleLabel，subtitleLabel和detailLabel
        self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.smallImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        self.subtitleLabel.font = [UIFont systemFontOfSize:9.5];
        self.subtitleLabel.textColor = [UIColor grayColor];
        
        // 添加视图到contentView
        [self.contentView addSubview:self.bigImageView];
        [self.contentView addSubview:self.smallImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        
        // 设置视图的约束或frame（这里可以使用Auto Layout或者手动设置frame）
    }
    return self;
}

// 在这里根据需要重写layoutSubviews方法来调整子视图的布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(0, 10, 240, 170);
    self.bigImageView.layer.cornerRadius = 10;
    self.bigImageView.layer.masksToBounds = YES;
    
    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bigImageView);
            make.width.equalTo(@40);
            make.top.equalTo(self.bigImageView.mas_bottom).offset(5);
            make.height.equalTo(@40);
    }];
    self.smallImageView.layer.cornerRadius = 20;
    self.smallImageView.layer.masksToBounds = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smallImageView.mas_right).offset(5);
            make.width.equalTo(@180);
            make.top.equalTo(self.smallImageView.mas_top);
            make.height.equalTo(@15);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smallImageView.mas_right).offset(5);
            make.width.equalTo(@180);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
            make.height.equalTo(@15);
    }];
}
@end
