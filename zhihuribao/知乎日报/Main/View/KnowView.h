//
//  KnowView.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/17.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "FreeStyleTableViewCell.h"
#import "NetworkJSONModel.h"
#import "SDWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowView : UIView<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;  //整体的tableView
@property (nonatomic, strong) UIScrollView *scrollView;   //首界面上面的轮播图
@property (nonatomic, strong) UITableViewCell *rollCell;  //主界面的轮播图cell，就用系统自带的UITableViewCell，上面添加scrollView即可。
@property (nonatomic, strong) UITableViewCell *flashCell;   //显示小菊花的cell
@property (nonatomic, strong) FreeStyleTableViewCell *showCell;  //新闻部分用的自定义cell
//@property (nonatomic, strong) UIButton *rollButton;  //？
@property (nonatomic, strong) UIPageControl *pageControl; //pageControl
@property (nonatomic, strong) NSTimer *timer; //定时器

@property (nonatomic, assign) NSInteger currentIndex; //当前轮播图的位置
@property (nonatomic, assign) NSInteger allIndex;     //总图片数
@property (nonatomic, assign) NSInteger UnKnowflag;   //确定是不是第一次加载cell
@property (nonatomic, assign) NSInteger againFlag;
@property (nonatomic, assign) float allOffset; //改变前的offset，与scrollView.contentOffset.x进行对比用的

@property (nonatomic, strong) NSMutableArray *storiesTitle;
@property (nonatomic, strong) NSMutableArray *storiesUrl;
@property (nonatomic, strong) NSMutableArray *storiesHint;
@property (nonatomic, strong) NSMutableArray *storiesImages;
@property (nonatomic, strong) NSMutableArray *storiesId;

@property (nonatomic, strong) NSMutableArray *top_storiesTitle;
@property (nonatomic, strong) NSMutableArray *top_storiesUrl;
@property (nonatomic, strong) NSMutableArray *top_storiesHint;
@property (nonatomic, strong) NSMutableArray *top_storiesImage;
@property (nonatomic, strong) NSMutableArray *top_storiesId;

@property (nonatomic, strong) NSMutableArray *temporaryArray;  //临时存储一组字典型数据
@property (nonatomic, strong) NSMutableArray *allNetworkData;  //存储所有的字典型数据
@property (nonatomic, strong) NSMutableArray *allTopNetworkData;  //存储所有top的字典型数据
@property (nonatomic, strong) NSMutableArray *allTransURL;   //存储所有的URL
@property (nonatomic, strong) NSMutableArray *allTransID;   //存储所有的ID
@property (nonatomic, strong) NSMutableArray *allRollButton;  //存储所有的滚动视图上的button
@property (nonatomic, assign) NSInteger rollLocation;  //记录滚动视图上的button的滚动位置。滚动的时候就确定。可能是第38个cell

//假导航栏，（就最顶部那个，日期，竖线，晚上好，头像按钮
@property (nonatomic, strong) UIButton *flaseButton; //头像按钮
@property (nonatomic, strong) UILabel *flaseLabel;
@property (nonatomic, strong) UILabel *monthLabel;//存储汉字月份
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *lineLabel;

//加载小菊花
@property (nonatomic, strong) UIActivityIndicatorView *flashView;
@property (nonatomic, assign) NSInteger networkFlag;

- (void)creatFalseView;

@end

NS_ASSUME_NONNULL_END
