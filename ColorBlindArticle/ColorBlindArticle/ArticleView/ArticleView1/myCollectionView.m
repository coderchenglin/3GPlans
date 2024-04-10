//
//  myCollectionView.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/9.
//

#import "myCollectionView.h"
#import "myCollectionViewCell.h"
#import "shuju.h"
#import "labelViewController.h"


@implementation myCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    
    self.data = [[shuju alloc] init];
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    UIColor *backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    self.backgroundColor = backgroundColor;
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //进行注册
        [self registerClass:[myCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    UIColor *cellBackgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    UIColor *cellBackgroundColor = [UIColor whiteColor];
    cell.backgroundColor = cellBackgroundColor;
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 5 + 100 * self.tag]]];//
    cell.label.text = self.data.titleArray[indexPath.row % 5];
    [cell.avatarImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 4 + 10]]];//10.11.12.13
    cell.authorLabel.text = self.data.authorArray[indexPath.row % 4]; //
    
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
