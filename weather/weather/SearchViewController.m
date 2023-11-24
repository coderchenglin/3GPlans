//
//  SearchViewController.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "SearchViewController.h"
#import "TestViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadControl];
}

- (void)loadControl {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cityArray = [[NSMutableArray alloc] init];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"请输入城市，邮政编码或机场位置";
    self.titleLabel.frame = CGRectMake(0, 0, width, 50);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.textField = [[UITextField alloc] init];
    self.textField.delegate = self;
    self.textField.frame = CGRectMake(60, 50, 300, 40);
    [_textField addTarget:self action:@selector(textFielddidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.textAlignment = NSTextAlignmentCenter;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"city"];
    
    UIView *view = [[UIView alloc] init];
    self.tableView.tableFooterView = view;
}

- (void)creatUrl {
    
    NSString *urlString = [NSString stringWithFormat:@"https://geoapi.qweather.com/v2/city/lookup?location=%@&key=7f0d61794aea4090a5d2f5edaaaa48b3", _textField.text];
    //处理字符
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    
    NSURLSessionTask *task1 = [session1 dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSInteger num = 0;
            NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSMutableArray *timeArray = [[NSMutableArray alloc] init];
            timeArray = secondDictionary[@"location"];
            //遍历拉去下来的城市名
            //二重循环：拿着每一个拉取下来的城市名，和已经存在的所有城市进行一次比较
            //相同就把num置1，只有num为0，才会将该城市添加进去
            for (int i = 0; i < timeArray.count; i++) {
                //str：拉取下来的城市名
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@", secondDictionary[@"location"][i][@"name"] ];
                //拿已经存在的城市名，遍历依此与str进行对照
                //存在就置为1
                for (NSString * string in self->_cityArray) {
                    if ([string isEqualToString:str]) {
                        num = 1;
                    }
                }
                //不存在再添加，避免重复添加
                if (num == 0) {
                    [self->_cityArray addObject:str];
                }
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self->_tableView reloadData];
            }];
        }
    }];
    [task1 resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"city" forIndexPath:indexPath];
    //清空单元格的内容视图
    while ([cell.contentView.subviews lastObject] != nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _cityArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cityArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    TestViewController *test = [[TestViewController alloc] init];
    test.modalPresentationStyle = UIModalPresentationFullScreen;
    //写完TestViewController回来写这个
    test.cityName = cell.textLabel.text;
    [self presentViewController:test animated:YES completion:nil];
    
}

//文本框的内容一变化，就调用这个
- (void)textFielddidChange {
    
    _cityArray = [[NSMutableArray alloc] init];
    [self.view addSubview:_tableView];
    [self creatUrl];
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
