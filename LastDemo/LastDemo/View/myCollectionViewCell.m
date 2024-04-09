//
//  myCollectionViewCell.m
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//
//

#import "myCollectionViewCell.h"
#import "Masonry.h"
#import <QuartzCore/QuartzCore.h>

@implementation myCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    //主图
    self.imageview = [[UIImageView alloc] init];
    //标题
    self.label = [[UILabel alloc] init];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    self.label.font = font;
    self.label.numberOfLines = 2;
    //头像部分
    self.avatarimageview = [[UIImageView alloc] init];
    self.avatarimageview.layer.cornerRadius = 12.5;
    self.avatarimageview.layer.masksToBounds = YES;
    //作者
    self.authorlable = [[UILabel alloc] init];
    self.authorlable.font = [UIFont systemFontOfSize:14.0];
    self.authorlable.numberOfLines = 1;
    self.authorlable.textColor = UIColor.lightGrayColor;
    //点赞
    self.likebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likebutton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dianzan1.png"]] forState:UIControlStateNormal];
    [self.likebutton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dianzan2.png"]] forState:UIControlStateSelected];
    [self.likebutton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.likebutton.selected = NO;
    
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.avatarimageview];
    [self.contentView addSubview:self.authorlable];
    [self.contentView addSubview:self.likebutton];
    
    
    return self;
}
- (void) layoutSubviews {
    
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
    

    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(3);
        make.top.equalTo(self).offset(5);
        make.width.mas_offset(191);
        make.bottom.mas_equalTo (-75);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(3);
        make.bottom.equalTo(self).offset(-33);
        make.width.mas_offset(191);
        make.height.mas_equalTo (38);
    }];
    
    [self.avatarimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(3);
        make.width.mas_offset(25);
        make.height.mas_offset(25);
        make.bottom.mas_equalTo (-5);
    }];
    
    [self.authorlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.width.mas_offset(90);
        make.bottom.mas_equalTo (-5);
    }];
    
    [self.likebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(150);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.bottom.mas_equalTo (-5);
    }];
}

- (void) buttonTap: (UIButton*) button {
    if (!button.selected) {
            button.selected = YES; // 设置按钮为选中状态
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformMakeScale(1.5, 1.5); // 按钮放大
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    button.transform = CGAffineTransformIdentity; // 恢复原始大小
                }];
            }];
    } else {
        button.selected = NO;
    }
}

- (void) prepareForReuse {
    [super prepareForReuse];
    self.imageview.image = nil;
    self.label.text = @"";
    self.avatarimageview.image = nil;
    self.authorlable.text = @"";
}
@end
