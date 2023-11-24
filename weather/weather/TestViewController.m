//
//  TestViewController.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "TestViewController.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadControl];
}

- (void)loadControl {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"] ];
    imageView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:imageView];
    
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
    self.weekImageArray = [[NSMutableArray alloc] init];
    self.weekmaxArray = [[NSMutableArray alloc] init];
    self.weakminArray = [[NSMutableArray alloc] init];
    
    self.airQuality = [[NSString alloc] init];
    self.endArray = [[NSMutableArray alloc] initWithObjects:@"日出", @"日落", @"能见度", @"气压hPa", @"空气质量", @"湿度", @"风向", @"风力等级", nil];
    self.informationArray = [[NSMutableArray alloc] init];
    self.allInformationArray = [[NSMutableArray alloc] init];
    
    [self creatUrl];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.closeButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(pressClose:) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.frame = CGRectMake(20, 60, 50, 30);
    [self.closeButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
    self.closeButton.titleLabel.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.closeButton];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(pressAdd:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.frame = CGRectMake(width - 70, 60, 50, 30);
    [self.addButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
    self.addButton.titleLabel.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.addButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"seven"];
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"weak"];
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"tips"];
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"air"];
    [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"more"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bigLabel.text = _cityName;
        cell.weatherLabel.text = _weaString;
        cell.temperatureLabel.text = _nowString;
        cell.maxLabel.text = _maxString;
        cell.minLabel.text = _minString;
        return cell;
    } else if (indexPath.row == 1) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"seven" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (int i = 0; i < self.timeArray.count; i++) {
            if (i == 0) {
                [self.timeArray replaceObjectAtIndex:0 withObject:@"现在"];
            }
            self.timeLabel = [[UILabel alloc] init];
            self.timeLabel.text = self.timeArray[i];
            self.timeLabel.textColor = [UIColor whiteColor];
            self.timeLabel.frame = CGRectMake(50 * i, 2, 50, 32);
            self.timeLabel.tag = 100 + i;
            self.timeLabel.textAlignment = NSTextAlignmentCenter;
            [cell.scrollView addSubview:_timeLabel];
            
            self.weaLabel = [[UILabel alloc] init];
            self.weaLabel.text = self.weaArray[i];
            self.weaLabel.textColor = [UIColor whiteColor];
            self.weaLabel.frame = CGRectMake(50 * i, 66, 50, 32);
            self.weaLabel.tag = 100 + i;
            self.weaLabel.textAlignment = NSTextAlignmentCenter;
            [cell.scrollView addSubview:_weaLabel];
            
            self.imageView = [[UIImageView alloc] init];
            self.imageName = [NSString stringWithFormat:@"%@.png", self.imageArray[i]];
            self.imageView.image = [UIImage imageNamed:_imageName];
            self.imageView.frame = CGRectMake(9 + 50 * i, 34, 32, 32);
            self.imageView.tag = 100 + i;
            [cell.scrollView addSubview:_imageView];
        }
        return cell;
    } else if (indexPath.row == 2) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"weak" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (int i = 0; i < self.weakDayArray.count; i++) {
            
            cell.bigLabel = [[UILabel alloc] init];
            cell.bigLabel.text = self.weakDayArray[i];
            cell.bigLabel.frame = CGRectMake(5, 40 * i, 70, 40);
            cell.bigLabel.tag = 100 + i;
            cell.bigLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.bigLabel];
            
            cell.maxLabel = [[UILabel alloc] init];
            cell.maxLabel.text = self.weekmaxArray[i];
            cell.maxLabel.frame = CGRectMake(width - 100, 40 * i, 50, 40);
            cell.maxLabel.tag = 100 + i;
            cell.maxLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.maxLabel];
            
            cell.minLabel = [[UILabel alloc] init];
            cell.minLabel.text = self.weakminArray[i];
            cell.minLabel.frame = CGRectMake(width - 50, 40 * i, 50, 40);
            cell.minLabel.tag = 100 + i;
            cell.minLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.minLabel];
            
            self.imageView = [[UIImageView alloc] init];
            self.imageName = [NSString stringWithFormat:@"%@.png", self.weekImageArray[i]];
            self.imageView.image = [UIImage imageNamed:_imageName];
            self.imageView.frame = CGRectMake(200, 4 + 40 * i, 32, 32);
            self.imageView.tag = 100 + i;
            [cell.contentView addSubview:_imageView];
        }
        return cell;
    } else if (indexPath.row == 3) {
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"tips" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *string = [[NSString alloc] initWithFormat:@"今天：现在%@。最高气温%@，最低气温%@。", _weaString, _maxString, _minString];
        cell.bigLabel.text = string;
        return cell;
    } else if (indexPath.row == 4) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"air" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bigLabel.text = @"空气质量";
        cell.temperatureLabel.text = self.airQuality;
        return cell;
    } else {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"more" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0;i < self.informationArray.count / 2; i++) {
            
            cell.bigLabel = [[UILabel alloc] init];
            cell.bigLabel.tag = 100 + i;
            cell.bigLabel.text = self.endArray[i];
            cell.bigLabel.frame = CGRectMake(10, 10 + 100 * i, 100, 30);
            cell.bigLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.bigLabel];
            
            cell.weatherLabel = [[UILabel alloc] init];
            cell.weatherLabel.tag = 100 + i;
            cell.weatherLabel.text = self.endArray[i + 4];
            cell.weatherLabel.frame = CGRectMake(width / 2 + 10, 10 + 100 * i, 100, 30);
            cell.weatherLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.weatherLabel];
            
            cell.temperatureLabel = [[UILabel alloc] init];
            cell.temperatureLabel.tag = 100 + i;
            cell.temperatureLabel.text = self.informationArray[i];
            cell.temperatureLabel.frame = CGRectMake(10, 30 + 100 * i, 200, 60);
            cell.temperatureLabel.textColor = [UIColor whiteColor];
            cell.temperatureLabel.font = [UIFont systemFontOfSize:28];
            [cell.contentView addSubview:cell.temperatureLabel];
            
            cell.minLabel = [[UILabel alloc] init];
            cell.minLabel.tag = 100 + i;
            cell.minLabel.text = self.informationArray[i + 4];
            cell.minLabel.frame = CGRectMake(width / 2 + 10, 30 + 100 * i, 200, 60);
            cell.minLabel.textColor = [UIColor whiteColor];
            cell.minLabel.font = [UIFont systemFontOfSize:28];
            [cell.contentView addSubview:cell.minLabel];
            
        }
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    } else if (indexPath.row == 1) {
        return 100;
    } else if (indexPath.row == 2) {
        return 240;
    } else if (indexPath.row == 3) {
        return 70;
    } else if (indexPath.row == 4) {
        return 80;
    } else {
        return 400;
    }
}

- (void)creatUrl {
    
    NSString *urlString = [NSString stringWithFormat:@"https://v0.yiketianqi.com/api?unescape=1&version=v9&appid=16428232&appsecret=fxX3iIuF&ext=&cityid=&city=%@", _cityName];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    
    NSURLSessionTask *task1 = [session1 dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            //当天的的信息：最高温，最低温，当前温度，今天天气，今天空气质量
            self.maxString = secondDictionary[@"data"][0][@"tem1"];
            self.minString = secondDictionary[@"data"][0][@"tem2"];
            self.nowString = secondDictionary[@"data"][0][@"tem"];
            self.weaString = secondDictionary[@"data"][0][@"wea"];
            //self.airQuality = secondDictionary[@"data"][0][@"air"];
            self.airQuality = secondDictionary[@"data"][0][@"air_tips"];
            //小时信息
            NSMutableArray *allArray = [[NSMutableArray alloc] init];
            allArray = secondDictionary[@"data"][0][@"hours"];
            
            for (int i = 0; i < allArray.count; i++) {
                [self->_timeArray addObject:allArray[i][@"hours"]];
                //[self->_weaArray addObject:allArray[i][@"wea"]];
                [self->_weaArray addObject:allArray[i][@"tem"]];
                [self->_imageArray addObject:allArray[i][@"wea_img"]];
            }
            //周信息（排除今天）
            NSMutableArray *weakArray = [[NSMutableArray alloc] init];
            weakArray = secondDictionary[@"data"];
            //这里不需要7天，只需要6天
            //即，如果今天是周三，我们只需要周四，五，六，日，一，二的信息即可
            
            //[self->_timeArray addObject:weakArray[i + 1][@"weak"]];
            
            for (int i = 0; i < weakArray.count - 1; i++) {
                [self->_weakDayArray addObject:weakArray[i + 1][@"week"]];
                [self->_weekImageArray addObject:weakArray[i + 1][@"wea_img"]];
                [self->_weekmaxArray addObject:weakArray[i + 1][@"tem1"]];
                [self->_weakminArray addObject:weakArray[i + 1][@"tem2"]];
            }
            
            

            //
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunrise"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"sunset"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"visibility"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"pressure"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"air"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"humidity"]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win"][0]];
            [self->_informationArray addObject:secondDictionary[@"data"][0][@"win_speed"]];

            [self->_allInformationArray addObject:self.cityName];
            [self->_allInformationArray addObject:self.maxString];
            [self->_allInformationArray addObject:self.minString];
            [self->_allInformationArray addObject:self.nowString];
            [self->_allInformationArray addObject:self.weaString];
            [self->_allInformationArray addObject:self.airQuality];
            [self->_allInformationArray addObject:self.timeArray];
            [self->_allInformationArray addObject:self.weaArray];
            [self->_allInformationArray addObject:self.imageArray];
            [self->_allInformationArray addObject:self.weakDayArray];
            [self->_allInformationArray addObject:self.weekImageArray];
            [self->_allInformationArray addObject:self.weekmaxArray];
            [self->_allInformationArray addObject:self.weakminArray];
            [self->_allInformationArray addObject:self.informationArray];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self->_tableView reloadData];
            }];
        }
    }];
    [task1 resume];
}

- (void)pressAdd:(UIButton*)button {
    //我需要一个城市名，当前时间，温度
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:_cityName forKey:@"city"];
    [dict setObject:_nowString forKey:@"now"];
    [dict setObject:_allInformationArray forKey:@"all"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"city" object:nil userInfo:dict]; //发送通知，通知名为“city”，发送内容，一个字典dict
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressClose:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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
