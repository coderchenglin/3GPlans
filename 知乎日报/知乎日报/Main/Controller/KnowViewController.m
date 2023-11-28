//
//  KnowViewController.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import "KnowViewController.h"
#import "NetworkModel.h"
#import "OldNetworkModel.h"



@interface KnowViewController ()

@property (nonatomic, strong) KnowView *addKnowView;


@property (nonatomic, strong) FMDatabase *collectionDataBase;  //数据库
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUrl:) name:@"transUrl" object:nil];
    //showUrl：方法，主要实现了展示多个网页，并使用通知传值传过来的数据，对新的WKWebView提供数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"post" object:nil];
    //push方法实现了在主线程异步调用的方式，将self.messageView推入导航栏控制器的堆栈中，以此来进行页面切换
    [self GetNetworkModel];
    //[self getDateFromDataBase];
    //[self arrayState];
    
}

//push方法实现了在主线程异步调用的方式，将self.messageView推入导航栏控制器的堆栈中，以此来进行页面切换
- (void)push {
    
}

//showUrl：方法，主要实现了展示多个网页，并使用通知传值传过来的数据，对新的WKWebView提供数据
- (void)showUrl:(NSNotification *)sender {
    
}

- (void)addUI {
    
    self.addKnowView = [[KnowView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(information:) name:@"returnInformation" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickEvents:) name:@"FavoriteClickEvents" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
    
    self.addKnowView.dayLabel.text = [self.monthString substringWithRange:NSMakeRange(6, 2)];
    NSString *month = [self.monthString substringWithRange:NSMakeRange(4, 2)];
    self.addKnowView.monthLabel.text = [self changMonth:month];
    
    [self.addKnowView.flaseButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addKnowView];
}

- (void)GetNetworkModel {
    
    [[NetworkModel shareNetworkModel] NetworkModelData:^(NetworkJSONModel * _Nullable networkModel) {
        
        self.monthString = [networkModel.data copy];
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



- (void)judgeDataBaseData {
    if ([self.collectionDataBase open]) {
        
        NSString *sql = @"delete from collectionData WHERE collectionState = ?";
        BOOL result = [self.collectionDataBase executeUpdate:sql, @"0"];
        if(!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDataBase close];
    }
    
}

- (void)createDataBase {
    //获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", doc);
    self.fileName = [doc stringByAppendingPathComponent:@"collectionData.sqlite"]; //这是我自己指定的数据库名称
    
    //2.获得数据库
    self.collectionDataBase = [FMDatabase databaseWithPath:self.fileName];
    
    //3.打开数据库
    if ([self.collectionDataBase open]) {
        BOOL result = [self.collectionDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLable text NOT NULL, nameLabel text NOT NULL, imageURL text NOT NULL, networkURL text NOT NULL, dataLabel text NOT NULL, nowLocation text NOT NULL, goodState text NOT NULL, collectionState text NOT NULL, id text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
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
