//
//  KnowViewController.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/17.
//

#import "KnowViewController.h"
#import "NetworkModel.h"
#import "PersonViewController.h"
#import "OldNetworkModel.h"
#import "ShortModel.h"
#import "LongModel.h"
#import "MessageViewController.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface KnowViewController ()

@property (nonatomic, strong) KnowView *addKnowView;  //首界面
@property (nonatomic, strong) PersonViewController *personView; //点进头像的界面
@property (nonatomic, strong) MessageViewController *messageView;    //评论界面

@property (nonatomic, strong) FMDatabase *collectionDatabase; //数据库 - 存放“我的收藏”中的信息
@property (nonatomic, copy) NSString *fileName;  //数据库路径

@end

@implementation KnowViewController


//视图加载完成时调用的方法，用于初始化数据和执行一些初始化操作 *
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //创建数据库
    [self createDataBase];
    //清除数据库中collectionData表中collectionState列为0的记录
    [self judgeDataBaseData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.monthString = [[NSString alloc] init]; //日期信息
    self.getString = [[NSString alloc] init];   //日期信息
    self.goodArray = [[NSMutableArray alloc] init];  //点赞状态数组
    self.collectionArray = [[NSMutableArray alloc] init]; //收藏状态数组
    self.allNetworkData = [[NSMutableArray alloc] init];  //所有网络请求数组
    self.allTransDataArray = [[NSMutableArray alloc] init]; //存储网路请求数据，用于insert数据库
    self.temporaryArray = [[NSMutableArray alloc] init]; //临时数组
    self.a = 0; //计数用的，用来控制长评和短评同时访问成功时，才发送通知推出MessageView界面
    
    //由KnowView的图片按钮点击事件,或者新闻cell的点击事件，传过来通知，将图片按钮的信息，以字典型数据发送过来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUrl:) name:@"transUrl" object:nil];
    //由下面等pressMessage方法，传过来，通知要掉用push方法，推出MessageView界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"post" object:nil];
    
    [self GetNetworkModel]; //获取网络请求数据
    
    [self getDataFromDataBase]; //从数据库中获取数据
    NSLog(@"完成");
    [self arrayState]; //用于初始化点赞和收藏的数组，确保数组的长度与数据源一致
    //1.如果没有任何收藏和点赞的情况下，初始collectionArray和goodArray数组有6个'0'元素
    //2.如果收藏和点赞数不为0的情况下
}

//使用动画的方式隐藏导航栏 *
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//用于初始化点赞和收藏的数组，确保数组的长度与数据源一致。 *
- (void)arrayState {
    for (NSInteger i = self.goodArray.count; i < 6; i++) {
        // i<6表示要确保 self.goodArray 和 self.collectionArray 数组的元素个数至少为 6
        NSInteger judge = 0;
        //在开始还没有任何点击收藏的情况下，allTransDataArray为0，循环直接跳过，goodArray和collectionArray添加六个'0'元素
        //如果有点赞收藏的情况，allTransDataArray中就有数据，遍历allTransDataArray数组中前6个数据，如果对应下标有数据，那么就将allTransDataArray中的数据添加进去，没有就
        for (int j = 0; j < self.allTransDataArray.count; j++) {
            if (i == [self.allTransDataArray[j][5] intValue]) {
                [self.goodArray addObject:self.allTransDataArray[j][6]];
                [self.collectionArray addObject:self.allTransDataArray[j][7]];
                judge = 1;
                break;
            }
        }
        if (!judge) {
            [self.goodArray addObject:@"0"];
            [self.collectionArray addObject:@"0"];
        }
    }
}

//用于添加用户界面元素，包括知识浏览视图 KnowView。 （还和头像按钮有关）
- (void)addUI {
    
    self.addKnowView = [[KnowView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    //KnowView中，下拉加载后传的通知，告知这边要掉用方法获取旧数据了，没有传数据过来，只是通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(information:) name:@"returnInformation" object:nil];
    //CollectViewController中，点赞按钮传过来的通知
    //传过来的值包括：点击的是点赞还是收藏，location，changeValue值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickEvents:) name:@"FavoriteClickEvents" object:nil];
    
    //通知传值 - 将请求下来并转换为字典结构的网络信息，传给KnowView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
    
    //获取首页顶部的几月几号的信息
    self.addKnowView.dayLabel.text = [self.monthString substringWithRange:NSMakeRange(6, 2)];//存储数字多少号，如11号
    NSString *month = [self.monthString substringWithRange:NSMakeRange(4, 2)];
    self.addKnowView.monthLabel.text = [self changMonth:month];//拿到汉字月份
    
    //头像按钮
    [self.addKnowView.flaseButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addKnowView];
}

//发起网络请求，获取新数据，并在请求完成后更新界面。 *
- (void)GetNetworkModel {
    
    //创建一个NetworkModel单例对象，再用这个单例对象 调用网络请求方法
    [[NetworkModel shareNetworkModel] NetworkModelData:^(NetworkJSONModel * _Nullable networkModel) {
        //请求成功后 执行
        NSLog(@"请求成功！-- %@", [NSThread currentThread]);
        self.monthString = [networkModel.date copy]; //20231211 数据长这样
        self.getString = [self.monthString copy];
        self.dictionaryModel = [networkModel toDictionary]; //讲请求下来的数据，转换为字典型数据
        //里面有日期date，下面内容二维数组，顶部滚动视图二维数组
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addUI];
        });
        
    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败！");
    }];
}

//发起网络请求获取旧的数据  *
- (void)information:(NSNotification *)sender {
    
    //创建OldNetworkModel单例对象
    OldNetworkModel *manager = [OldNetworkModel shareOldNetworkModel];
    manager.nowDate = self.getString; //拿到当前日期
    
    [[OldNetworkModel shareOldNetworkModel] OldNetworkModelData:^(OldNetworkJSONModel * _Nullable oldNetworkModel) {
        //网络请求成功后的操作
        self.dictionaryModel = [oldNetworkModel toDictionary]; //将请求下来的数据转为 字典形式存起来
        
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
    }];
    
    self.getFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    self.getFormatter.dateFormat = @"yyyyMMdd";
    self.getDate = [self.getFormatter dateFromString:self.getString];
    //获取一天前的日期
    self.getDate = [[NSDate alloc] initWithTimeInterval:-1 * 3600 * 24 sinceDate:self.getDate];
    self.getString = [self.getFormatter stringFromDate:self.getDate];
}

//获取新的数据，并通过通知机制传递给界面。 *
- (void)getNewInformation {
    //发送通知给KnowView，将刚才获取的陈旧的数据，以字典的形式，传给KnowView
    //这里也是传值，将从网络获取的旧新闻的数据传值给KnowView，跟之前一样的
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Network" object:nil userInfo:self.dictionaryModel];
}

//转化月份 *
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

//展示网页内容，包括点赞、评论等按钮。  *
- (void)showUrl:(NSNotification *)sender {
    NSLog(@"%s --- %@", __func__, [NSThread currentThread]);
    //这些数据是从KnowView中传过来的，
    self.allTransURL = sender.userInfo[@"url"];
    self.allTransID = sender.userInfo[@"id"];
    self.atLocation = [sender.userInfo[@"location"] intValue];
    self.allNetworkData = sender.userInfo[@"allData"];
    
    self.viewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    self.viewScrollView.contentSize = CGSizeMake(myWidth * self.allTransURL.count, myHeight);
    self.viewScrollView.backgroundColor = [UIColor whiteColor];
    self.viewScrollView.pagingEnabled = YES;
    self.viewScrollView.showsHorizontalScrollIndicator = NO;
    self.viewScrollView.showsVerticalScrollIndicator = NO;
    self.viewScrollView.delegate = self;
    self.viewScrollView.tag = 1111;
    [self.view addSubview:self.viewScrollView];
    
    //和前面的arrayState不同，那个只是先创建和初始化数组前6个元素
    //初始化 self.goodArray 和 self.collectionArray 数组，确保它们的元素数量与 self.allTransURL 数组相同。
    if (self.goodArray.count != self.allTransURL.count) {
        for (NSInteger i = self.goodArray.count; i < self.allTransURL.count; i++) {
            //遍历一边，allTransDataArray中的数据
            //如果allTransDataArray中对应位置有数据，就添加，没有，就添加'0'，反正最后保证collectionArray元素数量是够的
            for (int j = 0; j < self.allTransDataArray.count; j++) {
                //通过self.allTransDataArray[j][5]，即Location，来给对应Location的新闻添加goodArray和collectionArray元素
                if (i == [self.allTransDataArray[j][5] intValue]) {
                    [self.goodArray addObject:self.allTransDataArray[j][6]];
                    [self.collectionArray addObject:self.allTransDataArray[j][7]];
                    continue;
                }
            }
            //让goodArray数，collectionArray数和URL数量相同
            [self.goodArray addObject:@"0"];
            [self.collectionArray addObject:@"0"];
        }
    }
    
    for (int i = 0; i < self.allTransURL.count; i++) {
        //初始化网络界面WebView
        self.URLWebView = [[WKWebView alloc] initWithFrame:CGRectMake(myWidth * i, myWidth / 13, myWidth, myHeight / 1.11)];
        self.URLWebView.tag = 1000 + i;  //tag是1000+新闻序号数
        self.URLWebView.UIDelegate = self;
        [self.URLWebView canGoBack];//判断 WebView 是否可以执行返回上一页的操作
        [self.viewScrollView addSubview:self.URLWebView];
        
        NSURL *nowURL = [NSURL URLWithString:self.allTransURL[i]];
        NSURLRequest *nowRequest = [NSURLRequest requestWithURL:nowURL];
        //加载网页
        [self.URLWebView loadRequest:nowRequest];  //用于加载指定的 NSURLRequest 对象，也就是发起网络请求并加载对应的网页内容。
        
        //下面是添加底部视图，并添加底部视图上的各个按钮
        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = CGRectMake(myWidth * i, myWidth / 13 + myHeight / 1.11, myWidth, myHeight - myWidth / 13 - myHeight / 1.11);
        self.bottomView.backgroundColor = [UIColor systemGray6Color];
        [self.viewScrollView addSubview:self.bottomView];
        
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
        if ([self.goodArray[i] isEqualToString:@"0"]) {  //判断点赞按钮的状态
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

//点赞按钮 *
- (void)pressGood:(UIButton *)button {
    if (button.selected) {
        //取消点赞
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
        //点赞
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
    [self deleteData]; //删除数据库中的数据
    [self insertData]; //用新的allTransDataArray更新数据库的数据
}

//评论界面 *
- (void)pressMessage:(UIButton *)button {
    LongModel *getLongData = [LongModel shareLongModel];
    getLongData.LongID = self.allTransID[button.tag - 10];
    ShortModel *getShortData = [ShortModel shareShortModel];
    getShortData.shortID = self.allTransID[button.tag - 10];
    
    self.messageView = [[MessageViewController alloc] init];
    
    [[LongModel shareLongModel] NetworkGetLongData:^(LongJSONModel * _Nullable longModel) {
        self.longDictionary = [longModel toDictionary];
        
        if (self.longDictionary) {
            self.messageView.longDictionary = self.longDictionary; //网络请求的数据已经传过去了
            
            //这是用来控制，发送“post”请求只发送一次，
            //只有在长评和短评都请求成功了才会发送
            self->_a++;
            if (self->_a == 2) {
                self->_a = 0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
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
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
                }
            });
        }

    } andError:^(NSError * _Nullable error) {
        NSLog(@"请求失败");
    }];
}

//allTransDataArray中的数据就从这里来 *
- (void)pressCollection:(UIButton *)button {
    if (button.selected) {
        //取消收藏
        button.selected = NO;
        [self.collectionArray replaceObjectAtIndex:button.tag - 100 withObject:@"0"];
        NSInteger nowAt = button.tag - 100;
        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
        for (int i = 0; i < self.allTransDataArray.count; i++) {
            if ([nowAtString isEqualToString:self.allTransDataArray[i][5]]) {
                [self.allTransDataArray removeObjectAtIndex:i];
                break;
            }
        }
        //点击收藏
    } else {
        button.selected = YES;
        [self.collectionArray replaceObjectAtIndex:button.tag - 100 withObject:@"1"];
        
        NSInteger nowAt = button.tag - 100;
        self.temporaryArray = [[NSMutableArray alloc] init];
        //(nowAt / 6)代表第几个section
        //第几个section的第哪个一维数组（标题，副标题等）的第几个（一组总共5个）
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][0][nowAt % 6]]; //0.标题
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][1][nowAt % 6]]; //1.副标题
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][2][nowAt % 6]]; //2.图片
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][3][nowAt % 6]]; //3.URL
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][4]];  //4.日期
        NSString *nowAtString = [[NSString alloc] initWithFormat:@"%ld", (long)nowAt];
        [self.temporaryArray addObject:nowAtString]; //5.位置
        [self.temporaryArray addObject:self.goodArray[nowAt]]; //6.点赞状态数组
        [self.temporaryArray addObject:self.collectionArray[nowAt]]; //7.收藏状态数组
        [self.temporaryArray addObject:self.allNetworkData[nowAt / 6][5][nowAt % 6]]; //8.URL
        
        [self.allTransDataArray addObject:self.temporaryArray];
    }
    [self deleteData]; //清除数据库
    [self insertData]; //用allTransDataArray重新构建数据库
}

//分享按钮 *
- (void)pressShare:(UIButton *)button {
    //NSLog(@"Share");
}

//返回上一级视图 *
- (void)backView:(UIButton *)button {
    [self.viewScrollView removeFromSuperview];//从父视图中移除self.viewScrollView
}

//处理点击事件，用于更新点赞和收藏状态。 *
- (void)ClickEvents:(NSNotification*)sender {
    NSInteger locationNow = [sender.userInfo[@"Location"] intValue]; //获取要替换数组字符的位置
    //如果点击的是点赞按钮
    if ([sender.userInfo[@"Judge"] isEqualToString:@"good"]) {
        [self.goodArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];  //替换成相应位置的changeValue值
    } else {
        //否则点击的是收藏按钮
        [self.collectionArray replaceObjectAtIndex:locationNow withObject:sender.userInfo[@"ChangeValue"]];
    }
}

//推出消息页面
- (void)push {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:self.messageView animated:YES];
    });
}

//释放通知监听 *
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//推出个人页面
- (void)changeView:(UIButton *)button {
    [self insertData];
    self.personView = [[PersonViewController alloc] init];
    self.personView.allTransDataArray = self.allTransDataArray; //把所有收藏数据传过去
    self.personView.fileName = self.fileName;  //数据库名称传过去
    [self.navigationController pushViewController:self.personView animated:YES];
}

//创建数据库 *
- (void)createDataBase {
    //1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSLog(@"%@", doc);
    self.fileName = [doc stringByAppendingPathComponent:@"collectionData.sqlite"];
    //NSLog(@"self.fileName = %@,line = %d",self.fileName,__LINE__);
    
    //2.创建数据库对象
    self.collectionDatabase = [FMDatabase databaseWithPath:self.fileName];
    
    //3.打开数据库
    if ([self.collectionDatabase open]) {
        BOOL result = [self.collectionDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLabel text NOT NULL, nameLabel text NOT NULL, imageURL text NOT NULL, networkURL text NOT NULL, dateLabel text NOT NULL, nowLocation text NOT NULL, goodState text NOT NULL, collectionState text NOT NULL, id text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
}

//插入数据 *
//先判重，将allTransDataArray中的数据添加到数据库collectionData中
- (void)insertData {
    if ([self.collectionDatabase open]) {
        for (int i = 0; i < self.allTransDataArray.count; i++) {
            NSInteger numResult = 0;
            NSInteger enterResult = 0;
            FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
            while ([resultSet next]) {
                //判重
                NSString *id = [resultSet stringForColumn:@"id"];
                if (![self.allTransDataArray[i][8] isEqualToString:id]) {
                    enterResult++; //不相等就++
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
    [self queryData]; //打印一下看看
}

// 更新数据 ？？？有啥用？
- (void)updateData {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"UPDATE collectionData SET id = ? WHERE nameLabel = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql, @"1", @"hi world"];
        if (!result) {
            NSLog(@"数据修改失败");
        } else {
            NSLog(@"数据修改成功");
        }
        [self.collectionDatabase close];
    }
}

// 删除数据 *
- (void)deleteData {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"delete from collectionData";  //删除collectionData表中的所有数据的语句
        BOOL result = [self.collectionDatabase executeUpdate:sql]; //增删改 都用excuteUpdate
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDatabase close];
    }
}

// 查询数据 （其实就是一个打印数据库内容的方法） *
- (void)queryData {
    if ([self.collectionDatabase open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([resultSet next]) {
            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];
            //NSLog(@"mainLabel = %@",mainLabel);
            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
            //NSLog(@"nameLabel = %@",nameLabel);
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            //NSLog(@"imageURL = %@",imageURL);
            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
            //NSLog(@"networkURL = %@",networkURL);
            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];
            //NSLog(@"dateLabel = %@",dateLabel);
            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
            //NSLog(@"nowLocation = %@",nowLocation);
            NSString *goodState = [resultSet stringForColumn:@"goodState"];
            //NSLog(@"goodState = %@",goodState);
            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
            //NSLog(@"collectionState = %@",collectionState);
            NSString *id = [resultSet stringForColumn:@"id"];
            //NSLog(@"id = %@",id);
        }
        [self.collectionDatabase close];
    }
}


//从数据库中获取数据 *
- (void)getDataFromDataBase {
    if ([self.collectionDatabase open]) {
        
        // 1.执行查询语句
        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([resultSet next]) {
            self.temporaryArray = [[NSMutableArray alloc] init];
            
            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];  //0 主标题
            [self.temporaryArray addObject:mainLabel];
            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];  //1 名字信息（副标题）
            [self.temporaryArray addObject:nameLabel];
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];    //2 图片URL
            [self.temporaryArray addObject:imageURL];
            NSString *networkURL = [resultSet stringForColumn:@"networkURL"]; //3 网页URL
            [self.temporaryArray addObject:networkURL];
            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];   //4 数据内容
            [self.temporaryArray addObject:dateLabel]; //这里存储等是：几月几号
//            NSLog(@"dateLabel = %@,line = %d",dateLabel,__LINE__);
            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"]; //5 当前位置
            [self.temporaryArray addObject:nowLocation];
            NSString *goodState = [resultSet stringForColumn:@"goodState"]; //6 点赞状态
            [self.temporaryArray addObject:goodState];
            NSString *collectionState = [resultSet stringForColumn:@"collectionState"]; //7 收藏状态
            [self.temporaryArray addObject:collectionState];
            NSString *id = [resultSet stringForColumn:@"id"];          //8 id
            [self.temporaryArray addObject:id];
            
            [self.allTransDataArray addObject:self.temporaryArray];
        }
        [self.collectionDatabase close];
    }
    NSLog(@"数据库获取数据成功");
}

//清除数据库中collectionData表中collectionState列为0的记录 *
- (void)judgeDataBaseData {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"delete from collectionData WHERE collectionState = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql, @"0"];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
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
