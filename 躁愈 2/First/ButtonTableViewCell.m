//
//  ButtonTableViewCell.m
//  CollectionView1
//
//  Created by 夏楠 on 2024/2/26.
//

#import "ButtonTableViewCell.h"
#import "Masonry.h"
@implementation ButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLabel1 = [[UILabel alloc] init];
    _btnLabel2 = [[UILabel alloc] init];
    _btnLabel3 = [[UILabel alloc] init];
    _btnLabel4 = [[UILabel alloc] init];

    
    NSString *strName1 = @"btn1.png";
    [_btn1 setImage:[UIImage imageNamed:strName1] forState:UIControlStateNormal];
    NSString *strName2 = @"btn2.png";
    [_btn2 setImage:[UIImage imageNamed:strName2] forState:UIControlStateNormal];
    NSString *strName3 = @"btn3.png";
    [_btn3 setImage:[UIImage imageNamed:strName3] forState:UIControlStateNormal];
    NSString *strName4 = @"btn4.png";
    [_btn4 setImage:[UIImage imageNamed:strName4] forState:UIControlStateNormal];
    

    [self.contentView addSubview:_btn1];
    [self.contentView addSubview:_btn2];
    [self.contentView addSubview:_btn3];
    [self.contentView addSubview:_btn4];
    [self.contentView addSubview:_btnLabel1];
    [self.contentView addSubview:_btnLabel2];
    [self.contentView addSubview:_btnLabel3];
    [self.contentView addSubview:_btnLabel4];

#pragma mark 设置文字
    _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_btn1.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _btn1.imageEdgeInsets = UIEdgeInsetsMake(30,30,30,30);
    _btnLabel1.textAlignment = NSTextAlignmentCenter;
    _btnLabel1.text = @"专注";
    _btnLabel1.font = [UIFont systemFontOfSize:12];
    _btnLabel1.textColor = [UIColor grayColor];
    
    _btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_btn2.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _btn2.imageEdgeInsets = UIEdgeInsetsMake(33,33,33,33);
    _btnLabel2.textAlignment = NSTextAlignmentCenter;
    _btnLabel2.text = @"睡眠";
    _btnLabel2.font = [UIFont systemFontOfSize:12];
    _btnLabel2.textColor = [UIColor grayColor];
    
    _btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_btn3.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _btn3.imageEdgeInsets = UIEdgeInsetsMake(32,32,32,32);
    _btnLabel3.textAlignment = NSTextAlignmentCenter;
    _btnLabel3.text = @"小憩";
    _btnLabel3.font = [UIFont systemFontOfSize:12];
    _btnLabel3.textColor = [UIColor grayColor];

    _btn4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_btn4.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _btn4.imageEdgeInsets = UIEdgeInsetsMake(27,27,27,27);
    _btnLabel4.textAlignment = NSTextAlignmentCenter;
    _btnLabel4.text = @"呼吸";
    _btnLabel4.font = [UIFont systemFontOfSize:12];
    _btnLabel4.textColor = [UIColor grayColor];
    
    return self;
}

- (void)layoutSubviews {
    _btn1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.width / 4);
    _btn2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4, 0, [UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.width / 4);
    _btn3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 2, 0, [UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.width / 4);
    _btn4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 3, 0, [UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.width / 4);
    
    [_btnLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btn1.imageView.mas_bottom).offset(5);
            make.height.equalTo(@20);
            make.left.equalTo(_btn1.imageView.mas_left);
            make.right.equalTo(_btn1.imageView.mas_right);
    }];
    [_btnLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btn2.imageView.mas_bottom).offset(8);
            make.height.equalTo(@20);
            make.left.equalTo(_btn2.imageView.mas_left);
            make.right.equalTo(_btn2.imageView.mas_right);
    }];
    [_btnLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btn3.imageView.mas_bottom).offset(7);
            make.height.equalTo(@20);
            make.left.equalTo(_btn3.imageView.mas_left);
            make.right.equalTo(_btn3.imageView.mas_right);
    }];
    [_btnLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btn4.imageView.mas_bottom).offset(4);
            make.height.equalTo(@20);
            make.left.equalTo(_btn4.imageView.mas_left);
            make.right.equalTo(_btn4.imageView.mas_right);
    }];
}
@end
