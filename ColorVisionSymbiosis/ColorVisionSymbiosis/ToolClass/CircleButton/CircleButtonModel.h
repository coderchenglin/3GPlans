//
//  CircleButtonModel.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CircleButtonModel <NSObject>

@end

@interface CircleButtonModel : NSObject

/*! @brief 颜色 */
@property(nonatomic, strong) UIColor *color;
/*! @brief 大小 */
@property(nonatomic, assign) CGSize size;
/*! @brief 当前的位置 */
@property(nonatomic, assign) CGPoint center;
/*! @brief 角度 */
@property(nonatomic, assign) int angle;

@end

NS_ASSUME_NONNULL_END
