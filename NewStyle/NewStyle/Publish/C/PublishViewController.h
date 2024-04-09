//
//  PublishViewController.h
//  NewStyle
//
//  Created by chenglin on 2024/2/12.
//

#import <UIKit/UIKit.h>
#import "PublishView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PublishViewController : UIViewController
@property (nonatomic, strong) PublishView *publishView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) int flag;
@end

NS_ASSUME_NONNULL_END
