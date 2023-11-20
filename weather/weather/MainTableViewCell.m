//
//  MainTableViewCell.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([self.reuseIdentifier isEqualToString:@"main"]) {
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [[UIFont alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        self.cityLabel = [[UILabel alloc] init];
        self.cityLabel.font = [UIFont systemFontOfSize:30];
        self.cityLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.cityLabel];
        
        self.temperatureLabel = [[UILabel alloc] init];
        self.temperatureLabel.font = [UIFont systemFontOfSize:50];
        self.temperatureLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.temperatureLabel];
    } else if ([self.reuseIdentifier isEqualToString:@"head"]) {
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:30];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        self.cityLabel = [[UILabel alloc] init];
        self.cityLabel.font = [UIFont systemFontOfSize:18];
        self.cityLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.cityLabel];
        
        self.temperatureLabel = [[UILabel alloc] init];
        self.temperatureLabel.font = [UIFont systemFontOfSize:50];
        self.temperatureLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.temperatureLabel];
    } else if ([self.reuseIdentifier isEqualToString:@"button"]) {
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.button];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    if ([self.reuseIdentifier isEqualToString:@"main"]) {
        
        self.timeLabel.frame = CGRectMake(10, 5, 100, 30);
        self.cityLabel.frame = CGRectMake(10, 30, 300, 45);
        self.temperatureLabel.frame = CGRectMake(width - 220, 0, 200, 80);
    } else if ([self.reuseIdentifier isEqualToString:@"head"]) {
        
        self.timeLabel.frame = CGRectMake(10, 30, 300, 45);
        self.cityLabel.frame = CGRectMake(10, 5, 100, 30);
        self.temperatureLabel.frame = CGRectMake(width - 220, 0, 220, 80);
        
    } else if ([self.reuseIdentifier isEqualToString:@"button"]) {
        
        self.button.frame = CGRectMake(width - 50, 10, 32, 32);
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
