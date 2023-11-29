//
//  FreeStyleTableViewCell.m
//  知乎日报
//
//  Created by chenglin on 2023/11/28.
//

#import "FreeStyleTableViewCell.h"

@implementation FreeStyleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:(NSString *)reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        self.showImageView = [[UIImageView alloc] init];
        self.showImageView.layer.cornerRadius = 8;
        self.showImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.showImageView];
        
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 0;
        [self.mainLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        self.mainLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.mainLabel];
        
        self.subLabel = [[UILabel alloc] init];
        self.subLabel.numberOfLines = 0;
        self.subLabel.textColor = [UIColor systemGrayColor];
        [self.contentView addSubview:self.subLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.width.and.height.equalTo(@70);
        }];
        
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@(myWidth - 100));
            make.height.equalTo(@(50));
        }];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(65);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@(myWidth - 100));
            make.height.equalTo(@(20));
        }];
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
