//
//  UUCollectionViewFlowLayout.m
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import "UUCollectionViewFlowLayout.h"

//默认的列数
static const NSInteger DefaultColumnCpunt = 3;

//每一列之间的间距
static const CGFloat DefaultColumnMargin  = 10;

//没一行之间的间距
static const CGFloat DefaultRowMargin     = 10;

//边缘间距
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};

@interface UUCollectionViewFlowLayout ()

/**
 存放所有cell的布局属性
 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/**
 存放所有列的布局高度
 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

/**
 内容高度
 */
@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end
@implementation UUCollectionViewFlowLayout

#pragma mark ===== 做一些初始化的操作，必须先调用一下父类的实现 =====

-(void)prepareLayout{
    [super prepareLayout];
    //  内容高度初始为0
    self.contentHeight = 0;
    //  清除之前计算的所有的高度，因为刷新的时候会调用这个方法
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < DefaultColumnCpunt; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    //  把初始化的操作都放到这里
    [self.attrsArray removeAllObjects];
    //  开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //  创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //  获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

#pragma mark ===== 返回的是一个装着UICollectionViewLayoutAttributes的数组 =====

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

#pragma mark ===== 返回indexPath位置的UICollectionViewLayoutAttributes =====

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //  首先取出每一个indexPath对应的Attributes
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //  collectionView宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    //  attrs的宽度
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    //  attrs的高度
    CGFloat h = [(id)self.delegate WaterFlowLayout:self heightForRowAtIndexPath:indexPath.item itemWidth:w];
    //  标记是哪一列的
    NSInteger destColumn = 0;
    //  定义minColumnHeight为最小的列的高度
    CGFloat minColumnHeight = [self.columnHeights[0] floatValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] floatValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    //  计算x坐标
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    //  计算y坐标
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    //  重新给attrs赋值
    attrs.frame = CGRectMake(x, y, w, h);
    //  更新这一列的高度，这一列最长了
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //  最长列的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] floatValue];
    //  重新给collectionView的滚动范围赋值
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

#pragma mark ===== 返回可滚动范围 =====

-(CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);;
}

#pragma mark ===== 懒加载 =====

-(NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (UIEdgeInsets)edgeInsets{
    return DefaultEdgeInsets;
}

- (CGFloat)rowMargin{
    return DefaultRowMargin;
}

- (CGFloat)columnMargin{
    return DefaultColumnMargin;
}

- (NSInteger)columnCount{
        return DefaultColumnCpunt;
}

@end
