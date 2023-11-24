//
//  ShowViewController.h
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import <UIKit/UIKit.h>
#import "ShowTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ShowViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *weatherButton;

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *weaLabel;
@property (nonatomic, strong) NSMutableArray *endArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger number;  //属性传值 - 添加的城市个数
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *transArray;  //属性传值 - 城市名数组
@property (nonatomic, assign) NSInteger index; //属性传值 - 当前page的索引值

@property (nonatomic, strong) NSMutableArray *allInformationArray;

@end

NS_ASSUME_NONNULL_END
