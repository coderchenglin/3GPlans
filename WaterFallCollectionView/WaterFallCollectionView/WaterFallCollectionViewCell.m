//
//  WaterFallCollectionViewCell.m
//  WaterFallCollectionView
//
//  Created by chenglin on 2024/4/4.
//

#import "WaterFallCollectionViewCell.h"

@implementation WaterFallCollectionViewCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//
//    if (self) {
//        float newHeight = _image.size.height / _image.size.width * 176.5;
//        [_image drawInRect:CGRectMake(0, 0, 176.5, newHeight)];
//
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, newHeight + 5, 176.5, 30)];
//        self.label.textColor = [UIColor blackColor];
//        self.label.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:self.label];
//    }
//    return self;
//}


- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    [self setNeedsDisplay];
}

- (void)setLabel:(UILabel *)label {
    if (_label != label) {
        _label = label;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    float newHeight = _image.size.height / _image.size.width * 176.5;
    [_image drawInRect:CGRectMake(0, 0, 176.5, newHeight)];

    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, newHeight + 5, 176.5, 30)];
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"123";
    self.label.numberOfLines = 1;
    [self.contentView addSubview:self.label];
//    NSLog(@"cellum = %f,%f,%f",_image.size.width,_image.size.height,newHeight);
}

@end
