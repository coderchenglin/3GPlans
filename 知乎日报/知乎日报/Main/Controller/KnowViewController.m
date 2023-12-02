//
//  KnowViewController.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.


#import "KnowViewController.h"
#import "NetworkModel.h"
#import "OldNetworkModel.h"
#import "LongModel.h"


@interface KnowViewController ()

@property (nonatomic, strong) KnowView *addKnowView;


@property (nonatomic, strong) FMDatabase *collectionDatabase;  //数据库
@property (nonatomic, copy) NSString *fileName; //数据库路径

@end

@implementation KnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createDataBase];
    [self judgeDataBaseData];

    self.view.backgroundColor = [UIColor whiteColor];
    self.monthString = [[NSString alloc] init];
    self.getString = [[NSString alloc] init];
    self.goodArray = [[NSMutableArray alloc] init];
    self.collectionArray = [[NSMutableArray alloc] init];
    self.allNetworkData = [[NSMutableArray alloc] init];
    self.allTransDataArray = [[NSMutableArray alloc] init];
    self.temporaryArray = [[NSMutableArray alloc] init];
    self.a = 0;

    //url通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUrl:) name:@"transUrl" object:nil]; //接受view传过来的用于访问web的信息
    //showUrl：方法，主要实现了展示多个网页，并使用通知传值传过来的数据，对新的WKWebView提供数据
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"post" object:nil];
    //push方法实现了在主线程异步调用的方式，将self.messageView推入导航栏控制器的堆栈中，以此来进行页面切换
    [self GetNetworkModel];
    [self getDataFromDataBase];
    [self arrayState];

}

//push方法实现了在主线程异步调用的方式，将self.messageView推入导航栏控制器的堆栈中，以此来进行页面切换
- (void)push {

}

//showUrl：方法，主要实现了展示多个网页，并使用通知传值传过来的数据，对新的WKWebView提供数据
- (void)showUrl:(NSNotification *)sender {
    self.allTransURL = sender.userInfo[@"url"];
    self.allTransID = sender.userInfo[@"id"];
    self.atLocation = [sender.userInfo[@"location"] intValue];
    self.allNetworkData = sender.userInfo[@"allData"];
    
    self.viewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    self.viewScrollView.contentSize = CGSizeMake(myWidth * self.allTransURL.count, myHeight); //传过来多少个URL，宽度就是多少
    self.viewScrollView.backgroundColor = [UIColor whiteColor];
    self.viewScrollView.pagingEnabled = YES;
    self.viewScrollView.showsVerticalScrollIndicator = NO;
    self.viewScrollView.showsHorizontalScrollIndicator = NO;
    self.viewScrollView.delegate = self;
    self.viewScrollView.tag = 1111;
    [self.view addSubview:self.viewScrollView];
    
    //初始化 self.goodArray 和 self.collectionArray 数组，确保它们的元素数量与 self.allTransURL 数组相同。
    if (self.goodArray.count != self.allTransURL.count) {
        for (NSInteger i = self.goodArray.count; i < self.allTransURL.count; i++) {
            for (int j = 0; j < self.allTransDataArray.count; j++) {
                if (i == [self.allTransDataArray[j][5] intValue]) {
                    [self.goodArray addObject:self.allTransDataArray[j][6]];
                    [self.collectionArray addObject:self.allTransDataArray[j][7]];
                    continue;
                }
            }
            [self.goodArray addObject:@"0"];
            [self.collectionArray addObject:@"0"];
        }
    }
    
    for (int i = 0; i < self.allTransURL.count; i++) {
        
        //初始化网络界面WebView
        self.URLWebView = [[WKWebView alloc] initWithFrame:CGRectMake(myWidth * i, myWidth / 13, myWidth, myHeight / 1.11)];
        self.URLWebView.tag = 1000 + i;
        self.URLWebView.UIDelegate = self;
        [self.URLWebView canGoBack];  //这里会返回一个BOOL值，表示是否有可以返回的界面
        [self.viewScrollView addSubview:self.URLWebView];
        
        NSURL *nowURL = [NSURL URLWithString:self.allTransURL[i]];
        NSURLRequest *nowRequest = [NSURLRequest requestWithURL:nowURL];
        [self.URLWebView loadRequest:nowRequest];
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = CGRectMake(myWidth * i, myWidth / 13 + myHeight / 1.11, myWidth, myHeight - myWidth / 13 - myHeight / 1.11);
        self.bottomView.backgroundColor = [UIColor systemGray6Color];
        [self.viewScrollView addSubview:self.bottomView];
        
        //返回按钮
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
        self.backButton.tag = 10000 + i;
        [self.bottomView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(myWidth / 15);
            make.top.equalTo(self.bottomView).offset(myWidth / 40);
            make.size.offset(myWidth / 15);
        }];
        
        //分隔线
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
        if ([self.goodArray[i] isEqualToString:@"0"]) {
            self.goodButton.selected = NO;
        } else {
            self.goodButton.selected = YES;
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
        if ([self.collectionArray[i] isEqualToString:@"0"]) {   //判断收藏按钮的状态
            self.collectionButton.selected = NO;
        } else {
            self.collectionButton.selected = YES;
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
    
    [self.viewScrollView setContentOffset:CGPointMake(myWidth * self.atLocation, 0) animated:NO];
}

- (void)pressGood:(UIButton*)button {
    if (button.selected) {
        button.selected = NO;
        [self.goodArray replaceObjectAtIndex:button.tag withObject:@"0"];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%ld", (long)button.tag];
        if (self.allTransDataArray != nil) {
            for (int i = 0; i < self.allTransDataArray.count; i++) {
                if ([self.allTransDataArray[i][5] isEqualToString:locationString]) {
                    
                    self.temporaryArray = [[NSMutableArray alloc] init];
                    self.temporaryArray = self.allTransDataArray[i];
                    [self.temporaryArray replaceObjectAtIndex:6 withObject:@"0"];
                    [self.allTransDataArray replaceObjectAtIndex:i withObject:self.temporaryArray];
                }
            }
        }
    } else {
        button.selected = YES;
        [self.goodArray replaceObjectAtIndex:button.tag withObject:@"1"];
        
        NSString *locationString = [[NSString alloc] initWithFormat:@"%ld", (long)button.tag];
        if (self.allTransDataArray != nil) {
            for (int i = 0; i < self.allTransDataArray.count; i++) {
                if ([self.allTransDataArray[i][5] isEqualToString:locationString]) {
                    
                    self.temporaryArray = [[NSMutableArray alloc] init];
                    self.temporaryArray = self.allTransDataArray[i];
                    [self.temporaryArray replaceObjectAtIndex:6 withObject:@"1"];
                    [self.allTransDataArray replaceObjectAtIndex:i withObject:self.temporaryArray];
                }
            }
        }
    }
    [self deleteData];
    [self insertData];
}

- (void)pressCollection:(UIButton *)button {
    
    if (button.selected) {
        button.selected = NO;
        [self.collectionArray replaceObjectAtIndex:button.tag - 100 withObject:@"0"];
        NSInteger nowAt = button.tag - 100;
        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
        for (int i = 0; i < self.allTransDataArray.count; i++) {
            if ([nowAtString isEqualToString:self.allTransDataArray[i][5] ]) {
                [self.allTransDataArray removeObjectAtIndex:i];
                break;
            }
        }
        
    } else {
        button.selected = YES;
        [self.collectionArray replaceObjectAtIndex:button.tag - 100  withObject:@"1"];
        
        NSInteger nowAt = button.tag - 100;
        self.temporaryArray = [[NSMutableArray alloc] init];
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][0][nowAt % 6]]; //标题
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][1][nowAt % 6]]; //副标题
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][2][nowAt % 6]]; //图片
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][3][nowAt % 6]]; //URL
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][4]]; //日期
        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
        [self.temporaryArray addObject:nowAtString];
        [self.temporaryArray addObject:self.goodArray[nowAt]];
        [self.temporaryArray addObject:self.collectionArray[nowAt]];
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][5][nowAt % 6]]; //URL
        
        [self.allTransDataArray addObject:self.temporaryArray];
    }
    [self deleteData];
    [self insertData];
}

- (void)pressShare:(UIButton *)button {
    NSLog(@"share");
}

//- (void)pressMessage:(UIButton *)button {
//    LongModel *getLongData = [LongModel ]
//    
//}


- (void)backView:(UIButton *)button {
    [self.viewScrollView removeFromSuperview];
}



//用于添加用户界面元素，包括知识浏览视图 KnowView。
- (void)addUI {

    self.addKnowView = [[KnowView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(information:) name:@"returnInformation" object:nil];
    
    //收藏里的，点击事件通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickEvents:) name:@"FavoriteClickEvents" object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];

    //拿到今天多少号
    self.addKnowView.dayLabel.text = [self.monthString substringWithRange:NSMakeRange(6, 2)];
    //拿到今天多少月
    NSString *month = [self.monthString substringWithRange:NSMakeRange(4, 2)];
    self.addKnowView.monthLabel.text = [self changMonth:month];

    //添加头像点击事件
//    [self.addKnowView.flaseButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.addKnowView];
}

- (NSString *)changMonth:(NSString*)string {
    if ([string isEqualToString:@"01"]) {
        return @"一月";
    } else if ([string isEqualToString:@"02"]) {
        return @"二月";
    } else if ([string isEqualToString:@"03"]) {
        return @"三月";
    } else if ([string isEqualToString:@"04"]) {
        return @"四月";
    } else if ([string isEqualToString:@"05"]) {
        return @"五月";
    } else if ([string isEqualToString:@"06"]) {
        return @"六月";
    } else if ([string isEqualToString:@"07"]) {
        return @"七月";
    } else if ([string isEqualToString:@"08"]) {
        return @"八月";
    } else if ([string isEqualToString:@"09"]) {
        return @"九月";
    } else if ([string isEqualToString:@"10"]) {
        return @"十月";
    } else if ([string isEqualToString:@"11"]) {
        return @"十一月";
    } else {
        return @"十二月";
    }
}

//发起网络请求，获取新数据，并在请求完成后更新界面。
- (void)GetNetworkModel {

    [[NetworkModel shareNetworkModel] NetworkModelData:^(NetworkJSONModel * _Nullable networkModel) {

        self.monthString = [networkModel.date copy];//日期
        self.getString = [self.monthString copy];
        self.dictionaryModel = [networkModel toDictionary];

        dispatch_async(dispatch_get_main_queue(),^{
            [self addUI];
        });

    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败！");
    }];
}

- (void)information:(NSNotification *)sender {

    OldNetworkModel *manager = [OldNetworkModel shareOldNetworkModel];
    manager.nowDate = self.getString;

    [[OldNetworkModel shareOldNetworkModel] OldNetworkModelData:^(OldNetworkJSONModel * _Nullable oldNetworkModel) {

        //NSLog(@"%@", [oldNetworkModel toDictionary]);
        self.dictionaryModel = [oldNetworkModel toDictionary];

        if (self.dictionaryModel != nil) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getNewInformation];
            });
        } else {
            NSLog(@"获取失败！");
        }

    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败！");
        NSLog(@"%@",error.localizedDescription);
    }];

    self.getFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    self.getFormatter.dateFormat = @"yyyyMMdd";
    self.getDate = [self.getFormatter dateFromString:self.getString];

    //用当前日期获取一天前的日期
    //这个方法表示，从第二个参数开始，经过第一个参数的秒数。可以为负数，表示过去的时间
    self.getDate = [[NSDate alloc] initWithTimeInterval:-1 * 3600 * 24 sinceDate:self.getDate];
    self.getString = [self.getFormatter stringFromDate:self.getDate];
}

- (void)getNewInformation {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
}

//- (void)ClickEvents:(NSNotification*)sender {
//    NSInteger locationNow = [sender.userInfo[@"location"] intValue]; //获取要替换数组字符的位置
//    if ([sender.userInfo[@"Judge"] isEqualToString:@"good"]) {
//        [self.goodArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];
//        //替换相应位置的值
//    } else {
//        [self.collectionArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];
//    }
//}

//推出个人界面
- (void)changeView:(UIButton *)button {

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)arrayState {

    for (NSInteger i = self.goodArray.count; i < 6; i++) {
        //NSLog(@"%ld", self.goodArray.count);
        //NSLog(@"11");
        NSInteger judge = 0;
        for (int j = 0; j < self.allTransDataArray.count; j++) {
            //??
            if (i == [self.allTransDataArray[j][5] intValue]) {
                [self.goodArray addObject:self.allTransDataArray[j][6]];
                [self.collectionArray addObject:self.allTransDataArray[j][7]];
                judge = 1;
                break;
            }
        }
        //NSLog(@"%ld", self.goodArray.count);
        //NSLog(@"%ld", self.allTransDataArray);
        if (!judge) {
            [self.goodArray addObject:@"0"];
            [self.collectionArray addObject:@"0"];
        }
    }
}

//每次运行都清空数据库
- (void)judgeDataBaseData {
    if ([self.collectionDatabase open]) {

        NSString *sql = @"delete from collectionData WHERE collectionState = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql, @"0"];
        if(!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDatabase close];
    }

}

- (void)createDataBase {
    //获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", doc);
    self.fileName = [doc stringByAppendingPathComponent:@"collectionData.sqlite"]; //这是我自己指定的数据库名称

    //2.获得数据库
    self.collectionDatabase = [FMDatabase databaseWithPath:self.fileName];

    //3.打开数据库
    if ([self.collectionDatabase open]) {
        BOOL result = [self.collectionDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLable text NOT NULL, nameLabel text NOT NULL, imageURL text NOT NULL, networkURL text NOT NULL, dataLabel text NOT NULL, nowLocation text NOT NULL, goodState text NOT NULL, collectionState text NOT NULL, id text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
}

//插入数据
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
            
            //两个相等代表没有重复
            if (enterResult == numResult) {
                BOOL result = [self.collectionDatabase executeUpdate:@"INSERT INTO collectionData (mainLabel, nameLabel, imageURL, networkURL, dateLabel, nowLocation, goodState,collectionState, id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"];
                if (!result) {
                    NSLog(@"增加数据失败");
                } else {
                    NSLog(@"增加数据成功");
                }
            }
        }
        [self.collectionDatabase close];
    }
    [self queryData];
}

- (void)updateData {
    
    if ([self.collectionDatabase open]) {
        NSString *sql = @"UPDATE collectionData SET id = ? WHERE nameLabel = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql,@"1",@"hi world"];
        if (!result) {
            NSLog(@"数据修改失败");
        } else {
            NSLog(@"数据修改成功");
        }
        [self.collectionDatabase close];
    }
}

// 删除数据
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

// 查询数据
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


//这段代码实现了从数据库中获取数据的功能
- (void)getDataFromDataBase {
    if ([self.collectionDatabase open]) {
        //1.执行查询语句
        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        //2.遍历结果
        while ([resultSet next]) {
            self.temporaryArray = [[NSMutableArray alloc] init];

            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"]; //获取名为“mainLabel”的列的内容
            [self.temporaryArray addObject:mainLabel];
            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
            [self.temporaryArray addObject:nameLabel];
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            [self.temporaryArray addObject:imageURL];
            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
            [self.temporaryArray addObject:networkURL];
            NSString *dataLabel = [resultSet stringForColumn:@"dataLabel"];
            [self.temporaryArray addObject:dataLabel];
            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
            [self.temporaryArray addObject:nowLocation];
            NSString *goodState = [resultSet stringForColumn:@"goodState"];
            [self.temporaryArray addObject:goodState];
            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
            [self.temporaryArray addObject:collectionState];
            NSString *id = [resultSet stringForColumn:@"id"];
            [self.temporaryArray addObject:id];

            [self.allTransDataArray addObject:self.temporaryArray];
        }
        [self.collectionDatabase close];
    }
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















//
//#import "KnowViewController.h"
//#import "NetworkModel.h"
//#import "PersonViewController.h"
//#import "OldNetworkModel.h"
//#import "ShortModel.h"
//#import "LongModel.h"
//#import "MessageViewController.h"
//
//#define myWidth [UIScreen mainScreen].bounds.size.width
//#define myHeight [UIScreen mainScreen].bounds.size.height
//
//@interface KnowViewController ()
//
//@property (nonatomic, strong) KnowView *addKnowView;
//@property (nonatomic, strong) PersonViewController *personView;
//@property (nonatomic, strong) MessageViewController *messageView;
//
//@property (nonatomic, strong) FMDatabase *collectionDatabase; //数据库
//@property (nonatomic, copy) NSString *fileName;  //数据库路径
//
//@end
//
//@implementation KnowViewController
//
//
////视图加载完成时调用的方法，用于初始化数据和执行一些初始化操作
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    [self createDataBase];
//    [self judgeDataBaseData];
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.monthString = [[NSString alloc] init];
//    self.getString = [[NSString alloc] init];
//    self.goodArray = [[NSMutableArray alloc] init];
//    self.collectionArray = [[NSMutableArray alloc] init];
//    self.allNetworkData = [[NSMutableArray alloc] init];
//    self.allTransDataArray = [[NSMutableArray alloc] init];
//    self.temporaryArray = [[NSMutableArray alloc] init];
//    self.a = 0;
//
//    //url通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUrl:) name:@"transUrl" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"post" object:nil];
//    [self GetNetworkModel];
//    [self getDataFromDataBase];
//    [self arrayState];
//}
//
////使用动画的方式隐藏导航栏
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}
//
////用于初始化点赞和收藏的数组，确保数组的长度与数据源一致。
//- (void)arrayState {
//    for (NSInteger i = self.goodArray.count; i < 6; i++) {
//        NSInteger judge = 0;
//        for (int j = 0; j < self.allTransDataArray.count; j++) {
//            if (i == [self.allTransDataArray[j][5] intValue]) {
//                [self.goodArray addObject:self.allTransDataArray[j][6]];
//                [self.collectionArray addObject:self.allTransDataArray[j][7]];
//                judge = 1;
//                break;
//            }
//        }
//        if (!judge) {
//            [self.goodArray addObject:@"0"];
//            [self.collectionArray addObject:@"0"];
//        }
//    }
//}
//
////用于添加用户界面元素，包括知识浏览视图 KnowView。
//- (void)addUI {
//
//    self.addKnowView = [[KnowView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(information:) name:@"returnInformation" object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickEvents:) name:@"FavoriteClickEvents" object:nil];
//
//    //通知传值
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
//
//    self.addKnowView.dayLabel.text = [self.monthString substringWithRange:NSMakeRange(6, 2)];
//    NSString *month = [self.monthString substringWithRange:NSMakeRange(4, 2)];
//    self.addKnowView.monthLabel.text = [self changMonth:month];
//
//    [self.addKnowView.flaseButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:self.addKnowView];
//
//}
//
////发起网络请求，获取数据，并在请求完成后更新界面。
//- (void)GetNetworkModel {
//
//    [[NetworkModel shareNetworkModel] NetworkModelData:^(NetworkJSONModel * _Nullable networkModel) {
//
//        self.monthString = [networkModel.date copy];
//        self.getString = [self.monthString copy];
//        self.dictionaryModel = [networkModel toDictionary];
//
//        //回到主线程
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self addUI];
//        });
//
//    } andError:^(NSError * _Nullable error) {
//        NSLog(@"请求失败！");
//    }];
//}
//
////通过网络请求获取陈旧的数据。
//- (void)information:(NSNotification *)sender {
//
//    OldNetworkModel *manager = [OldNetworkModel shareOldNetworkModel];
//    manager.nowDate = self.getString;
//
//    [[OldNetworkModel shareOldNetworkModel] OldNetworkModelData:^(OldNetworkJSONModel * _Nullable oldNetworkModel) {
//
//        self.dictionaryModel = [oldNetworkModel toDictionary];
//
//        if (self.dictionaryModel != nil) {
//            //回到主线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self getNewInformation];
//            });
//        } else {
//            NSLog(@"获取失败！");
//        }
//
//    } andError:^(NSError * _Nullable error) {
//        NSLog(@"请求失败！");
//    }];
//
//    self.getFormatter = [[NSDateFormatter alloc] init];
//    //设置日期格式
//    self.getFormatter.dateFormat = @"yyyyMMdd";
//    self.getDate = [self.getFormatter dateFromString:self.getString];
//    //获取一天前的日期
//
//    self.getDate = [[NSDate alloc] initWithTimeInterval:-1 * 3600 * 24 sinceDate:self.getDate];
//    self.getString = [self.getFormatter stringFromDate:self.getDate];
//
//}
//
////获取新的数据，并通过通知机制传递给界面。
//- (void)getNewInformation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
//}
//
////转化月份
//- (NSString *)changMonth:(NSString*)string {
//    if ([string isEqualToString:@"01"]) {
//        return @"一月";
//    } else if ([string isEqualToString:@"02"]) {
//        return @"二月";
//    } else if ([string isEqualToString:@"03"]) {
//        return @"三月";
//    } else if ([string isEqualToString:@"04"]) {
//        return @"四月";
//    } else if ([string isEqualToString:@"05"]) {
//        return @"五月";
//    } else if ([string isEqualToString:@"06"]) {
//        return @"六月";
//    } else if ([string isEqualToString:@"07"]) {
//        return @"七月";
//    } else if ([string isEqualToString:@"08"]) {
//        return @"八月";
//    } else if ([string isEqualToString:@"09"]) {
//        return @"九月";
//    } else if ([string isEqualToString:@"10"]) {
//        return @"十月";
//    } else if ([string isEqualToString:@"11"]) {
//        return @"十一月";
//    } else {
//        return @"十二月";
//    }
//}
//
////展示网页内容，包括点赞、评论等按钮。
//- (void)showUrl:(NSNotification *)sender {
//    self.allTransURL = sender.userInfo[@"url"];
//    self.allTransID = sender.userInfo[@"id"];
//    self.atLocation = [sender.userInfo[@"location"] intValue];
//    self.allNetworkData = sender.userInfo[@"allData"];
//
//    self.viewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
//    self.viewScrollView.contentSize = CGSizeMake(myWidth * self.allTransURL.count, myHeight);
//    self.viewScrollView.backgroundColor = [UIColor whiteColor];
//    self.viewScrollView.pagingEnabled = YES;
//    self.viewScrollView.showsHorizontalScrollIndicator = NO;
//    self.viewScrollView.showsVerticalScrollIndicator = NO;
//    self.viewScrollView.delegate = self;
//    self.viewScrollView.tag = 1111;
//    [self.view addSubview:self.viewScrollView];
//
//    if (self.goodArray.count != self.allTransURL.count) {
//        for (NSInteger i = self.goodArray.count; i < self.allTransURL.count; i++) {
//            for (int j = 0; j < self.allTransDataArray.count; j++) {
//                if (i == [self.allTransDataArray[j][5] intValue]) {
//                    [self.goodArray addObject:self.allTransDataArray[j][6]];
//                    [self.collectionArray addObject:self.allTransDataArray[j][7]];
//                    continue;
//                }
//            }
//            [self.goodArray addObject:@"0"];
//            [self.collectionArray addObject:@"0"];
//        }
//    }
//
//    for (int i = 0; i < self.allTransURL.count; i++) {
//
//        //初始化网络界面WebView
//        self.URLWebView = [[WKWebView alloc] initWithFrame:CGRectMake(myWidth * i, myWidth / 13, myWidth, myHeight / 1.11)];
//        self.URLWebView.tag = 1000 + i;
//        self.URLWebView.UIDelegate = self;
//        [self.URLWebView canGoBack];
//        [self.viewScrollView addSubview:self.URLWebView];
//
//        NSURL *nowURL = [NSURL URLWithString:self.allTransURL[i]];
//        NSURLRequest *nowRequest = [NSURLRequest requestWithURL:nowURL];
//        [self.URLWebView loadRequest:nowRequest];
//
//        self.bottomView = [[UIView alloc] init];
//        self.bottomView.frame = CGRectMake(myWidth * i, myWidth / 13 + myHeight / 1.11, myWidth, myHeight - myWidth / 13 - myHeight / 1.11);
//        self.bottomView.backgroundColor = [UIColor systemGray6Color];
//        [self.viewScrollView addSubview:self.bottomView];
//
//        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
//        [self.backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
//        self.backButton.tag = 10000 + i;
//        [self.bottomView addSubview:self.backButton];
//        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bottomView).offset(myWidth / 15);
//            make.top.equalTo(self.bottomView).offset(myWidth / 40);
//            make.size.offset(myWidth / 15);
//        }];
//
//        self.lineLabel = [[UILabel alloc] init];
//        self.lineLabel.backgroundColor = [UIColor systemGrayColor];
//        self.lineLabel.text = @"";
//        [self.bottomView addSubview:self.lineLabel];
//        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.bottomView).offset(myWidth / 55);
//            make.left.equalTo(self.bottomView).offset(myWidth / 6);
//            make.width.equalTo(@2);
//            make.height.equalTo(@(myWidth / 13));
//        }];
//
//        self.goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.goodButton setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
//        [self.goodButton setImage:[UIImage imageNamed:@"dianzan-2.png"] forState:UIControlStateSelected];
//        if ([self.goodArray[i] isEqualToString:@"0"]) {  //判断点赞按钮的状态
//            self.goodButton.selected = NO;
//        } else {
//            self.goodButton.selected = YES;
//        }
//        self.goodButton.tag = i;
//        [self.goodButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bottomView addSubview:self.goodButton];
//        [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bottomView).offset(myWidth / 4);
//            make.top.equalTo(self.bottomView).offset(myWidth / 40);
//            make.size.offset(myWidth / 15);
//        }];
//
//        self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.messageButton setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
//        self.messageButton.tag = 10 + i;
//        [self.messageButton addTarget:self action:@selector(pressMessage:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bottomView addSubview:self.messageButton];
//        [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bottomView).offset(myWidth / 2.3);
//            make.top.equalTo(self.bottomView).offset(myWidth / 40);
//            make.size.offset(myWidth / 15);
//        }];
//
//        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.collectionButton setImage:[UIImage imageNamed:@"shoucang-3.png"] forState:UIControlStateNormal];
//        [self.collectionButton setImage:[UIImage imageNamed:@"shoucang-2.png"] forState:UIControlStateSelected];
//        if ([self.collectionArray[i] isEqualToString:@"0"]) {   //判断收藏按钮的状态
//            self.collectionButton.selected = NO;
//        } else {
//            self.collectionButton.selected = YES;
//        }
//        self.collectionButton.tag = 100 + i;
//        [self.collectionButton addTarget:self action:@selector(pressCollection:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bottomView addSubview:self.collectionButton];
//        [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bottomView).offset(myWidth / 1.6);
//            make.top.equalTo(self.bottomView).offset(myWidth / 40);
//            make.size.offset(myWidth / 15);
//        }];
//
//        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.shareButton setImage:[UIImage imageNamed:@"fenxiang.png"] forState:UIControlStateNormal];
//        self.shareButton.tag = 1000 + i;
//        [self.shareButton addTarget:self action:@selector(pressShare:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bottomView addSubview:self.shareButton];
//        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bottomView).offset(myWidth / 1.23);
//            make.top.equalTo(self.bottomView).offset(myWidth / 40);
//            make.size.offset(myWidth / 15);
//        }];
//    }
//
//    [self.viewScrollView setContentOffset:CGPointMake(myWidth * self.atLocation, 0) animated:NO];
//}
//
//- (void)pressGood:(UIButton *)button {
//    if (button.selected) {
//        button.selected = NO;
//        [self.goodArray replaceObjectAtIndex:button.tag withObject:@"0"];
//
//        NSString *locationString = [[NSString alloc] initWithFormat:@"%ld", (long)button.tag];
//        if (self.allTransDataArray != nil) {
//            for (int i = 0; i < self.allTransDataArray.count; i++) {
//                if ([self.allTransDataArray[i][5] isEqualToString:locationString]) {
//                    self.temporaryArray = [[NSMutableArray alloc] init];
//                    self.temporaryArray = self.allTransDataArray[i];
//                    [self.temporaryArray replaceObjectAtIndex:6 withObject:@"0"];
//                    [self.allTransDataArray replaceObjectAtIndex:i withObject:self.temporaryArray];
//                }
//            }
//        }
//    } else {
//        button.selected = YES;
//        [self.goodArray replaceObjectAtIndex:button.tag withObject:@"1"];
//
//        NSString *locationString = [[NSString alloc] initWithFormat:@"%ld", (long)button.tag];
//        if (self.allTransDataArray != nil) {
//            for (int i = 0; i < self.allTransDataArray.count; i++) {
//                if ([self.allTransDataArray[i][5] isEqualToString:locationString]) {
//                    self.temporaryArray = [[NSMutableArray alloc] init];
//                    self.temporaryArray = self.allTransDataArray[i];
//                    [self.temporaryArray replaceObjectAtIndex:6 withObject:@"1"];
//                    [self.allTransDataArray replaceObjectAtIndex:i withObject:self.temporaryArray];
//                }
//            }
//        }
//    }
//    [self deleteData];
//    [self insertData];
//}
////
//////评论界面
////- (void)pressMessage:(UIButton *)button {
////    LongModel *getLongData = [LongModel shareLongModel];
////    getLongData.LongID = self.allTransID[button.tag - 10];
////    ShortModel *getShortData = [ShortModel shareShortModel];
////    getShortData.shortID = self.allTransID[button.tag - 10];
////
////    self.messageView = [[MessageViewController alloc] init];
////
////    [[LongModel shareLongModel] NetworkGetLongData:^(LongJSONModel * _Nullable longModel) {
////        self.longDictionary = [longModel toDictionary];
////
////        if (self.longDictionary) {
////            self.messageView.longDictionary = self.longDictionary;
////
////            self->_a++;
////            if (self->_a == 2) {
////                self->_a = 0;
////                [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
////            }
////        }
////
////    } andError:^(NSError * _Nullable error) {
////        NSLog(@"请求失败");
////    }];
////
////    [[ShortModel shareShortModel] NetworkGetShortData:^(ShortJSONModel * _Nullable shortModel) {
////        self.shortDictionary = [shortModel toDictionary];
////
////        if (self.shortDictionary) {
////            dispatch_async(dispatch_get_main_queue(), ^{
////                self.messageView.shortDictionary = self.shortDictionary;
////                self->_a++;
////                if (self->_a == 2) {
////                    self->_a = 0;
////                    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
////                }
////            });
////        }
////
////    } andError:^(NSError * _Nullable error) {
////        NSLog(@"请求失败");
////    }];
////
////}
//
//- (void)pressCollection:(UIButton *)button {
//    if (button.selected) {
//        button.selected = NO;
//        [self.collectionArray replaceObjectAtIndex:button.tag - 100 withObject:@"0"];
//        NSInteger nowAt = button.tag - 100;
//        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
//        for (int i = 0; i < self.allTransDataArray.count; i++) {
//            if ([nowAtString isEqualToString:self.allTransDataArray[i][5]]) {
//                [self.allTransDataArray removeObjectAtIndex:i];
//                break;;
//            }
//        }
//
//    } else {
//        button.selected = YES;
//        [self.collectionArray replaceObjectAtIndex:button.tag - 100 withObject:@"1"];
//
//        NSInteger nowAt = button.tag - 100;
//        self.temporaryArray = [[NSMutableArray alloc] init];
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][0][nowAt % 6]]; //标题
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][1][nowAt % 6]]; //副标题
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][2][nowAt % 6]]; //图片
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][3][nowAt % 6]]; //URL
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][4]]; //日期
//        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
//        [self.temporaryArray addObject:nowAtString];
//        [self.temporaryArray addObject:self.goodArray[nowAt]];
//        [self.temporaryArray addObject:self.collectionArray[nowAt]];
//        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][5][nowAt % 6]]; //URL
//
//        [self.allTransDataArray addObject:self.temporaryArray];
//
//    }
//    [self deleteData];
//    [self insertData];
//}
//
//- (void)pressShare:(UIButton *)button {
//    NSLog(@"Share");
//}
//
////返回上一级视图
//- (void)backView:(UIButton *)button {
//    [self.viewScrollView removeFromSuperview];
//}
//
////处理点击事件，用于更新点赞和收藏状态。
//- (void)ClickEvents:(NSNotification*)sender {
//    NSInteger locationNow = [sender.userInfo[@"Location"] intValue]; //获取要替换数组字符的位置
//    if ([sender.userInfo[@"Judge"] isEqualToString:@"good"]) {
//        [self.goodArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];  //替换相应位置的值
//    } else {
//        [self.collectionArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];
//    }
//
//}
//
////推出消息页面
//- (void)push {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.navigationController pushViewController:self.messageView animated:YES];
//    });
//}
//
////释放通知监听
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
////
//////推出个人页面
////- (void)changeView:(UIButton *)button {
////    [self insertData];
////    self.personView = [[PersonViewController alloc] init];
////    self.personView.allTransDataArray = self.allTransDataArray;
////    self.personView.fileName = self.fileName;
////    [self.navigationController pushViewController:self.personView animated:YES];
////}
//
//- (void)createDataBase {
//    //1.获得数据库文件的路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", doc);
//    self.fileName = [doc stringByAppendingPathComponent:@"collectionData.sqlite"];
//
//    //2.获得数据库
//    self.collectionDatabase = [FMDatabase databaseWithPath:self.fileName];
//
//    //3.打开数据库
//    if ([self.collectionDatabase open]) {
//        BOOL result = [self.collectionDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLabel text NOT NULL, nameLabel text NOT NULL, imageURL text NOT NULL, networkURL text NOT NULL, dateLabel text NOT NULL, nowLocation text NOT NULL, goodState text NOT NULL, collectionState text NOT NULL, id text NOT NULL);"];
//        if (result) {
//            NSLog(@"创表成功");
//        } else {
//            NSLog(@"创表失败");
//        }
//    }
//}
//
////插入数据
//- (void)insertData {
//    if ([self.collectionDatabase open]) {
//        for (int i = 0; i < self.allTransDataArray.count; i++) {
//            NSInteger numResult = 0;
//            NSInteger enterResult = 0;
//            FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
//            while ([resultSet next]) {
//                NSString *id = [resultSet stringForColumn:@"id"];
//                if (![self.allTransDataArray[i][8] isEqualToString:id]) {
//                    enterResult++;
//                }
//                numResult++;
//            }
//            //两个相等代表没有重复的
//            if (enterResult == numResult) {
//                BOOL result = [self.collectionDatabase executeUpdate:@"INSERT INTO collectionData (mainLabel, nameLabel, imageURL, networkURL, dateLabel, nowLocation, goodState, collectionState, id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);", self.allTransDataArray[i][0], self.allTransDataArray[i][1], self.allTransDataArray[i][2], self.allTransDataArray[i][3], self.allTransDataArray[i][4], self.allTransDataArray[i][5], self.allTransDataArray[i][6], self.allTransDataArray[i][7], self.allTransDataArray[i][8]];
//                if (!result) {
//                    NSLog(@"增加数据失败");
//                }else{
//                    NSLog(@"增加数据成功");
//                }
//            }
//        }
//        [self.collectionDatabase close];
//    }
//    [self queryData];
//}
//
//// 更新数据
//- (void)updateData {
//    if ([self.collectionDatabase open]) {
//        NSString *sql = @"UPDATE collectionData SET id = ? WHERE nameLabel = ?";
//        BOOL result = [self.collectionDatabase executeUpdate:sql, @"1", @"hi world"];
//        if (!result) {
//            NSLog(@"数据修改失败");
//        } else {
//            NSLog(@"数据修改成功");
//        }
//        [self.collectionDatabase close];
//    }
//}
//
//// 删除数据
//- (void)deleteData {
//    if ([self.collectionDatabase open]) {
//        NSString *sql = @"delete from collectionData";
//        BOOL result = [self.collectionDatabase executeUpdate:sql];
//        if (!result) {
//            NSLog(@"数据删除失败");
//        } else {
//            NSLog(@"数据删除成功");
//        }
//        [self.collectionDatabase close];
//    }
//}
//
//// 查询数据
//- (void)queryData {
//    if ([self.collectionDatabase open]) {
//        // 1.执行查询语句
//        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
//        // 2.遍历结果
//        while ([resultSet next]) {
//            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];
//            NSLog(@"mainLabel = %@",mainLabel);
//            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
//            NSLog(@"nameLabel = %@",nameLabel);
//            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
//            NSLog(@"imageURL = %@",imageURL);
//            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
//            NSLog(@"networkURL = %@",networkURL);
//            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];
//            NSLog(@"dateLabel = %@",dateLabel);
//            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
//            NSLog(@"nowLocation = %@",nowLocation);
//            NSString *goodState = [resultSet stringForColumn:@"goodState"];
//            NSLog(@"goodState = %@",goodState);
//            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
//            NSLog(@"collectionState = %@",collectionState);
//            NSString *id = [resultSet stringForColumn:@"id"];
//            NSLog(@"id = %@",id);
//        }
//        [self.collectionDatabase close];
//    }
//}
//
//- (void)getDataFromDataBase {
//    if ([self.collectionDatabase open]) {
//        // 1.执行查询语句
//        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
//        // 2.遍历结果
//        while ([resultSet next]) {
//            self.temporaryArray = [[NSMutableArray alloc] init];
//            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];
//            [self.temporaryArray addObject:mainLabel];
//            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
//            [self.temporaryArray addObject:nameLabel];
//            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
//            [self.temporaryArray addObject:imageURL];
//            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
//            [self.temporaryArray addObject:networkURL];
//            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];
//            [self.temporaryArray addObject:dateLabel];
//            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
//            [self.temporaryArray addObject:nowLocation];
//            NSString *goodState = [resultSet stringForColumn:@"goodState"];
//            [self.temporaryArray addObject:goodState];
//            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
//            [self.temporaryArray addObject:collectionState];
//            NSString *id = [resultSet stringForColumn:@"id"];
//            [self.temporaryArray addObject:id];
//
//            [self.allTransDataArray addObject:self.temporaryArray];
//        }
//        [self.collectionDatabase close];
//    }
//}
//
////判断数据库中的数据
//- (void)judgeDataBaseData {
//    if ([self.collectionDatabase open]) {
//        NSString *sql = @"delete from collectionData WHERE collectionState = ?";
//        BOOL result = [self.collectionDatabase executeUpdate:sql, @"0"];
//        if (!result) {
//            NSLog(@"数据删除失败");
//        } else {
//            NSLog(@"数据删除成功");
//        }
//        [self.collectionDatabase close];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//@end
