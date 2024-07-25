//
//  MessageTableViewCell.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/3.
//

#import "MessageTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([self.reuseIdentifier isEqualToString:@"Message"]) {
        //头像视图
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.layer.cornerRadius = 18;
        self.headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.headImageView];
        //用户姓名Label
        self.nameLabel = [[UILabel alloc] init];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        //评论内容Label
        self.showLabel = [[TopLeftLabel alloc] init];
        self.showLabel.textAlignment = NSTextAlignmentLeft;
        self.showLabel.font = [UIFont systemFontOfSize:18];
        self.showLabel.numberOfLines = 0;
        self.showLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.showLabel];
        //回复内容Label
        self.replyLabel = [[TopLeftLabel alloc] init];
        self.replyLabel.textAlignment = NSTextAlignmentLeft;
        self.replyLabel.font = [UIFont systemFontOfSize:15];
        self.replyLabel.textColor = [UIColor systemGrayColor];
        [self.contentView addSubview:self.replyLabel];
        //横线Label
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = [UIColor systemGray6Color];
        self.lineLabel.text = @"";
        [self.contentView addSubview:self.lineLabel];
        //时间Label
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.textColor = [UIColor systemGray3Color];
        [self.contentView addSubview:self.timeLabel];
        //展开按钮
        self.openButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.openButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.openButton setTitleColor:[UIColor systemGray3Color] forState:UIControlStateNormal];
        [self.contentView addSubview:self.openButton];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"Message"]) {
        //头像视图
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 40);
            make.top.equalTo(self).offset(myHeight / 66);
            make.width.and.height.equalTo(@38);
        }];
        //用户名Label
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self).offset(myHeight / 111);
            make.width.equalTo(@(myWidth / 1.5));
            make.height.equalTo(@40);
        }];
        //评论内容Label
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self).offset(myHeight / 20);
            make.width.equalTo(@(myWidth / 1.3));
        }];
        //回复内容Label
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self.showLabel.mas_bottom).offset(6); //回复的顶部和评论的底部对齐，再向下偏移6
            make.width.equalTo(@(myWidth / 1.3));
        }];
        //横线Label
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0); //贴在cell底部
            make.left.equalTo(self).offset(0); //贴在cell左端
            make.width.equalTo(@(myWidth)); //宽度为整个屏宽
            make.height.equalTo(@1); //高度为1
        }];
        //时间Label
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(myHeight / 12);
            make.top.equalTo(self.replyLabel.mas_bottom).offset(3); //放在回复Label的下面3个单位的位置
        }];
        //展开按钮
        [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(10); //放在时间Label右边10个单位的位置
            make.top.equalTo(self.replyLabel.mas_bottom).offset(-3); //放在回复Label的下面3个单位的位置
            make.width.equalTo(@70);  //宽度为70
            make.height.equalTo(@30); //高度为30
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
