//
//  mineCollectionViewCell.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineCollectionViewCell.h"

@implementation mineCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //设置为圆角
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    
    self.imageview = [[UIImageView alloc] init];
//    self.imageview.layer.cornerRadius = 30;
//    self.imageview.layer.masksToBounds = YES;
    
    self.label =[[UILabel alloc] init];
    self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size: 20];
    
    [self.contentView addSubview:self. imageview];
    [self.contentView addSubview:self. label];
    
    return self;
}

- (void) layoutSubviews {
    //self.imageview.frame = CGRectMake(10, 10, 60, 60);
    self.label.frame = CGRectMake(70, 30, 100, 20);
}
@end
