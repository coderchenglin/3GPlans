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
    } else if ([self.reuseIdentifier isEqualToString:@"head"]){
        _aImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_aImageView];
    } else if ([self.reuseIdentifier isEqualToString:@"sex"]) {
        _aButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_aButton setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(pressMan:) forControlEvents:UIControlEventTouchUpInside];
        _aButton.tag = 201;
        [self.contentView addSubview:_aButton];
        
        _bButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bButton setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
        [_bButton addTarget:self action:@selector(pressWoman:) forControlEvents:UIControlEventTouchUpInside];
        _bButton.tag = 301;
        [self.contentView addSubview:_bButton];
        
        _man = [[UILabel alloc] init];
        _man.font = [UIFont systemFontOfSize:18];
        _man.text = @"男";
        [self.contentView addSubview:_man];
        
        _woman = [[UILabel alloc] init];
        _woman.font = [UIFont systemFontOfSize:18];
        _woman.text = @"女";
        [self.contentView addSubview:_woman];
    } else if ([self.reuseIdentifier isEqualToString:@"label"]) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_desLabel];
    } else if ([self.reuseIdentifier isEqualToString:@"news"]) {
        _aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aButton setImage:[UIImage imageNamed:@"qaz.png"] forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(pressDui:) forControlEvents:UIControlEventTouchUpInside];
        _aButton.tag = 401;
        [self.contentView addSubview:_aButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:@"information"]) {
        _label.frame = CGRectMake(10, 10, 200, 30);
        _goodImageView.frame = CGRectMake(340, 10, 30, 30);
        _numberLabel.frame = CGRectMake(380, 10, 30, 30);
    } else if ([self.reuseIdentifier isEqualToString:@"head"]) {
        _label.frame = CGRectMake(10, 35, 200, 30);
        _aImageView.frame = CGRectMake(100, 12.5, 75, 75);
    } else if ([self.reuseIdentifier isEqualToString:@"sex"]) {
        _label.frame = CGRectMake(10, 10, 200, 30);
        _aButton.frame = CGRectMake(100, 10, 30, 30);
        _bButton.frame = CGRectMake(180, 10, 30, 30);
        _man.frame = CGRectMake(132, 10, 30, 30);
        _woman.frame = CGRectMake(212, 10, 30, 30);
    } else if ([self.reuseIdentifier isEqualToString:@"label"]) {
        _label.frame = CGRectMake(10, 10, 200, 30);
        _desLabel.frame = CGRectMake(100, 10, 350, 30);
    } else if ([self.reuseIdentifier isEqualToString:@"news"]) {
        _label.frame = CGRectMake(20, 10, 200, 30);
        _aButton.frame = CGRectMake(340, 15, 20, 20);
    }
}

- (void)pressDui:(UIButton*)button {
    if (_aButton.tag == 401) {
        [_aButton setImage:[UIImage imageNamed:@"wsx.png"] forState:UIControlStateNormal];
        _aButton.tag = 402;
    } else {
        [_aButton setImage:[UIImage imageNamed:@"qaz.png"] forState:UIControlStateNormal];
        _aButton.tag = 401;
    }
}

- (void)pressWoman:(UIButton*)button {
    if (_bButton.tag == 301) {
        [_bButton setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateNormal];
        [_aButton setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
        _bButton.tag = 201;
        _aButton.tag = 301;
    }
}

- (void)pressMan:(UIButton*)button {
    if (_aButton.tag == 301) {
        [_aButton setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateNormal];
        [_bButton setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
        _aButton.tag = 201;
        _bButton.tag = 301;
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
