//
//  FollowTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//

#import "FollowTableViewCell.h"

@implementation FollowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    _goodColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    if ([self.reuseIdentifier isEqualToString:@"follow"]) {
        _headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_followButton];
    } else if ([self.reuseIdentifier isEqualToString:@"letter"]) {
        _headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        
        _desLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_desLabel];
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.textColor = _goodColor;
    }
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"follow"]) {
        _headImageView.frame = CGRectMake(20, 10, 50, 50);
        _nameLabel.frame = CGRectMake(90, 20, 200, 30);
        _followButton.frame = CGRectMake(300, 20, 70, 30);
    } else if ([self.reuseIdentifier isEqualToString:@"letter"]) {
        _headImageView.frame = CGRectMake(20, 10, 50, 50);
        _nameLabel.frame = CGRectMake(90, 5, 200, 30);
        _timeLabel.frame = CGRectMake(320, 5, 100, 20);
        _desLabel.frame = CGRectMake(90, 30, 300, 30);
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
