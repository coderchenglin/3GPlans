//
//  MyLayout.m
//  reWriteLastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import "MyLayout.h"

@implementation MyLayout {
    NSMutableArray *_attributeArray;  //frame数组
    NSInteger _collectViewRowCount;   //列数
    NSMutableArray *_originYAry;      //记录每一列的Y点坐标
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _attributeArray = [NSMutableArray array];
        _originYAry = [NSMutableArray array];
        _collectViewRowCount = 2;
    }
    return self;
}

- (void)prepareLayout {
    
    [_attributeArray removeAllObjects];
    [_originYAry removeAllObjects];
    
    //初始化y坐标
    for (int i = 0; i < _collectViewRowCount; i++) {
        [_originYAry addObject:@(0)];
    }
    
    //元素个数
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributeArray addObject:attribute];
    }
}

//2.返回指定indexPath下的 UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //根据indexPath创建一个UICollectionViewLayoutAttributes
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置每个frame
    CGFloat width = [UIScreen mainScreen].bounds.size.width / _collectViewRowCount;
    NSLog(@"width = %f", width);
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 5 + 1]];
    
    CGSize photoSize = self.image.size;
    CGFloat height = (photoSize.height / photoSize.width) * width + 75;
    
    CGFloat x = width * (indexPath.row % _collectViewRowCount);
    CGFloat y = [_originYAry[indexPath.row % _collectViewRowCount] floatValue];
    _originYAry[indexPath.row % _collectViewRowCount] = @(height + y + 10);
    layoutAttributes.frame = CGRectMake(x, y, width, height);
    
    return layoutAttributes;
}

//3.返回collectionView的ContentSize
//由于瀑布流每一列的高度不一定，所以需要判读出最高的列作为height
- (CGSize)collectionViewContentSize {
    
    //kvc 获取最大值
    CGFloat maxY = [[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, maxY);
}

//4.
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributeArray;
}

@end
