//
//  AView.h
//  响应者链
//
//  Created by chenglin on 2024/8/3.
//

#import <UIKit/UIKit.h>
#import "DView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AView : UIView
@property (nonatomic, strong) DView *dv;
@end

NS_ASSUME_NONNULL_END
