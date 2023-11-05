//
//  ShowTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "ShowTableViewCell.h"

@implementation ShowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([self.reuseIdentifier isEqualToString:@"show"]) {
        _lookNumber = 26;
        _look = [[NSString alloc] initWithFormat:@"%d", _lookNumber];
        _shareNumber = 102;
        _share = [[NSString alloc] initWithFormat:@"%d", _shareNumber];
        
        _showImageView = [[UIImageView alloc] init];
        
        _titleLable = [[UILabel alloc] init];
        _describeLable = [[UILabel alloc] init];
        _timeLable = [[UILabel alloc] init];
        _tipsLable = [[UILabel alloc] init];
        _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *goodImageName = [[NSString alloc] initWithFormat:@"button_good.png"];
        NSString *lookImageName = [[NSString alloc] initWithFormat:@"button_look.png"];
        NSString *shareImageName = [[NSString alloc] initWithFormat:@"button_share.png"];
        [_goodButton setImage:[UIImage imageNamed:goodImageName] forState:UIControlStateNormal];
        [_lookButton setImage:[UIImage imageNamed:lookImageName] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:shareImageName] forState:UIControlStateNormal];
        
        [_goodButton setTitle:@"957" forState:UIControlStateNormal];
        [_goodButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_lookButton setTitle:_look forState:UIControlStateNormal];
        [_lookButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_shareButton setTitle:_share forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _goodButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _lookButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_goodButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton addTarget:self action:@selector(pressShare:) forControlEvents:UIControlEventTouchUpInside];
        _goodButton.tag = 201;
        _lookButton.tag = 201;
        _shareButton.tag = 201;
     
        //调试用的
//        _goodButton.layer.borderWidth = 1;
//        _lookButton.layer.borderWidth = 1;
//        _shareButton.layer.borderWidth = 1;
        
        //讲解contenView
//        contenView 是UITableViewCell类的一个属性，用于显示自定义内容的主要视图
//        作用：
//         contentView 是 UITableViewCell 中的一个 UIView                         对象，作为单元格内容的主要容器视图。
//          它是用来放置自定义内容的，比如标签、图像视图、按钮或其他自定义视图，用于展示单元格中的内容。
        [self.contentView addSubview:_showImageView];
        [self.contentView addSubview:_titleLable];
        [self.contentView addSubview:_describeLable];
        [self.contentView addSubview:_timeLable];
        [self.contentView addSubview:_tipsLable];
        [self.contentView addSubview:_goodButton];
        [self.contentView addSubview:_lookButton];
        [self.contentView addSubview:_shareButton];
        
        //各个内容的layout
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _describeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = [UIFont systemFontOfSize:20];
        _describeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _tipsLable.font = [UIFont systemFontOfSize:14];
        
        //numberOfLines 是 UILabel 的一个属性，设置文本显示行数，设置为0就是自动换行
        _tipsLable.numberOfLines = 0;
        _titleLable.numberOfLines = 0;
        _describeLable.numberOfLines = 0;
        _timeLable.numberOfLines = 0;
        
        _showImageView.layer.masksToBounds = YES;
        _showImageView.layer.cornerRadius = 10.0;
    }
    return self;
}

//这个方法是自动调用的！
- (void)layoutSubviews {
    _showImageView.frame = CGRectMake(0, 0, 200, 150);
    _titleLable.frame = CGRectMake(210, 0, 220, 40);
    _describeLable.frame = CGRectMake(210, 40, 220, 20);
    _tipsLable.frame = CGRectMake(210, 60, 220, 30);
    _timeLable.frame = CGRectMake(210, 90, 220, 20);
    _goodButton.frame = CGRectMake(220, 110, 60, 40);
    _lookButton.frame = CGRectMake(280, 110, 60, 40);
    _shareButton.frame = CGRectMake(340, 110, 60, 40);
    
    //改变button的文字和图像距离 上，左，下，右 边界的距离
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [_goodButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_goodButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [_lookButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_lookButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [_shareButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_shareButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
}

- (void)pressGood:(UIButton*)button {
    if (button.tag == 201) {
        [_goodButton setTitle:@"958" forState:UIControlStateNormal];
        button.tag = 202;
    } else {
        [_goodButton setTitle:@"957" forState:UIControlStateNormal];
        button.tag = 201;
    }
}

- (void)pressShare:(UIButton*)button {
    _shareNumber++;
    _share = [[NSString alloc] initWithFormat:@"%d", _shareNumber];
    [_shareButton setTitle:_share forState:UIControlStateNormal];
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
