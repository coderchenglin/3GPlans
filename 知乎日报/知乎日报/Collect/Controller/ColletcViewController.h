//
//  ColletcViewController.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectViewController : UIViewController<WKUIDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *temporaryArray;   //临时存储数据
@property (nonatomic, strong) NSMutableArray *allTransDataArray; //接受CollectViewController传过来的网络上请求的数据
@property (nonatomic, copy) NSString *fileName;  //数据库路径

//点进去以后：
//横向的一个ScrollView
@property (nonatomic, strong) UIScrollView *viewScrollView;
//点进去是一个网页
@property (nonatomic, strong) WKWebView *URLWebView;
//底端的导航栏
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) NSTimer *stopTimer;
@property (nonatomic, strong) UIAlertController *alertView;

@property (nonatomic, strong) NSDictionary *longDictionary; //长评的字典
@property (nonatomic, strong) NSDictionary *shortDictionary;//短评的字典
@property (nonatomic, assign) int a;

@end

NS_ASSUME_NONNULL_END
