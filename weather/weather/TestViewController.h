//
//  TestViewController.h
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import <UIKit/UIKit.h>
#import "ShowTableViewCell.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface TestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *maxString;
@property (nonatomic, copy) NSString *minString;
@property (nonatomic, copy) NSString *nowString;
@property (nonatomic, copy) NSString *weaString;
//小时天气
@property (nonatomic, strong) NSMutableArray *weaArray;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *weaLabel;
//周天气
@property (nonatomic, strong) NSMutableArray *weakDayArray;
@property (nonatomic, strong) NSMutableArray *weekImageArray;
@property (nonatomic, strong) NSMutableArray *weekmaxArray;
@property (nonatomic, strong) NSMutableArray *weakminArray;
//天气质量
@property (nonatomic, copy) NSString *airQuality;
@property (nonatomic, strong) NSMutableArray *endArray;
@property (nonatomic, strong) NSMutableArray *informationArray;

@property (nonatomic, strong) NSMutableArray *allInformationArray;

@end

NS_ASSUME_NONNULL_END
