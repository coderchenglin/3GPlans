//
//  PersonTableViewCell.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import "PersonTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation PersonTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"Collection"]) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"我的收藏";
        self.titleLabel.font = [UIFont systemFontOfSize:25];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"Collection"]) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(30);
            make.top.equalTo(self).offset(10);
            make.size.equalTo(@40);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self).offset(10);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
