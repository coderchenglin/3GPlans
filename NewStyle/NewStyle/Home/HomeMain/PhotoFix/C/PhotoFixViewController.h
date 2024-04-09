//
//  PhotoFixViewController.h
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFixViewController : UIViewController
@property (nonatomic, assign) int numberOfFix;  //记录第几个功能
@property (nonatomic, strong) UIImage *oldImage; //传入的修复前照片
@end

NS_ASSUME_NONNULL_END
