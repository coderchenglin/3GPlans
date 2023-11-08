//
//  SelectTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import "SelectTableViewCell.h"

@implementation SelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(0, 0, 300, 30);
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
