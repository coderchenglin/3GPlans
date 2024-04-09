//
//  UUCollectionViewFlowLayout.h
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UUCollectionViewFlowLayout;
@protocol UUCollectionViewFlowLayoutDelegate <NSObject>
- (CGFloat)WaterFlowLayout:(UUCollectionViewFlowLayout *)UUCollectionViewFlowLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth;
@end
@interface UUCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (weak, nonatomic) id <UUCollectionViewFlowLayoutDelegate> delegate;
@end
