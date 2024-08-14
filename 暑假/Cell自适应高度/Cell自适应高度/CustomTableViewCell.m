//
//  CustomTableViewCell.m
//  Cell自适应高度
//
//  Created by chenglin on 2024/8/13.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@implementation CustomTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self setupViews];
//    }
//    return self;
//}
//
//- (void)setupViews {
//    // 初始化Label
//    self.customLabel = [[UILabel alloc] init];
//    self.customLabel.numberOfLines = 0;  // 多行显示
//    self.customLabel.translatesAutoresizingMaskIntoConstraints = NO;
//
//    // 将Label添加到contentView中
//    [self.contentView addSubview:self.customLabel];
//
//    // 添加AutoLayout约束
//    [NSLayoutConstraint activateConstraints:@[
//        [self.customLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15.0],
//        [self.customLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15.0],
//        [self.customLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10.0],
//        [self.customLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10.0]
//    ]];//依次是定义 左边缘，右边缘，上边缘，下边缘 的约束条件
//}


//- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//
//    if ([reuseIdentifier isEqualToString:@"11"]) {
//        _labelTest = [[UILabel alloc] init];
//        _labelTest.numberOfLines = 0;
//        [self.contentView addSubview:_labelTest];
//        [self layoutIfNeeded];
//    } else {
//        _labelTest = [[UILabel alloc] init];
//        _labelTest.numberOfLines = 0;
//        [self.contentView addSubview:_labelTest];
//        [self layoutIfNeeded];
//    }
//
//    return self;
//}
//
//- (void) layoutSubviews {
//    [super layoutSubviews];
//    [self.contentView addSubview:_labelTest];
//    [_labelTest mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_labelTest.superview.mas_top).offset(10.0);
//        make.bottom.equalTo(_labelTest.superview.mas_bottom).offset(-10);
//        make.left.equalTo(_labelTest.superview.mas_left).offset(10.0);
//        make.right.equalTo(_labelTest.superview.mas_right).offset(-10.0);
//    }];
//}










@end
