//
//  mineTableViewCell.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineTableViewCell.h"

@implementation mineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.imageview = [[UIImageView alloc] init];
    
    self.label =[[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:20];
    
    [self.contentView addSubview:self. imageview];
    [self.contentView addSubview:self. label];
    
    
    return self;
}

- (void) layoutSubviews {
    self.imageview.frame = CGRectMake(350, 20, 30, 30);
    self.label.frame = CGRectMake(25, 20, 100, 30);
}


@end
