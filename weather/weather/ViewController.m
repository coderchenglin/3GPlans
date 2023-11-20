//
//  ViewController.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.tableArray = [[NSMutableArray alloc] init];
//    [self.tableArray addObject:@"1"];
//    [self loadControl];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableArray = [[NSMutableArray alloc] init];
    [self.tableArray addObject:@""];
    [self loadControl];
}

- (void)loadControl {
    self.view.backgroundColor = [UIColor whiteColor];
    self.allInformationArray = [[NSMutableArray alloc] init];
    
    self.timeNowArray = [[NSMutableArray alloc] init];
    self.nameNowArray = [[NSMutableArray alloc] init];
    self.cityName = [[NSString alloc] init];
    self.temperatureNowArray = [[NSMutableArray alloc] init];
    self.oneData = [[NSMutableArray alloc] init];
    
    self.maxString = [[NSString alloc] init];
    self.minString = [[NSString alloc] init];
    self.nowString = [[NSString alloc] init];
    self.weaString = [[NSString alloc] init];
    self.timeArray = [[NSMutableArray alloc] init];
    self.weaArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];

    self.timeLabel = [[UILabel alloc] init];
    self.weaLabel = [[UILabel alloc] init];
    self.imageView = [[UIImageView alloc] init];
    
    self.weakDayArray = [[NSMutableArray alloc] init];
    self.weakImageArray = [[NSMutableArray alloc] init];
    self.weakmaxArray = [[NSMutableArray alloc] init];
    self.weakminArray = [[NSMutableArray alloc] init];
    
    self.airQuality = [[NSString alloc] init];
    self.endArray = [[NSMutableArray alloc] initWithObjects:@"日出", @"日落", @"能见度", @"气压hPa", @"空气质量", @"湿度", @"风向", @"风力等级", nil];
    self.informationArray = [[NSMutableArray alloc] init];
    
    self.cityName = _tableArray[0];
    
    [self creatUrl];
    
    //网络请求以后，吧oneData push入allInformationArray
    [self.allInformationArray addObject:self.oneData];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, width, height - 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"main"];
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"head"];
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"button"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(increaseCity:) name:@"city" object:nil];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //最后一排，设置button
    if (indexPath.row == self.temperatureNowArray.count) {
        NSLog(@"%ld,%lu", (long)indexPath.row,(unsigned long)self.temperatureNowArray.count);
        MainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"button" forIndexPath:indexPath];
        [cell.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        //第一排，设置“我的位置”
        if (indexPath.row == 0) {
            MainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"head" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.timeLabel.text = @"我的位置";
            cell.cityLabel.text = _nameNowArray[0];
            cell.temperatureLabel.text = _temperatureNowArray[0];
            return cell;
        } else {
            
            MainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.timeLabel.text = _timeNowArray[indexPath.row];
            cell.cityLabel.text = _nameNowArray[indexPath.row];
            cell.temperatureLabel.text = _temperatureNowArray[indexPath.row];
            return cell;
        }
        
    }
}

- (void)pressButton:(UIButton*)button {
    SearchViewController *search = [[SearchViewController alloc] init];
    [self presentViewController:search animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _temperatureNowArray.count + 1;
}

- (void)increaseCity:(NSNotification*)message {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //只要点的不是搜索键
    if (indexPath.row != _temperatureNowArray.count) {
        ShowViewController *show = [[ShowViewController alloc] init];
        show.modalPresentationStyle = UIModalPresentationFullScreen;
        MainTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        show.transArray = [[NSMutableArray alloc] init];
        show.transArray = self.nameNowArray;
        show.number = self.nameNowArray.count;
        for (int i = 0; i < self.nameNowArray.count; i++) {
            if ([cell.cityLabel.text isEqualToString:self.nameNowArray[i]]) {
                show.index = i;
            }
        }
        show.allInformationArray = [[NSMutableArray alloc] init];
        show.allInformationArray = self.allInformationArray;
        [self presentViewController:show animated:YES completion:nil];
    }
}


- (void)creatUrl {
//    NSString *urlString = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=99184696&appsecret=JS3pjzUZ&city=%@", _cityName];
    
    NSString *urlString = [NSString stringWithFormat:@"https://v0.yiketianqi.com/api?unescape=1&version=v9&appid=16428232&appsecret=fxX3iIuF&ext=&cityid=&city=%@", _cityName];
    //处理字符
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    
    NSURLSessionTask *task1 = [session1 dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSMutableString *stringOne = [NSMutableString stringWithFormat:@"%@",dic[@"data"][0][@"tem"]];
            NSMutableString *stringTwo = [NSMutableString stringWithFormat:@"%@",dic[@"city"]];
            NSDate *timeDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            NSString *locationString = [dateFormatter stringFromDate:timeDate];
            
            
            [self->_temperatureNowArray addObject:stringOne];
            [self->_nameNowArray addObject:stringTwo];
            [self->_timeNowArray addObject:locationString];
            
            NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.maxString = secondDictionary[@"data"][0][@"tem1"];
            self.minString = secondDictionary[@"data"][0][@"tem2"];
            self.nowString = secondDictionary[@"data"][0][@"tem"];
            self.weaString = secondDictionary[@"data"][0][@"wea"];
            self.airQuality = secondDictionary[@"data"][0][@"air_tips"];
            //self.airQuality = secondDictionary[@"data"][0][@"air_level"];

            NSMutableArray *allArray = [[NSMutableArray alloc] init];
            allArray = secondDictionary[@"data"][0][@"hours"];
            for (int i = 0; i < allArray.count; i++) {
                [self->_timeArray addObject:allArray[i][@"hours"]];
                [self->_weaArray addObject:allArray[i][@"tem"]];
                [self->_imageArray addObject:allArray[i][@"wea_img"]];
            }
            NSMutableArray *weakArray = [[NSMutableArray alloc] init];
            weakArray = secondDictionary[@"data"];
            for (int i = 0; i < weakArray.count - 1; i++) {
                [self->_weakDayArray addObject:weakArray[i + 1][@"week"]];
                [self->_weakImageArray addObject:weakArray[i + 1][@"wea_img"]];
                [self->_weakmaxArray addObject:weakArray[i + 1][@"tem1"]];
                [self->_weakminArray addObject:weakArray[i + 1][@"tem2"]];
            }
            
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunrise"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunset"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"visibility"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"pressure"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"air"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"humidity"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win"][0]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win_speed"]];
            
            if ([self.cityName isEqualToString:@""]) {
                [self->_oneData addObject:stringTwo];
                [self->_oneData addObject:self.maxString];
                [self->_oneData addObject:self.minString];
                [self->_oneData addObject:self.nowString];
                [self->_oneData addObject:self.weaString];
                [self->_oneData addObject:self.airQuality];
                [self->_oneData addObject:self.timeArray];
                [self->_oneData addObject:self.weaArray];
                [self->_oneData addObject:self.imageArray];
                [self->_oneData addObject:self.weakDayArray];
                [self->_oneData addObject:self.weakImageArray];
                [self->_oneData addObject:self.weakmaxArray];
                [self->_oneData addObject:self.weakminArray];
                [self->_oneData addObject:self.informationArray];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self->_tableView reloadData];
            }];
        }
    }];
    [task1 resume];
}

//- (void)creatUrl {
//
//    NSString *urlString = [NSString stringWithFormat:@"https://v0.yiketianqi.com/api?unescape=1&version=v9&appid=16428232&appsecret=fxX3iIuF&ext=&cityid=&city=%@", _cityName];
//
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//    //创建URL
//    NSURL *url = [NSURL URLWithString:urlString];
//    //sharedSession返回的是一个全局共享的NSURLSession实例
//    NSURLSession *session1 = [NSURLSession sharedSession];
//
//    NSURLSessionTask *task1 = [session1 dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            //解析数据
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//            //当前温度
//            NSMutableString *stringOne = [NSMutableString stringWithFormat:@"%@", dic[@"data"][0][@"tem"]];
//            //城市名
//            NSMutableString *stringTwo = [NSMutableString stringWithFormat:@"%@", dic[@"city"]];
//            //这是一个表示日期和时间的类，这句代码用来“获取当前日期和时间”
//            NSDate *timeDate = [NSDate date];
//            //这是一个用于将NSDate对象与字符串之间相互转换的类
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            //设置日期的现实格式
//            [dateFormatter setDateFormat:@"HH:mm"];
//            // 将NSDate对象格式化为字符串
//            NSString *locationString = [dateFormatter stringFromDate:timeDate];
//
//            [self->_temperatureNowArray addObject:stringOne];//当前温度
//            [self->_nameNowArray addObject:stringTwo];//当前地点
//            [self->_timeNowArray addObject:locationString];//当前时间
//
//            NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//            self.maxString = secondDictionary[@"data"][0][@"tem1"];//最高温度
//            self.minString = secondDictionary[@"data"][0][@"tem2"];//最低温度
//            self.nowString = secondDictionary[@"data"][0][@"tem"];
//            self.weaString = secondDictionary[@"data"][0][@"wea"];
//            self.airQuality = secondDictionary[@"data"][0][@"air_tips"];
//
//            //allArray：存储每小时数据
//            NSMutableArray *allArray = [[NSMutableArray alloc] init];
//
//            //获取并设置实时的 时间，天气,温度
//            allArray = secondDictionary[@"data"][0][@"hours"];
//            for(int i = 0; i < allArray.count; i++) {
//                [self->_timeArray addObject:allArray[i][@"hours"]];
//                [self->_weaArray addObject:allArray[i][@"tem"]];
//                [self->_imageArray addObject:allArray[i][@"wea_img"]];
//            }
//            //weakArray：存储每周的数据
//            NSMutableArray *weakArray = [[NSMutableArray alloc] init];
//            weakArray = secondDictionary[@"data"];
//            for (int i = 0; i < weakArray.count - 1; i++) {
//
//                [self->_weakDayArray addObject:weakArray[i + 1][@"weak"]];
//                [self->_weakImageArray addObject:weakArray[i + 1][@"wea_img"]];
//                [self->_weakmaxArray addObject:weakArray[i + 1][@"tem1"]];
//                [self->_weakminArray addObject:weakArray[i + 1][@"tem2"]];
//            }
//
//            //或许下面的 日出，日落，能见度等信息
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunrise"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunset"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"visibility"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"pressure"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"air"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"humidity"]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win"][0]];
//            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win_spead"]];
//
//            if ([self.cityName isEqualToString:@""]) {
//                [self->_oneData addObject:stringTwo]; //城市名
//                [self->_oneData addObject:self.maxString];//最大温度
//                [self->_oneData addObject:self.minString];//最小温度
//                [self->_oneData addObject:self.nowString];//当前温度
//                [self->_oneData addObject:self.weaString];//当前天气
//                [self->_oneData addObject:self.airQuality];//空气质量
//                //每小时的 时间，天气，天气图标
//                [self->_oneData addObject:self.timeArray];
//                [self->_oneData addObject:self.weaArray];
//                [self->_oneData addObject:self.imageArray];
//                //每周的 星期几，天气图标，最高温度，最低温度
//                [self->_oneData addObject:self.weakDayArray];
//                [self->_oneData addObject:self.weakImageArray];
//                [self->_oneData addObject:self.weakmaxArray];
//                [self->_oneData addObject:self.weakminArray];
//                //日出，日落等信息
//                [self->_oneData addObject:self.informationArray];
//            }
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [self->_tableView reloadData];
//            }];
//        }
//    }];
//    [task1 resume];
//}


@end
