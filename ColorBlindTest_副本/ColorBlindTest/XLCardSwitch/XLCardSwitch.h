//
//  XLCardSwitch.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import <UIKit/UIKit.h>
#import "XLCardModel.h"
//#import "ColorTestModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XLCardSwitchDelegate <NSObject>

@optional

//点击卡片代理方法
- (void)cardSwitchDidClickAtIndex:(NSInteger)index;

//滚动卡片代理方法
- (void)cardSwitchDidScrollToIndex:(NSInteger)index;

@end

@interface XLCardSwitch : UIView

//当前选中位置
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

//设置数据源
@property (nonatomic, strong) NSArray <XLCardModel *>* models;

//代理
@property (nonatomic, weak) id<XLCardSwitchDelegate>delegate;

//是否分页 默认为true
@property (nonatomic, assign) BOOL pagingEnabled;

@property (nonatomic, strong) UICollectionView *collectionView;

//手动滚动到某个卡片位置
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;


@property (nonatomic, assign) CGFloat dragStartX;

@property (nonatomic, assign) CGFloat dragEndX;

@property (nonatomic, assign) CGFloat dragAtIndex;

//@property (nonatomic, strong) UIButton *submitButton;

- (void)fixCellToCenter;

- (void)scrollToCenterAnimated:(BOOL)animated;

- (void)performClickDelegateMethod;

@end






NS_ASSUME_NONNULL_END
