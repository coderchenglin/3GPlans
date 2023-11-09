//
//  ActionTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/9.
//

#import "ActionTableViewCell.h"

@implementation ActionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"action"]) {
        _actionImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_actionImageView];
        _actionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_actionLabel];
        _actionLabel.textAlignment = NSTextAlignmentLeft;
        _actionLabel.numberOfLines = 0;
    }
    return self;
}

- (void)layoutSubviews {
    _actionImageView.frame = CGRectMake(0, 0, width, 200);
    _actionLabel.frame = CGRectMake(0, 200, width, 25);
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
