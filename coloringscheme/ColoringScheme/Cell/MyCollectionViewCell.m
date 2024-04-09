//
//  MyCollectionViewCell.m
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import "MyCollectionViewCell.h"
#import "Masonry.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    //self.titleLabel.autoresizingMask
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(3);
        make.width.equalTo(self);
    }];
    
}



@end
