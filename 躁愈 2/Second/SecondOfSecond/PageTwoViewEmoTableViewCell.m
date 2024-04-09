//
//  PageTwoViewEmoTableViewCell.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/20.
//

#import "PageTwoViewEmoTableViewCell.h"

@implementation PageTwoViewEmoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"pageTwoViewEmoTableViewCell"];
    
    _pictureView = [[UIImageView alloc] init];
    [self.contentView addSubview:_pictureView];
    
    _labelFirst = [[UILabel alloc] init];
    [self.contentView addSubview:_labelFirst];
    
    _labelSecond = [[UILabel alloc] init];
    [self.contentView addSubview:_labelSecond];
    
    
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    return self;
    
}

- (void)layoutSubviews {
    CGFloat cellWidth = self.contentView.frame.size.width / 2;
    CGFloat cellHeight = self.contentView.frame.size.height;
    
    _pictureView.frame = CGRectMake(10, 10, cellWidth - 20, 150);
    _titleLabel.frame = CGRectMake(cellWidth, 10, cellWidth, 25);
    _labelFirst.frame = CGRectMake(cellWidth, 35, cellWidth, 15);
    _labelSecond.frame = CGRectMake(cellWidth, 50, cellWidth, 15);
    
//    设置字体大小
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    _labelFirst.font = [UIFont systemFontOfSize:14.0];
    _labelSecond.font = [UIFont systemFontOfSize:14.0];

#pragma mark 裁剪cell边框
    CGFloat margin = 10;
       CGRect bounds = self.bounds;
       CGRect contentRect = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - 2 * margin, bounds.size.height);
       
       // 设置圆角
       self.contentView.layer.cornerRadius = 10;
       self.contentView.layer.masksToBounds = YES;
    self.pictureView.layer.cornerRadius = 10;
    self.pictureView.layer.masksToBounds = YES;

//       // 设置阴影
//       self.layer.shadowOffset = CGSizeMake(0, 1);
//       self.layer.shadowRadius = 5.0;
//       self.layer.shadowColor = [UIColor blackColor].CGColor;
//       self.layer.shadowOpacity = 0.25;
//       
//       // 阴影路径
//       self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:self.contentView.layer.cornerRadius].CGPath;
//       
//       // 设置子视图的frame
//       // 例如: self.customSubview.frame = CGRectMake(15, 15, contentRect.size.width - 30, contentRect.size.height - 30);
//       
//       // 调整cell内容视图的大小
//       self.contentView.frame = contentRect;
}
@end
