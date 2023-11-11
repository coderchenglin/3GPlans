//
//  MyImformationTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//

#import "MyInformationTableViewCell.h"

@implementation MyInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_label];
    
    if([self.reuseIdentifier isEqualToString:@"information"]) {
        _goodImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_goodImageView];
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:_numberLabel];
    }
    
    
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"information"]) {
        _label.frame = CGRectMake(10, 10, 200, 30);
        _goodImageView.frame = CGRectMake(340, 10, 30, 30);
        _numberLabel.frame = CGRectMake(380, 10, 30, 30);
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
