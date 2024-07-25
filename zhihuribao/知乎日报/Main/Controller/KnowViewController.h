//
//  KnowViewController.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/17.
//

#import <UIKit/UIKit.h>
#import "KnowView.h"
#import "Masonry.h"
#import "NetworkJSONModel.h"
#import "OldNetworkJSONModel.h"
#import <WebKit/WebKit.h> //WKWebView库
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowViewController : UIViewController<UIScrollViewDelegate, UIWebViewDelegate, WKUIDelegate>

@property (nonatomic, copy) NSString *monthString; //存储date字符串信息：20231211
@property (nonatomic, copy) NetworkJSONModel *getJSONModel; //获取JSONModel数据的属性
@property (nonatomic, copy) NSDictionary *dictionaryModel;  //将请求下来的数据，转换为字典型数据
//里面有 1.日期date，2.下面内容二维数组，3.顶部滚动视图二维数组
@property (nonatomic, copy) OldNetworkJSONModel *getOldJSONModel;//获取OldJSONModel数据的属性
@property (nonatomic, copy) NSDateFormatter *getFormatter; //转换日期格式
@property (nonatomic, copy) NSDate *getDate;   //获取当前日期
@property (nonatomic, copy) NSString *getString;  //存储date字符串信息：20231211
@property (nonatomic, strong) NSMutableDictionary *getDictionary;

@property (nonatomic, strong) UIScrollView *viewScrollView; //点进网页里面的横向scrollView
@property (nonatomic, strong) NSMutableArray *allTransURL;   //接收传过来的所有的URL
@property (nonatomic, strong) NSMutableArray *allTransID;   //存储所有的ID
@property (nonatomic, assign) NSInteger atLocation;   //当前URL位置

//下面是WebView里面的内容
@property (nonatomic, strong) WKWebView *URLWebView; //WebView
@property (nonatomic, strong) UIView *bottomView;    //WebView里面的底部视图
@property (nonatomic, strong) UIButton *backButton;  //WebView里面的返回按钮
@property (nonatomic, strong) UILabel *lineLabel;    //WebView里面的竖划线
@property (nonatomic, strong) NSMutableArray *goodArray;   //点赞状态数组
@property (nonatomic, strong) UIButton *goodButton;   //点赞按钮
@property (nonatomic, strong) UIButton *messageButton; //评论按钮
@property (nonatomic, strong) NSMutableArray *collectionArray;  //收藏状态数组
@property (nonatomic, strong) UIButton *collectionButton; //收藏按钮
@property (nonatomic, strong) UIButton *shareButton;  //分享按钮

@property (nonatomic, strong) NSMutableArray *allNetworkData;  //存储所有的字典型数据
@property (nonatomic, strong) NSMutableArray *temporaryArray;   //临时存储数据
@property (nonatomic, strong) NSMutableArray *allTransDataArray;  //收藏传输的数据

@property (nonatomic, strong) NSDictionary *longDictionary;
@property (nonatomic, strong) NSDictionary *shortDictionary;

@property (nonatomic, assign) int a;

//转化月份
- (NSString *)changMonth:(NSString*)string;

- (void)createDataBase;   //创建数据库
- (void)insertData;  //插入数据
- (void)updateData;  //更新数据
- (void)deleteData;  //删除数据
- (void)queryData;   //查询数据

@end

NS_ASSUME_NONNULL_END
