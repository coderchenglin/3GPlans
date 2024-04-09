//
//  myTableViewCell.m
//  new
//
//  Created by mac on 2024/2/28.
//

#import "myTableViewCell.h"

@implementation myTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.imageview = [[UIImageView alloc] init];
    self.label = [[UILabel alloc] init];
    self.label2 = [[UILabel alloc] init];
    self.button = [UIButton buttonWithType: UIButtonTypeCustom];
    self.button.layer.cornerRadius = 10.0;
    self.button.layer.masksToBounds = YES;

    // 添加边框
    self.button.layer.borderWidth = 1.0;
    self.button.layer.borderColor = [UIColor redColor].CGColor;

    
    self.imageview.layer.cornerRadius = 35;
    self.imageview.layer.masksToBounds = YES;
    
    self.label.font = [UIFont systemFontOfSize: 20];
    self.label2.font = [UIFont systemFontOfSize: 15];
    self.label2.textColor = UIColor.lightGrayColor;
    
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.label2];
    
    
    return self;
}

- (void) layoutSubviews {
    self.imageview.frame = CGRectMake(15, 10, 70, 70);
    self.label.frame = CGRectMake(95, 23, 100, 25);
    self.label2.frame = CGRectMake(95, 55, 290, 20);
    self.button.frame = CGRectMake(300, 25, 60, 20);
}
@end
