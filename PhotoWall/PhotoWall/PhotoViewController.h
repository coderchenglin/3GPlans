//
//  PhotoViewController.h
//  PhotoWall
//
//  Created by chenglin on 2023/12/15.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@protocol TransitionPhotoDelegate <NSObject>

- (void)changePhoto:(NSMutableArray *)imageArray;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController

@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, weak) id<TransitionPhotoDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
