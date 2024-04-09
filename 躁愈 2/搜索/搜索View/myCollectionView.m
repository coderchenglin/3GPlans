//
//  myCollectionView.m
//  new
//
//  Created by mac on 2024/2/23.
//

#import "myCollectionView.h"
#import "myCollectionViewCell.h"
#import "shuju.h"
extern UIColor *colorOfBack;
@implementation myCollectionView

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self.shu = [[shuju alloc] init];
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = colorOfBack;
    //self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    //  进行注册 (重点中的重点，一旦注册出现错误，就会导致程序崩溃）
       [self registerClass:[myCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    //NSLog(@"%lu", (unsigned long)self.shu.arraytitle.count);
    return self;
}

//返回分区个数
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每个分区的数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {

    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];


    cell.backgroundColor = colorOfBack;

    [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",  indexPath.row%5+1 ]]];
    cell.label.text = self.shu.arraytitle[indexPath.row%5];
    [cell.avatarimageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row%4+10]]];
    cell.authorlable.text = self.shu.arrayauthor[indexPath.row%4];

    return cell;
}



@end
