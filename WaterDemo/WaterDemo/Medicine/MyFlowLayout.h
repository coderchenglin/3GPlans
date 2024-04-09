//
//  MyFlowLayout.h
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFlowLayout : UICollectionViewFlowLayout
//NSMutableArray* attributeArray ; // frame数组
//NSInteger _collectViewRowCount ; //列数
//NSMutableArray* _originYAry ; //记录每一组的Y点坐标

@property (nonatomic, strong) NSMutableArray* attributeArray ;
@property (nonatomic, strong) NSMutableArray* originYAry ;
@property (nonatomic, strong) NSMutableArray <NSNumber*>* medicine_array ;
@end

NS_ASSUME_NONNULL_END
