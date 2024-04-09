//
//  mineCollectionView.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineCollectionView.h"
#import "mineCollectionViewCell.h"
extern UIColor *colorOfBack;
@implementation mineCollectionView

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = colorOfBack;
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    //  进行注册 (重点中的重点，一旦注册出现错误，就会导致程序崩溃）
       [self registerClass:[mineCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

//返回分区个数
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每个分区的数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    mineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    //cell.backgroundColor = UIColor.grayColor;
    if (indexPath.row == 0) {
        [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"病历.png"]]];
        cell.imageview.frame = CGRectMake(2, 5, 70, 70);
        cell.label.text = @"电子病历";
    } else if (indexPath.row == 1) {
        [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"自测.png"]]];
        cell.imageview.frame = CGRectMake(10, 17.5, 45, 45);
        cell.label.text = @"状态自测";
    } else if (indexPath.row == 2) {
        [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"求助.png"]]];
        cell.imageview.frame = CGRectMake(15, 17.5, 45, 45);
        cell.label.text = @"紧急求助";
    } else {
        [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"休息.png"]]];
        cell.imageview.frame = CGRectMake(10, 20, 40, 40);
        cell.label.text = @"作息状况";
    }
    return cell;
}

@end
