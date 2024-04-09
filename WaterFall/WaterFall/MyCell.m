//
//  MyCell.m
//  WaterFall
//
//  Created by chenglin on 2024/4/6.
//

#import <UIKit/UIKit.h>

@interface MyCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
