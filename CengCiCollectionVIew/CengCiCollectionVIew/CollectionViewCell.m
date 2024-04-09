//
//  CollectionViewCell.m
//  CengCiCollectionVIew
//
//  Created by chenglin on 2024/4/4.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //初始化图片视图
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 40)]; //假设标签栏占20
        [self.contentView addSubview:self.imageView];
        
        //初始化标签
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 20, self.contentView.frame.size.width, 40)];
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
