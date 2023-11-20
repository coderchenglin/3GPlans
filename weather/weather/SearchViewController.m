//
//  SearchViewController.m
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import "SearchViewController.h"


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
            //解析数据
            NSInteger num = 0;
            
            
        }
        
    }]
    
    
}



- (void)textFielddidChange {
    
    _cityArray = [[NSMutableArray alloc] init];
    [self.view addSubview:_tableView];
    
    
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
