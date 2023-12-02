//
//  MessageTableViewCell.m
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import "MessageTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([self.reuseIdentifier isEqualToString:@"Message"]) {
        //头像
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.layer.cornerRadius = 18;
        self.headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.headImageView];
        
        //名字
        self.nameLabel = [[UILabel alloc] init];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        
        //内容
        self.showLabel = [[TopLeftLabel alloc] init];
        self.showLabel.textAlignment = NSTextAlignmentLeft;
        self.showLabel.font = [UIFont systemFontOfSize:18];
        self.showLabel.numberOfLines = 0;
        self.showLabel.numberOfLines = 0;
        self.showLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.showLabel];
        
        //回复
        self.replyLabel = [[TopLeftLabel alloc] init];
        self.replyLabel.textAlignment = NSTextAlignmentLeft;
        self.replyLabel.font = [UIFont systemFontOfSize:15];
        self.replyLabel.textColor = [UIColor systemGrayColor];
        [self.contentView addSubview:self.replyLabel];
        
        //
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = [UIColor systemGray6Color];
        self.lineLabel.text = @"";
        [self.contentView addSubview:self.lineLabel];
        
        //时间
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.textColor = [UIColor systemGray3Color];
        [self.contentView addSubview:self.timeLabel];
        
        
        self.openButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.openButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.openButton setTitleColor:[UIColor systemGray3Color] forState:UIControlStateNormal];
        [self.contentView addSubview:self.openButton];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"Message"]) {
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 40);
            make.top.equalTo(self).offset(myHeight / 66);
            make.width.and.height.equalTo(@38);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self).offset(myHeight / 111);
            make.width.equalTo(@(myWidth / 1.5));
            make.height.equalTo(@40);
        }];
        
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self).offset(myHeight / 20);
            make.width.equalTo(@(myWidth / 1.3));
        }];
        
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self.showLabel.mas_bottom).offset(6);
            make.width.equalTo(@(myWidth / 1.3));
        }];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.width.equalTo(@(myWidth));
            make.height.equalTo(@1);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self.replyLabel.mas_bottom).offset(3);
        }];
        
        [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(10);
            make.top.equalTo(self.replyLabel.mas_bottom).offset(-3);
            make.width.equalTo(@70);
            make.height.equalTo(@30);
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
