//
//  BaseViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//

#import <UIKit/UIKit.h>
#import "ShowTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *firstTableView;
@property (nonatomic, strong) UITableView *secondTableView;
@property (nonatomic, strong) UITableView *thirdTableView;
//share人
@property (nonatomic, copy) NSArray *oneArray;
@property (nonatomic, copy) NSArray *twoArray;
@property (nonatomic, copy) NSArray *threeArray;
//时间
@property (nonatomic, copy) NSArray *timeOneArray;
@property (nonatomic, copy) NSArray *timeTwoArray;
@property (nonatomic, copy) NSArray *timeThreeArray;
//标题
@property (nonatomic, copy) NSArray *firstArray;
@property (nonatomic, copy) NSArray *secondArray;
@property (nonatomic, copy) NSArray *thirdArray;
//提示
@property (nonatomic, copy) NSArray *tipsOneArray;
@property (nonatomic, copy) NSArray *tipsTwoArray;
@property (nonatomic, copy) NSArray *tipsThreeArray;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

- (void)pressSegmented:(UISegmentedControl*)segmentedControl;  //如果希望子类能调用父类的方法，在父类的.h文件中，需要声明该方法


@end

NS_ASSUME_NONNULL_END
