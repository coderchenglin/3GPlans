//
//  PageThreeView.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/22.
//

#import "PageThreeView.h"
#import "ARPetCollectionViewCell.h"
@implementation PageThreeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupCollectionView];
    return self;
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置item的大小
    layout.itemSize = CGSizeMake(self.frame.size.width / 2 - 20, self.frame.size.width / 2 - 20);
    layout.minimumLineSpacing = 20;
    
    self.customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height) collectionViewLayout:layout];

    self.customCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.customCollectionView];
//    [self.customCollectionView registerClass:[ARPetCollectionViewCell class] forCellWithReuseIdentifier:@"aRPetCollectionViewCell"];

    [self addSubview:self.customCollectionView];
}

@end
