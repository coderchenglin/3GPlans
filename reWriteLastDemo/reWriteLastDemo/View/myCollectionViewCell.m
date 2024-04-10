//
//  myCollectionViewCell.m
//  reWriteLastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import "myCollectionViewCell.h"

@implementation myCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    //主图
    self.imageView = [[UIImageView alloc] init];
    //标题
    self.label = [[UILabel alloc] init];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    self.label.font = font;
    self.label.numberOfLines = 2;
    //头像
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 12.5;
    self.avatarImageView.layer.masksToBounds = YES;
    //作者
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:14.0];
    self.authorLabel.textColor = UIColor.lightGrayColor;
    //点赞
    self.likeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.likeButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dianzan1.png"]] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dianzan2.png"]] forState:UIControlStateSelected];
    [self.likeButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.likeButton.selected = NO;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.likeButton];
    
    return self;
}

- (void)layoutSubviews {
    
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width) / 2;
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageHeight = (imageSize.height / imageSize.width) * width;
    
    [self.imageView setFrame:CGRectMake(0, 0, width, imageHeight)];
    [self.label setFrame:CGRectMake(0, imageHeight, width, 50)];
    [self.avatarImageView setFrame:CGRectMake(0, imageHeight + 50, 25, 25)];
    [self.authorLabel setFrame:CGRectMake(30, imageHeight + 50, width - 60, 25)];
    [self.likeButton setFrame:CGRectMake(width - 30, imageHeight + 50, 25, 25)];
    
}

- (void)buttonTap:(UIButton *)button {
    
    if (!button.selected) {
        button.selected = YES;
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformIdentity; //恢复原始大小
            }];
        }];
    } else {
        button.selected = NO;
    }
}




@end
