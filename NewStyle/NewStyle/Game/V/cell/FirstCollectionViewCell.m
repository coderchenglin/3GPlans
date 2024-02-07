//
//  FirstCollectionViewCell.m
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import "FirstCollectionViewCell.h"

@interface FirstCollectionViewCell ()

@property (nonatomic, strong) UIImageView *mainImageView;

@end

@implementation FirstCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    for (int i = 0; i < 3; i++) {
        self.mainImageView = [[UIImageView alloc] init];
        self.mainImageView.backgroundColor = [UIColor whiteColor];
        self.mainImageView.frame = CGRectMake(0 + i * 10, 0 + i * 10, self.frame.size.width - 20, self.frame.size.width - 20);
        self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"meix%d.jpg",i + 1]];
        [self.contentView addSubview:self.mainImageView];
    }
    return self;
}

- (void)layoutSubviews {
    
}

@end
