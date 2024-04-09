//
//  ShareTableViewCell.m
//  NewStyle
//
//  Created by chenglin on 2024/2/8.
//

#import "ShareTableViewCell.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface ShareTableViewCell ()
@property (nonatomic, strong) UIImageView *headImageView;   //头像
@property (nonatomic, strong) UILabel *nameLabel;   //昵称
@property (nonatomic, strong) UILabel *mainLabel;   //主要文字
@property (nonatomic, strong) UIImageView *mainImageView;   //主要部分照片
@property (nonatomic, strong) UILabel *timeLabel;   //时间文字
@property (nonatomic, strong) UILabel *goodLabel;   //点赞数量
@property (nonatomic, strong) UIButton *goodButton;   //点赞按钮
@end

@implementation ShareTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.goodLabel];
    [self.contentView addSubview:self.goodButton];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addShareMasonry];
    return self;
}
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor grayColor];
        _headImageView.image = [UIImage imageNamed:@"1.jpg"];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.layer.cornerRadius = 0.015 * SIZE_WIDTH;
    }
    return _headImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithRed:(71.0f / 255.0f) green:(87.0f / 255.0f)blue:(129.0f / 255.0f) alpha:1.0f];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:20];
        _nameLabel.text = @"牛逼牛逼";
    }
    return _nameLabel;
}
- (UILabel *)mainLabel {
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.textColor = [UIColor blackColor];
        _mainLabel.textAlignment = NSTextAlignmentLeft;
        _mainLabel.numberOfLines = 0;
        _mainLabel.text = @"级啦势均力敌考试考六级的撒大家撒开了点击阿拉斯加的理科生的沙拉看电视剧里的刷卡记录的撒辣椒卡戴珊里的撒娇了肯德基撒拉卡的数据库里的结论是卡点击卢萨卡大家来刷卡大家来上课级啦势均力敌考试考六级的撒大家撒开了点击阿拉斯加的理科生的沙拉看电视剧里的刷卡记录的撒辣椒卡戴珊里的撒娇了肯德基撒拉卡的数据库里的结论是卡点击卢萨卡大家来刷卡大家来上课级啦势均力敌考试考六级的撒大家撒开了点击阿拉斯加的理科生的沙拉看电视剧里的刷卡记录的撒辣椒卡戴珊里的撒娇了肯德基撒拉卡的数据库里的结论是卡点击卢萨卡大家来刷卡大家来上课级啦势均力敌考试考六级的撒大家撒开了点击阿拉斯加的理科生的沙拉看电视剧里的刷卡记录的撒辣椒卡戴珊里的撒娇了肯德基撒拉卡的数据库里的结论是卡点击卢萨卡大家来刷卡大家来上课";
    }
    return _mainLabel;
}
- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.image = [UIImage imageNamed:@"1.jpg"];
        _mainImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressImage:)];
        [_mainImageView addGestureRecognizer:singleTap];
    }
    return _mainImageView;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithRed:(96.0f / 255.0f) green:(96.0f / 255.0f)blue:(96.0f / 255.0f) alpha:1.0f];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"11月16日 12:55";
    }
    return _timeLabel;
}
- (UILabel *)goodLabel {
    if (!_goodLabel) {
        _goodLabel = [[UILabel alloc] init];
        _goodLabel.textColor = [UIColor blackColor];
        _goodLabel.text = @"25";
    }
    return _goodLabel;
}
- (UIButton *)goodButton {
    if (!_goodButton) {
        _goodButton = [[UIButton alloc] init];
        [_goodButton setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
    }
    return _goodButton;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}
- (void)pressImage:(UITapGestureRecognizer *)gestureRecognizer {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareImage" object:nil userInfo:@{@"shareImage":self.mainImageView.image}];
}
- (void)addShareMasonry {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.width.mas_equalTo(SIZE_WIDTH * 0.12);
        make.height.mas_equalTo(SIZE_WIDTH * 0.12);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(20 + SIZE_WIDTH * 0.12 + 10);
        make.width.mas_equalTo(SIZE_WIDTH * 0.5);
        make.height.mas_equalTo(SIZE_WIDTH * 0.12);
    }];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self.contentView).offset(-SIZE_WIDTH * 0.1 - 5);
        make.left.equalTo(self.contentView).offset(20 + SIZE_WIDTH * 0.12 + 10);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(180);
    }];
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self.contentView).offset(SIZE_WIDTH * 0.12 + 10);
        make.left.equalTo(self.contentView).offset(20 + SIZE_WIDTH * 0.12 + 10);
        make.right.equalTo(self.contentView).offset(-25);
        make.bottom.equalTo(self.contentView).offset(-SIZE_WIDTH * 0.1 - 15 - 180);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(20 + SIZE_WIDTH * 0.12 + 10);
        make.width.mas_equalTo(SIZE_WIDTH * 0.5);
        make.height.mas_equalTo(SIZE_WIDTH * 0.1);
    }];
    [self.goodButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self.contentView).offset(-17);
        make.right.equalTo(self.contentView).offset(-30);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    [self.goodLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(self.contentView).offset(-65);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
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
