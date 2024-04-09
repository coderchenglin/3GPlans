//
//  MyLayout.m
//  WaterFall
//
//  Created by chenglin on 2024/4/6.
//

#import "MyLayout.h"

@implementation MyLayout{
    NSMutableArray * attributeArray; // frame 数组
    NSInteger _collectViewRowCount;  // 列数
    NSMutableArray * _originYAry;    //记录每一列的Y点坐标

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        attributeArray = [NSMutableArray array];
        _originYAry = [NSMutableArray array];
        _collectViewRowCount = 2;
        
    }
    return self;
}


- (void)prepareLayout{
    
    [attributeArray removeAllObjects];
    [_originYAry removeAllObjects];
    
    //初始化y坐标
    for (int i =0; i <_collectViewRowCount; i++) {
        [_originYAry addObject:@(0)];
    }
    
    //返回
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
        
    for (int i = 0; i < cellCount; i ++ ) {
            
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
        //UICollectionViewLayoutAttributes 用于存储layout属性的对象
        UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForItemAtIndexPath:indexPath];
            
        [attributeArray addObject:attrib];
    }
}
 
//2.返回指定indexPath下的 UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据indexPath创建一个UICollectionViewLayoutAttributes
    UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置每个frame
    CGFloat width = ([UIScreen mainScreen].bounds.size.width) /_collectViewRowCount;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row%5+1]];
    
    CGSize photosize = self.image.size;
  //  NSLog(@"photo width: %f, height: %f", photosize.width, photosize.height);
    CGFloat height = (photosize.height/photosize.width)*191 + 120;
  //  NSLog(@"height = %lf", height);
    CGFloat x = width * ( indexPath.row % _collectViewRowCount);
    
    CGFloat y = [_originYAry[indexPath.row % _collectViewRowCount] floatValue];
    _originYAry[indexPath.row % _collectViewRowCount] = @(height + y +10);
    layoutAttr.frame =CGRectMake(x, y, width, height);
    
    return layoutAttr;
}
 
//3.返回collectionView的ContentSize
//由于瀑布流每一列的高度不一定，所以需要判读出最高的列作为height
-(CGSize)collectionViewContentSize{
    
    //kvc 获取最大值
    CGFloat maxY =[[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, maxY);
}
 
//4.Returns the layout attributes for all of the cells and views in the specified rectangle.
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return attributeArray;
}

@end
