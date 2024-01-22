//
//  LabelTableViewCell.m
//  FoldCell
//
//  Created by chenglin on 2023/12/15.
//

#import "LabelTableViewCell.h"

@implementation LabelTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.expanded = NO;
//        self.contentArray = @[@"Content 1", @"Content 2", @"Content 3", @"Content 4", @"Content 5"];
//        [self setupCellWithContent:self.contentArray[0]]; //初始化显示第一个内容
//    }
//
//    return self;
//}
//
//
//- (void)setupCellWithContent:(NSString *)content {
//    self.textLabel.text = content;
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        self.showLabel = [[UILabel alloc] init];
        self.showLabel.font = [UIFont systemFontOfSize:30];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.showLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.showLabel.frame = CGRectMake(0, 0, 300, 50);
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
