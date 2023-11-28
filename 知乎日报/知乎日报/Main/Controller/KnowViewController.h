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

@property (nonatomic, strong) NSString *monthString;
@property (nonatomic, strong) NetworkJSONModel *getJSONModel;
@property (nonatomic, strong) NSDictionary *dictionaryModel;
@property (nonatomic, strong) OldNetworkJSONModel *getOldJSONModel;

@property (nonatomic, strong) NSDateFormatter *getFormatter; //用于在 NSDate 对象与字符串之间进行相互转换
@property (nonatomic, strong) NSDate *getDate;
@property (nonatomic, strong) NSString *getString;
@property (nonatomic, strong) NSMutableDictionary *getDictionary;

@property (nonatomic, strong) UIScrollView *viewScrollView;
@property (nonatomic, strong) NSMutableArray *allTransURL;
@property (nonatomic, strong) NSMutableArray *allTransID;
@property (nonatomic, assign) NSInteger atLocation;
//@property (nonatomic, strong) WKWebView *URLWebView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) NSMutableArray *goodArray;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) NSMutableArray *allNetworkData;
@property (nonatomic, strong) NSMutableArray *temporaryArray;
@property (nonatomic, strong) NSMutableArray *allTransDataArray;

@property (nonatomic, strong) NSDictionary *longDictionary;
@property (nonatomic, strong) NSDictionary *shortDictionary;

@property (nonatomic, assign) int a;

//转换月份
- (NSString *)changMonth:(NSString*)string;

- (void)createDataBase; //创建数据库
- (void)insertData; //插入数据
- (void)updataData; //更新数据
- (void)deleteData; //删除数据
- (void)queryData;  //查询数据


@end

NS_ASSUME_NONNULL_END
