//
//  ColletcViewController.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <UIKit/UIKit.h>
#import "Webkit/WebKit.h"
#import "FMDB.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ColletcViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *temporaryArray;
@property (nonatomic, strong) NSMutableArray *allTransDataArray;
@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, strong) UIScrollView *viewScrollView;
@property (nonatomic, strong) WKWebView *URLWebView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) NSTimer *stopTimer;
@property (nonatomic, strong) UIAlertController *alertView;

@property (nonatomic, strong) NSDictionary *longDictionary;
@property (nonatomic, strong) NSDictionary *shortDictionary;
@property (nonatomic, assign) int a;


@end

NS_ASSUME_NONNULL_END
