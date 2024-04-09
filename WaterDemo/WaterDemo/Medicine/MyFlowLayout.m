//
//  MyFlowLayout.m
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout {
//    NSMutableArray* attributeArray ; // frame数组
    NSInteger _collectViewRowCount ; //列数
//    NSMutableArray* _originYAry ; //记录每一组的Y点坐标
}

- (instancetype)init {
    self = [super init] ;
    if (self) {
        _attributeArray = [NSMutableArray array] ;
        _originYAry = [NSMutableArray array] ;
        _collectViewRowCount = 2 ;
        //
//        if (self.medicine_array) {
            
//        }
    }
    return self;
}

- (void)prepareLayout {
    [_attributeArray removeAllObjects] ;
    [_originYAry removeAllObjects] ;
    
    //初始化y坐标
    for (int i = 0; i < _collectViewRowCount; i++) {
        [_originYAry addObject:@(0)] ;
    }

    //返回
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0] ;
    
    for (int i = 0; i < cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0] ;
        UICollectionViewLayoutAttributes* attrib = [self layoutAttributesForItemAtIndexPath:indexPath] ;
        [_attributeArray addObject:attrib] ;
    }
}

//返回指定indexPath下的UIcollectionViewlayoutAttributes
- (UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes* layoutAtr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath] ;
    NSInteger medicine_rowcount ;
    //设置每一个frame
    if ([self.medicine_array[indexPath.row] intValue] == 0) {
         medicine_rowcount = 1 ;
    } else {
        medicine_rowcount = ([self.medicine_array[indexPath.row] intValue] - 1 ) / 3 + 1 ;
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / _collectViewRowCount - 40 ;
    CGFloat height = 100 + 40 * (medicine_rowcount - 1) ;
    CGFloat x = (width + 20) * (indexPath.row % _collectViewRowCount) + 20 ;
    CGFloat y = [_originYAry[indexPath.row % _collectViewRowCount] floatValue] ;
    _originYAry[indexPath.row % _collectViewRowCount] = @(height + y + 10) ;
    layoutAtr.frame = CGRectMake(x, y, width, height) ;
    return  layoutAtr ;
}

//返回collectionView的Contentsize
//由于瀑布流每一列高度不一定，所以需要判读出最高的列作为height
- (CGSize)collectionViewContentSize {
    
    //kvc 获取最大值
    CGFloat maxY = [[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue] ;
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,maxY) ;
}

//

- (NSArray<UICollectionViewLayoutAttributes* >*)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributeArray;
}

@end
