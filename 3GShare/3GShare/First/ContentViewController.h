//
//  ContentViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@protocol TransmissionDelegate <NSObject>

- (void)transmissionNumber:(NSMutableArray*)numberArray;

@end

@interface ContentViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *lookButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) NSString *good;
@property (nonatomic, strong) NSString *look;
@property (nonatomic, strong) NSString *share;
@property (nonatomic, assign) NSInteger shareNumber;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *mutableArray;

@property (nonatomic, weak) id<TransmissionDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
