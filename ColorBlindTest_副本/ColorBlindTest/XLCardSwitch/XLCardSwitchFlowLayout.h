//
//  XLCardSwitchFlowLayout.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^XLCenterIndexPathBlock)(NSIndexPath *indexPath);

@interface XLCardSwitchFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) XLCenterIndexPathBlock centerBlock;

@end

NS_ASSUME_NONNULL_END
