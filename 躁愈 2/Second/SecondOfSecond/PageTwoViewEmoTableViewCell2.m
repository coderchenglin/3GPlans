//
//  replyTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/6.
//

#import "PageTwoViewEmoTableViewCell2.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
extern UIColor *darkerColorOfBack;
extern UIColor *colorOfBack;

@implementation PageTwoViewEmoTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"pageTwoViewEmoTableViewCell2"]) {
        self.backgroundColor = [UIColor clearColor]; // UITableViewCell 的背景色
        self.contentView.backgroundColor = colorOfBack;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 15;
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _commentHeadPhotoImageView = [[UIImageView alloc] init];
        _commentHeadPhotoImageView.layer.masksToBounds = YES;
        [_commentHeadPhotoImageView.layer setCornerRadius:SIZE_WIDTH * 0.045];
        [self.contentView addSubview:_commentHeadPhotoImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.5]];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15.5];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_contentLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor whiteColor]; // Fix here
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        _pinglunButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pinglunButton setImage:[UIImage imageNamed:@"pinglun_zhihu.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_pinglunButton];
        
#pragma mark 试stackView
        _verticalStackView = [[UIStackView alloc] init];
        _verticalStackView.axis = UILayoutConstraintAxisVertical;
        _verticalStackView.distribution = UIStackViewDistributionEqualSpacing;
        _verticalStackView.alignment = UIStackViewAlignmentFill;
        _verticalStackView.spacing = 2;
        _verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        _verticalStackView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_verticalStackView];
        
        [_commentHeadPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@20);
            make.width.equalTo(@(SIZE_WIDTH * 0.18));
            make.height.equalTo(@(SIZE_WIDTH * 0.18));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentHeadPhotoImageView.mas_top).offset(5);
            make.left.equalTo(_commentHeadPhotoImageView.mas_right).offset(14);
            make.width.equalTo(@50);
            make.height.equalTo(@(0.06 * SIZE_WIDTH));
        }];
        //
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_top);
            make.left.equalTo(_nameLabel.mas_right).offset(10);
            make.height.equalTo(@(0.05 * SIZE_WIDTH));
            make.width.equalTo(@200);
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.verticalStackView.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        //通过_contentLabel将_nameLabel与_timeLabel撑开从而使其隔开
        
        
        [_pinglunButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_timeLabel.mas_bottom);
            make.height.equalTo(@(SIZE_WIDTH * 0.05));
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(@(SIZE_WIDTH * 0.05));
        }];
        
        
#pragma mark 初始化stackview
        // 创建一个垂直的 UIStackView
        // 设置垂直 StackView 的约束
        [_verticalStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-40);
            make.bottom.equalTo(self->_contentLabel.mas_top).offset(-10);
        }];
        
    }
    return self;
}

@end
