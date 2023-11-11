//
//  SetTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"set"]) {
        
        _bImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_bImageView];
        
        _aImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_aImageView];
        
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_mainLabel];
    }
    return self;
}

- (void)layoutSubviews {
    _aImageView.frame = CGRectMake(15, 15, 30, 30);
    _bImageView.frame = CGRectMake(360, 17.5, 25, 25);
    _mainLabel.frame = CGRectMake(60, 10, 300, 40);
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
