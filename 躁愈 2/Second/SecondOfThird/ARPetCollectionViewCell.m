//
//  ARPetCollectionViewCell.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import "ARPetCollectionViewCell.h"
#import "Masonry.h"
@implementation ARPetCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView，titleLabel，subtitleLabel和detailLabel
        self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.lockImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // 设置实际的frame和样式
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        self.lockImageView.image = [UIImage imageNamed:@"padlock.png"];
    
        // 添加视图到contentView
        [self.contentView addSubview:self.bigImageView];
//        [self.contentView addSubview:self.smallImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lockImageView];

        // 设置视图的约束或frame（这里可以使用Auto Layout或者手动设置frame）
    }
    return self;
}

// 在这里根据需要重写layoutSubviews方法来调整子视图的布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(0, 0, 170, 170);
    self.bigImageView.layer.cornerRadius = 10;
    self.bigImageView.layer.masksToBounds = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bigImageView).offset(0);
            make.right.equalTo(self.bigImageView);
            make.top.equalTo(self.bigImageView.mas_bottom).offset(5);
            make.height.equalTo(@15);
    }];
    
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.bigImageView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
    }];

}
@end
