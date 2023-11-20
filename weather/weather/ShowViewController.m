//
//  ShowViewController.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "ShowViewController.h"


@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadControl];
}

- (void)loadControl {
    
    self.backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"]];
    self.backImage.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:self.backImage];
    
    //设置“画布”大小
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, width, height - 82)];
    self.scrollView.tag = 111;
    self.scrollView.contentSize = CGSizeMake(width * self.number, height - 82); //number是用来记录，总共添加了几个城市的天气
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:self.scrollView];
    
    self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.increaseButton setImage:[UIImage imageNamed:@"caidan.png"] forState:UIControlStateNormal];
    [self.increaseButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    self.increaseButton.frame = CGRectMake(width - 70, height - 70, 32, 32);
    [self.view addSubview:self.increaseButton];
    
    self.weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weatherButton setImage:[UIImage imageNamed:@"tianqi.png"] forState:UIControlStateNormal];
    [self.weatherButton addTarget:self action:@selector(pressWeather:) forControlEvents:UIControlEventTouchUpInside];
    self.weatherButton.frame = CGRectMake(60, height - 70, 32, 32);
    [self.view addSubview:self.weatherButton];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.number; //添加城市数
    self.pageControl.currentPage = self.index;    //当前下表索引值
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.frame = CGRectMake(80, height - 70, 250, 32);
    [self.view addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pessPage) forControlEvents:UIControlEventValueChanged];
    
    self.imageName = [[NSString alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.weaLabel = [[UILabel alloc] init];
    self.imageView = [[UIImageView alloc] init];
    self.endArray = [[NSMutableArray alloc] initWithObjects:@"日出", @"日落", @"能见度", @"气压hPa", @"空气质量", @"湿度", @"风向", @"风力等级", nil];
    
    for (int i = 0; i < self.number; i++) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(width * i, 0, width, height - 132) style:UITableViewStylePlain]; //这是直接加在ScrollView上的，所以height-50-82
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tag = i;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:self.tableView];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"seven"];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"weak"];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"tips"];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"air"];
        [self.tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"more"];
        self.tableView.showsVerticalScrollIndicator = FALSE;
        self.tableView.showsHorizontalScrollIndicator = FALSE;
        
    }
    
    [self.scrollView setContentOffset:CGPointMake(width * self.index, 0)];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"show"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bigLabel.text = self.allInformationArray[tableView.tag][0];
        cell.weatherLabel.text = self.allInformationArray[tableView.tag][4];
        cell.temperatureLabel.text = self.allInformationArray[tableView.tag][3];
        cell.maxLabel.text = self.allInformationArray[tableView.tag][1];
        cell.minLabel.text = self.allInformationArray[tableView.tag][2];
        return cell;
    } else if (indexPath.row == 1) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"seven"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *first = self.allInformationArray[tableView.tag][6];
        NSMutableArray *second = self.allInformationArray[tableView.tag][7];
        NSMutableArray *third = self.allInformationArray[tableView.tag][8];
        
        NSInteger num = first.count;
        
        for (int i = 0; i < num; i++) {
            if  (i == 0) {
                [first replaceObjectAtIndex:0 withObject:@"现在"];
            }
            self.timeLabel = [[UILabel alloc] init];
            self.timeLabel.text = first[i];
            self.timeLabel.textColor = [UIColor whiteColor];
            self.timeLabel.frame = CGRectMake(50 * i, 2, 50, 32);
            self.timeLabel.tag = 100 + i;
            self.timeLabel.textAlignment = NSTextAlignmentCenter;
            [cell.scrollView addSubview:_timeLabel];
            
            self.weaLabel = [[UILabel alloc] init];
            self.weaLabel.text = second[i];
            self.weaLabel.textColor = [UIColor whiteColor];
            self.weaLabel.frame = CGRectMake(50 * i, 66, 50, 32);
            self.weaLabel.tag = 100 + i;
            self.weaLabel.textAlignment = NSTextAlignmentCenter;
            [cell.scrollView addSubview:_weaLabel];
            
            self.imageView = [[UIImageView alloc] init];
            self.imageName = [NSString stringWithFormat:@"%@.png", third[i]];
            self.imageView.image = [UIImage imageNamed:self.imageName];
            self.imageView.frame = CGRectMake(9 + 50 * i, 34, 32, 32);
            self.imageView.tag = 100 + i;
            [cell.scrollView addSubview:_imageView];
        }
        return cell;
    } else if (indexPath.row == 2) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"weak"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *first = self.allInformationArray[tableView.tag][9];
        NSMutableArray *second = self.allInformationArray[tableView.tag][10];
        NSMutableArray *third = self.allInformationArray[tableView.tag][11];
        NSMutableArray *fourth = self.allInformationArray[tableView.tag][12];
        
        for (int i = 0; i < first.count ; i++) { //循环7次
            cell.bigLabel = [[UILabel alloc] init];
            cell.bigLabel.text = first[i];
            cell.bigLabel.frame = CGRectMake(5, 40 * i, 70, 40);
            cell.bigLabel.tag = 100 + i;
            cell.bigLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.bigLabel];
            
            cell.maxLabel = [[UILabel alloc] init];
            cell.maxLabel.text = third[i];
            cell.maxLabel.frame = CGRectMake(width - 100, 40 * i, 50, 40);
            cell.maxLabel.tag = 100 + i;
            cell.maxLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.maxLabel];
            
            cell.minLabel = [[UILabel alloc] init];
            cell.minLabel.text = fourth[i];
            cell.minLabel.frame = CGRectMake(width - 50, 40 * i, 50, 40);
            cell.minLabel.tag = 100 + i;
            cell.minLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.minLabel];
            
            self.imageView = [[UIImageView alloc] init];
            self.imageName = [NSString stringWithFormat:@"%@.png", second[i]];
            self.imageView.image = [UIImage imageNamed:_imageName];
            self.imageView.frame = CGRectMake(200, 4 + 40 * i, 32, 32);
            self.imageView.tag = 100 + i;
            [cell.contentView addSubview:_imageView];
        }
        return cell;
    } else if (indexPath.row == 3) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"tips"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *a = self.allInformationArray[tableView.tag][4];
        NSString *b = self.allInformationArray[tableView.tag][1];
        NSString *c = self.allInformationArray[tableView.tag][2];
        NSString *string = [[NSString alloc] initWithFormat:@"今天：现在%@。最高温度%@，最低气温%@.", a, b, c];
        cell.bigLabel.text = string;
        return cell;
    } else if (indexPath.row == 4) {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"air"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bigLabel.text = @"空气质量";
        cell.temperatureLabel.text = self.allInformationArray[tableView.tag][5];
        return cell;
    } else {
        
        ShowTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"more"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *end = self.allInformationArray[tableView.tag][13];
        for (int i = 0; i < self.endArray.count / 2; i++) {
            
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
            cell.temperatureLabel.text = end[i];
            cell.temperatureLabel.frame = CGRectMake(10, 30  + 100 * i, 200, 60);
            cell.temperatureLabel.textColor = [UIColor whiteColor];
            cell.temperatureLabel.font = [UIFont systemFontOfSize:28];
            [cell.contentView addSubview:cell.temperatureLabel];
            
            cell.minLabel = [[UILabel alloc] init];
            cell.minLabel.tag = 100 + i;
            cell.minLabel.text = end[i + 4];
            cell.minLabel.frame = CGRectMake(width / 2 + 10, 30 + 100 * i, 20, 60);
            cell.minLabel.textColor = [UIColor whiteColor];
            cell.minLabel.font = [UIFont systemFontOfSize:28];
            
            [cell.minLabel addSubview:cell.minLabel];
        }
        return cell;
    }
    
}

- (void)pressButton:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressWeather:(UIButton*)button {
    NSLog(@"weather");
}

- (void)pessPage {
    [self.scrollView setContentOffset:CGPointMake(width * self.pageControl.currentPage, 0) animated:NO];
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
