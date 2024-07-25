//
//  FreeStyleTableViewCell.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import "FreeStyleTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation FreeStyleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        //图片
        self.showImageView = [[UIImageView alloc] init];
        self.showImageView.layer.cornerRadius = 8;
        self.showImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.showImageView];
        //主标题
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 0;
        [self.mainLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        self.mainLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.mainLabel];
        //副标题
        self.subLabel = [[UILabel alloc] init];
        self.subLabel.numberOfLines = 0;
        self.subLabel.textColor = [UIColor systemGrayColor];
        [self.contentView addSubview:self.subLabel];
    }
    return self;
}

//在设置Autolayout之前，要将view添加到self.view上面
- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        //图片
        [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.width.and.height.equalTo(@70);
        }];
        //主标题
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@(myWidth - 100));
            make.height.equalTo(@(50));
        }];
        //副标题
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(65);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@(myWidth - 100));
            make.height.equalTo(@(20));
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
