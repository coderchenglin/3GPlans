//
//  CustomViewCell.m
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import "CustomViewCell.h"
#import "SDAutoLayout.h"
#import "UIImageView+WebCache.h"
@implementation CustomViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView{
    self.moneyL = [[UILabel alloc] init];
    [self.contentView addSubview:self.moneyL];
    self.moneyL.textColor = [UIColor blackColor];
    self.moneyL.backgroundColor = [UIColor grayColor];
    self.moneyL.font = [UIFont systemFontOfSize:16];
    self.moneyL.textAlignment = NSTextAlignmentCenter;
    self.moneyL.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(20);
    self.imgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgV];
    self.imgV.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomSpaceToView(self.moneyL, 0).topEqualToView(self.contentView);
}

-(void)setModel:(TestModel *)model{
    _model = model;
    self.moneyL.text = model.price;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.img]];
}

@end
