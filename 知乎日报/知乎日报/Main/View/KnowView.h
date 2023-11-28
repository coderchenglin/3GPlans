//
//  KnowView.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "FreeStyleTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface KnowView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableViewCell *rollCell;
@property (nonatomic, strong) UITableViewCell *flashCell;
//@property (nonatomic, strong) FreeStyleTableViewCell *showCell;
@property (nonatomic, strong) UIButton *rollButton;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentIndex;//当前的中心位置图片
@property (nonatomic, assign) NSInteger allIndex; //总图片数
@property (nonatomic, assign) NSInteger UnkNowflag;
@property (nonatomic, assign) NSInteger againFlag;
@property (nonatomic, assign) float allOffset;

@property (nonatomic, strong) NSMutableArray *storiesTitle;
@property (nonatomic, strong) NSMutableArray *storiesUrl;
@property (nonatomic, strong) NSMutableArray *storiesHint;
@property (nonatomic, strong) NSMutableArray *storiesImages;
@property (nonatomic, strong) NSMutableArray *storiesId;

@property (nonatomic, strong) NSMutableArray *top_storiesTitle;
@property (nonatomic, strong) NSMutableArray *top_storiesUrl;
@property (nonatomic, strong) NSMutableArray *top_storiesHint;
@property (nonatomic, strong) NSMutableArray *top_storiesId;
@property (nonatomic, strong) UIImage *top_storiesIamge;

@property (nonatomic, strong) NSMutableArray *temporaryArray;
@property (nonatomic, strong) NSMutableArray *allNetworkData;
@property (nonatomic, strong) NSMutableArray *allTopNetworkData;
@property (nonatomic, strong) NSMutableArray *allTransURL;
@property (nonatomic, strong) NSMutableArray *allTransID;
@property (nonatomic, strong) NSMutableArray *allRollButton;
@property (nonatomic, assign) NSInteger rollLocation;

//假导航栏
@property (nonatomic, strong) UIButton *flaseButton;
@property (nonatomic, strong) UILabel *flaseLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *lineLabel;

//
@property (nonatomic, strong) UIActivityIndicatorView* flashView;
@property (nonatomic, assign) NSInteger networkFlag;

- (void)creatFalseView;

@end

NS_ASSUME_NONNULL_END
