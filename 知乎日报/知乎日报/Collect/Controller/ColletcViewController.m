//
//  ColletcViewController.m
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import "ColletcViewController.h"
#import "CollectView.h"
#import "ShortModel.h" //短评
#import "LongModel.h"  //长评
#import "MessageViewController.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface CollectViewController ()

@property (nonatomic, strong) CollectView *collectView;
@property (nonatomic, strong) MessageViewController *messageView;
@property (nonatomic, strong) FMDatabase *collectionDatabase; //数据库

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDataBase]; //创建数据库
    self.view.backgroundColor = [UIColor systemGray6Color];
    [self creatUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"collectPost" object:nil];
    //由下面的pressMessage方法传过来的通知
}

//使用动画的方式隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


//
- (void)creatUI {
    //CollectView传值过来，传了一个当前点击cell的row值，也是index值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongZhi:) name:@"TongWangZhiWang" object:nil];
    //下拉刷新传的通知过来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAlert:) name:@"ActionStart" object:nil];
    
    self.collectView = [[CollectView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.allTransDataArray forKey:@"transData"];
    //发送通知给CollectView，传值allTransDataArray
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransALLDataNoti" object:nil userInfo:dic];
    
    [self.collectView.backButton addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectView];
}

//CollectView里面新闻cell点击事件的方法 *
- (void)tongZhi:(NSNotification *)sender {
    
    NSInteger index = [sender.userInfo[@"index"] intValue]; //当前点击cell的index值
    
    self.viewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    self.viewScrollView.contentSize = CGSizeMake(myWidth * self.allTransDataArray.count, myHeight);
    self.viewScrollView.backgroundColor = [UIColor whiteColor];
    self.viewScrollView.pagingEnabled = YES;
    self.viewScrollView.showsHorizontalScrollIndicator = NO;
    self.viewScrollView.showsVerticalScrollIndicator = NO;
    self.viewScrollView.delegate = self;
    self.viewScrollView.tag = 1111;
    [self.view addSubview:self.viewScrollView];
    
    for (int i = 0; i < self.allTransDataArray.count; i++) {
        
        //初始化网络界面WebView
        self.URLWebView = [[WKWebView alloc] initWithFrame:CGRectMake(myWidth * i, myWidth / 13, myWidth, myHeight / 1.11)];
        self.URLWebView.tag = 1000 + i;
        self.URLWebView.UIDelegate = self;
        [self.URLWebView canGoBack];
        [self.viewScrollView addSubview:self.URLWebView];
        
        NSURL *nowURL = [NSURL URLWithString:self.allTransDataArray[i][3]];//URL
        NSURLRequest *nowRequest = [NSURLRequest requestWithURL:nowURL];
        [self.URLWebView loadRequest:nowRequest];//加载网页
        
        //底部视图
        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = CGRectMake(myWidth * i, myWidth / 13 + myHeight / 1.11, myWidth, myHeight - myWidth / 13 - myHeight / 1.11);
        self.bottomView.backgroundColor = [UIColor systemGray6Color];
        [self.viewScrollView addSubview:self.bottomView];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside]; //底部视图里的返回按钮
        self.backButton.tag = 10000 + i;
        [self.bottomView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 15);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = [UIColor systemGrayColor];
        self.lineLabel.text = @"";
        [self.bottomView addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(myWidth / 55);
            make.left.equalTo(self.bottomView).offset(myWidth / 6);
            make.width.equalTo(@2);
            make.height.equalTo(@(myWidth / 13));
        }];
        
        self.goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goodButton setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        [self.goodButton setImage:[UIImage imageNamed:@"dianzan-2.png"] forState:UIControlStateSelected];
        if ([self.allTransDataArray[i][6] isEqualToString:@"1"]) {
            self.goodButton.selected = YES;
        } else {
            self.goodButton.selected = NO;
        }
        self.goodButton.tag = i;
        [self.goodButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.goodButton];
        [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 4);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
        
        self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.messageButton setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
        self.messageButton.tag = 10 + i;
        [self.messageButton addTarget:self action:@selector(pressMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.messageButton];
        [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 2.3);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.collectionButton setImage:[UIImage imageNamed:@"shoucang-3.png"] forState:UIControlStateNormal];
        [self.collectionButton setImage:[UIImage imageNamed:@"shoucang-2.png"] forState:UIControlStateSelected];
        if ([self.allTransDataArray[i][7] isEqualToString:@"1"]) {
            self.collectionButton.selected = YES;
        } else {
            self.collectionButton.selected = NO;
        }
        self.collectionButton.tag = 100 + i;
        [self.collectionButton addTarget:self action:@selector(pressCollection:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.collectionButton];
        [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 1.6);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareButton setImage:[UIImage imageNamed:@"fenxiang.png"] forState:UIControlStateNormal];
        self.shareButton.tag = 1000 + i;
        [self.shareButton addTarget:self action:@selector(pressShare:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 1.23);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
    }
    
    [self.viewScrollView setContentOffset:CGPointMake(myWidth * index, 0) animated:NO];
}

//点赞按钮 *
- (void)pressGood:(UIButton *)button {
    if (button.selected) {
        //取消点赞
        button.selected = NO;
        self.temporaryArray = [[NSMutableArray alloc] init];
        self.temporaryArray = self.allTransDataArray[button.tag];
        [self.temporaryArray replaceObjectAtIndex:6 withObject:@"0"]; //改变当前的点赞状态为0
        [self.allTransDataArray replaceObjectAtIndex:button.tag withObject:self.temporaryArray];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%@", self.allTransDataArray[button.tag][5]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"good" forKey:@"Judge"];
        [dic setObject:locationString forKey:@"Location"];
        [dic setObject:@"0" forKey:@"ChangeValue"];
        //传通知给KnowViewController，传过去的内容包括：点击的是点赞还是收藏，location索引，点击后ChangeValue值
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FavoriteClickEvents" object:nil userInfo:dic];
    } else {
        //点赞
        button.selected = YES;
        self.temporaryArray = [[NSMutableArray alloc] init];
        self.temporaryArray = self.allTransDataArray[button.tag];
        [self.temporaryArray replaceObjectAtIndex:6 withObject:@"1"];
        [self.allTransDataArray replaceObjectAtIndex:button.tag withObject:self.temporaryArray];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%@", self.allTransDataArray[button.tag][5]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"good" forKey:@"Judge"];
        [dic setObject:locationString forKey:@"Location"];
        [dic setObject:@"1" forKey:@"ChangeValue"];
        //传通知给KnowViewController，传值有：1.good状态
        //2.当前位置 3.ChangValue值
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FavoriteClickEvents" object:nil userInfo:dic];
    }
    [self deleteData];
    [self insertData];
}

//点击评论
- (void)pressMessage:(UIButton *)button {
    LongModel *getLongData = [LongModel shareLongModel];
    getLongData.LongID = self.allTransDataArray[button.tag - 10][8];
    ShortModel *getShortData = [ShortModel shareShortModel];
    getShortData.shortID = self.allTransDataArray[button.tag - 10][8];

    self.messageView = [[MessageViewController alloc] init];

    [[LongModel shareLongModel] NetworkGetLongData:^(LongJSONModel * _Nullable longModel) {
        self.longDictionary = [longModel toDictionary];

        if (self.longDictionary) {
            self.messageView.longDictionary = self.longDictionary;

            self->_a++;
            if (self->_a == 2) {
                self->_a = 0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"collectPost" object:nil];
            }
        }

    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败");
    }];

    [[ShortModel shareShortModel] NetworkGetShortData:^(ShortJSONModel * _Nullable shortModel) {
        self.shortDictionary = [shortModel toDictionary];

        if (self.shortDictionary) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageView.shortDictionary = self.shortDictionary;
                self->_a++;
                if (self->_a == 2) {
                    self->_a = 0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectPost" object:nil];
                }
            });
        }

    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败");
    }];

}

//收藏按钮 *
- (void)pressCollection:(UIButton *)button {
    if (button.selected) {
        //取消收藏
        button.selected = NO;
        self.temporaryArray = [[NSMutableArray alloc] init];
        self.temporaryArray = self.allTransDataArray[button.tag - 100];
        [self.temporaryArray replaceObjectAtIndex:7 withObject:@"0"];
        [self.allTransDataArray replaceObjectAtIndex:button.tag - 100 withObject:self.temporaryArray];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%@", self.allTransDataArray[button.tag - 100][5]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"collection" forKey:@"Judge"];
        [dic setObject:locationString forKey:@"Location"];
        [dic setObject:@"0" forKey:@"ChangeValue"];
        //与点赞按钮的通知完全相同
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FavoriteClickEvents" object:nil userInfo:dic];
    } else {
        //点击收藏
        button.selected = YES;
        self.temporaryArray = [[NSMutableArray alloc] init];
        self.temporaryArray = self.allTransDataArray[button.tag - 100];
        [self.temporaryArray replaceObjectAtIndex:7 withObject:@"1"];
        [self.allTransDataArray replaceObjectAtIndex:button.tag - 100 withObject:self.temporaryArray];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%@", self.allTransDataArray[button.tag - 100][5]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"collection" forKey:@"Judge"];//传过去告知KnowViewController，我点的是点赞按钮还是收藏按钮
        [dic setObject:locationString forKey:@"Location"];
        [dic setObject:@"1" forKey:@"ChangeValue"];
        //与点赞按钮的通知完全相同
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FavoriteClickEvents" object:nil userInfo:dic];
    }
    [self deleteData];
    [self insertData];
}

//分享按钮 *
- (void)pressShare:(UIButton *)button {
    NSLog(@"Share");
}

//底部视图里的返回按钮 *
- (void)backView:(UIButton *)button {
    [self.viewScrollView removeFromSuperview];
    
    int i = 0;
    while (i < self.allTransDataArray.count) {
        if ([self.allTransDataArray[i][7] isEqualToString:@"0"]) {
            [self.allTransDataArray removeObjectAtIndex:i];
        } else {
            i++;
        }
    }
    [self deleteData];
    [self insertData];
    [self.collectView reloadInputViews]; //用于重新加载输入视图（input views）的方法
}

// 收藏界面的返回按钮*
- (void)pressBackButton:(UIButton *)button {
    [self deleteData]; //删除数据库内容
    [self insertData]; //用新的allTransDataArray构造数据库内容
    //弹出当前界面
    [self.navigationController popViewControllerAnimated:YES];
}

// *
- (void)stopAlert:(NSNotification *)sender {
    self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopTips) userInfo:@"帅哥哥" repeats:NO]; //等1秒后执行stopTips方法
    self.alertView = [UIAlertController alertControllerWithTitle:nil message:@"数据更新完成" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:self.alertView animated:YES completion:nil];
}
// *
- (void)stopTips {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.stopTimer invalidate];
    self.stopTimer = nil;
}

//通知方法：推出MessageView *
- (void)push {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:self.messageView animated:YES];
    });
}
//消除通知 *
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//构建数据库 *
- (void)createDataBase {
    self.collectionDatabase = [FMDatabase databaseWithPath:self.fileName];
    [self queryData];
}

//打印数据库 *
- (void)queryData {
    if ([self.collectionDatabase open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([resultSet next]) {
            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];
            NSLog(@"mainLabel = %@",mainLabel);
            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
            NSLog(@"nameLabel = %@",nameLabel);
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            NSLog(@"imageURL = %@",imageURL);
            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
            NSLog(@"networkURL = %@",networkURL);
            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];
            NSLog(@"dateLabel = %@",dateLabel);
            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
            NSLog(@"nowLocation = %@",nowLocation);
            NSString *goodState = [resultSet stringForColumn:@"goodState"];
            NSLog(@"goodState = %@",goodState);
            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
            NSLog(@"collectionState = %@",collectionState);
            NSString *id = [resultSet stringForColumn:@"id"];
            NSLog(@"id = %@",id);
        }
        [self.collectionDatabase close];
    }
}

// 删除数据 *
- (void)deleteData {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"delete from collectionData";
        BOOL result = [self.collectionDatabase executeUpdate:sql];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDatabase close];
    }
}

//插入数据 *
- (void)insertData {
    if ([self.collectionDatabase open]) {
        for (int i = 0; i < self.allTransDataArray.count; i++) {
            NSInteger numResult = 0;
            NSInteger enterResult = 0;
            FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
            while ([resultSet next]) {
                NSString *id = [resultSet stringForColumn:@"id"];
                if (![self.allTransDataArray[i][8] isEqualToString:id]) {
                    enterResult++;
                }
                numResult++;
            }
            //两个相等代表没有重复的
            if (enterResult == numResult) {
                BOOL result = [self.collectionDatabase executeUpdate:@"INSERT INTO collectionData (mainLabel, nameLabel, imageURL, networkURL, dateLabel, nowLocation, goodState, collectionState, id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);", self.allTransDataArray[i][0], self.allTransDataArray[i][1], self.allTransDataArray[i][2], self.allTransDataArray[i][3], self.allTransDataArray[i][4], self.allTransDataArray[i][5], self.allTransDataArray[i][6], self.allTransDataArray[i][7], self.allTransDataArray[i][8]];
                if (!result) {
                    NSLog(@"增加数据失败");
                }else{
                    NSLog(@"增加数据成功");
                }
            }
        }
        [self.collectionDatabase close];
    }
    [self queryData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
