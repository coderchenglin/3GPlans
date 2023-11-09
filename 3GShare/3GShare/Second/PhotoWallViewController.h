//
//  PhotoWallViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoWallDelegate <NSObject>

- (void)changePhoto:(NSMutableArray*)imageArray;

@end

@interface PhotoWallViewController : UIViewController

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIButton* selectButton;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, assign) id<PhotoWallDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
