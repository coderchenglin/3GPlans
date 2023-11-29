//
//  KnowViewController.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import <UIKit/UIKit.h>
#import "KnowView.h"
#import "Masonry.h"
#import "NetworkJSONModel.h"
#import "OldNetworkJSONModel.h"
//#import <WebKit/WebKit.h>
#import "FMDB.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface KnowViewController : UIViewController

@property (nonatomic, strong) NSString *monthString;//存储月份的字符串
@property (nonatomic, strong) NetworkJSONModel *getJSONModel;//存储网络请求返回的JSON模型对象
@property (nonatomic, strong) NSDictionary *dictionaryModel;//存储网络请求返回的字典型数据
//@property (nonatomic, strong) OldNetworkJSONModel *getOldJSONModel;//存储旧网络请求返回的JSON模型对象

//@property (nonatomic, strong) NSDateFormatter *getFormatter; //用于在 NSDate 对象与字符串之间进行相互转换
//@property (nonatomic, strong) NSDate *getDate;//存储日期对象
//@property (nonatomic, strong) NSString *getString;//存储日期的字符串表示
//@property (nonatomic, strong) NSMutableDictionary *getDictionary;//存储字典型数据

@property (nonatomic, strong) UIScrollView *viewScrollView;//滚动视图
@property (nonatomic, strong) NSMutableArray *allTransURL;//存储传递过来的所有URL
@property (nonatomic, strong) NSMutableArray *allTransID;//存储传递过来的所有ID
//@property (nonatomic, assign) NSInteger atLocation;//当前URL的位置
////@property (nonatomic, strong) WKWebView *URLWebView; //用于加载和显示网页
//@property (nonatomic, strong) UIView *bottomView;//底部视图，包含各种操作按钮
//@property (nonatomic, strong) UIButton *backButton;//返回按钮
//@property (nonatomic, strong) UILabel *lineLabel;//用于显示分割线的标签
//@property (nonatomic, strong) NSMutableArray *goodArray;//存储点赞状态的数组
//@property (nonatomic, strong) UIButton *goodButton;//点赞按钮
//
//@property (nonatomic, strong) UIButton *messageButton;//消息按钮
//
//@property (nonatomic, strong) NSMutableArray *collectionArray;//存储收藏状态的数组
//@property (nonatomic, strong) UIButton *collectionButton;//收藏按钮
//@property (nonatomic, strong) UIButton *shareButton;//分享按钮
//
@property (nonatomic, strong) NSMutableArray *allNetworkData;//存储所有的字典型数据的数组
//@property (nonatomic, strong) NSMutableArray *temporaryArray;//临时存储数据的数组
//@property (nonatomic, strong) NSMutableArray *allTransDataArray;//存储收藏传输的数据的数组
//
//@property (nonatomic, strong) NSDictionary *longDictionary;//存储长文章数据的字典
//@property (nonatomic, strong) NSDictionary *shortDictionary;//存储段文章数据的字典
//
//@property (nonatomic, assign) int a; //用于判断某些异步操作完成的计数器
//
////转换月份
//- (NSString *)changMonth:(NSString*)string;
//
//- (void)createDataBase; //创建数据库
//- (void)insertData; //插入数据
//- (void)updataData; //更新数据
//- (void)deleteData; //删除数据
//- (void)queryData;  //查询数据


@end

NS_ASSUME_NONNULL_END
