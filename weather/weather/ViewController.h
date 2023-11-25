//
//  ViewController.h
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "MainTableViewCell.h"
#import "ShowViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;
//第一个界面的时间，名字，温度的数组
@property (nonatomic, strong) NSMutableArray *temperatureNowArray;
@property (nonatomic, strong) NSMutableArray *nameNowArray;
@property (nonatomic, strong) NSMutableArray *timeNowArray;

@property (nonatomic, strong) NSString *cityName;
//一个城市的所有信息
@property (nonatomic, strong) NSMutableArray *oneData;

//后面的所有内容，都是为了传给oneData
//最大温度，最小温度，当前温度，天气
@property (nonatomic, copy) NSString *maxString;
@property (nonatomic, copy) NSString *minString;
@property (nonatomic, copy) NSString *nowString;
@property (nonatomic, copy) NSString *weaString;
//每小时，的温度，时间，天气图标 数组
@property (nonatomic, strong) NSMutableArray *weaArray;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *weaLabel;
//每周的，星期几，天气图标，最大温度，最小温度
@property (nonatomic, strong) NSMutableArray *weakDayArray;
@property (nonatomic, strong) NSMutableArray *weakImageArray;
@property (nonatomic, strong) NSMutableArray *weakmaxArray;
@property (nonatomic, strong) NSMutableArray *weakminArray;
//提示信息只需要，当前天气，最高温，最低温即可，不需要多的属性

//空气质量
@property (nonatomic, copy)  NSString *airQuality;
//存放最后的 日出，日落，能见度 等标题的数组
@property (nonatomic, strong) NSMutableArray *endArray;
//存放最后的 日出，日落，能见度 中的内容的数组
@property (nonatomic, strong) NSMutableArray *informationArray;

//存放oneData的数组，相当于数组的内容存的是数组
@property (nonatomic, strong) NSMutableArray *allInformationArray;

@end

