//
//  ViewController.m
//  weather_forecast
//
//  Created by chenglin on 2023/11/13.
//

#import "ViewController.h"

@interface ViewController () <AddViewControllerDelegte>
@property UIButton* addButton;
@property NSMutableArray *array;
@property NSMutableArray *now;
@property BOOL select;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backview2.jpeg"]];
    _now = [[NSMutableArray alloc] init];
    //正常创建自定义cell
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //注册
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"111"];
    _array = [[NSMutableArray alloc] init];
    [_array addObject:@"西安"];
    
    
    for(int i = 0; i < _array.count; i++) {
        [self creatPost:_array[i]];
    }
    
    //设置添加按钮 通过“数组 乘 组距”来完成
    _addButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [_addButton setFrame:CGRectMake(330, 600, 50, 50)];
    
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    _addButton.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    [_addButton addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addButton];
    
}

- (void)creatPost: (NSString *)str {
    //创建URL字符串:
    NSString *str0 = [NSString stringWithFormat:@ "https://v0.yiketianqi.com/api?unescape=1&version=v91&appid=16428232&appsecret=fxX3iIuF&ext=&cityid=&city=%@",str];
    //NSString *str0 = [NSString stringWithFormat:@"https://yiketianqi.com/api?version=v9&appid=21253683&appsecret=0LXrEm6Y&city=%@", str];
    //这一行将URL字符串进行URL编码，确保其中的特殊字符不会破坏URL的结构。这是为了处理用户输入的城市名中可能包含的特殊字符。
    str0 = [str0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //创建NSURL对象
    NSURL *url = [NSURL URLWithString:str0]; //NSURL的类方法
    //使用NSURL对象创建一个NSURLRequest对象
    NSURLRequest* request = [NSURLRequest requestWithURL:url]; //NSURLRequest的类方法
    //使用NSURLSession发起请求
    NSURLSession *session = [NSURLSession sharedSession];//默认情况下，NSURLSession的网络请求是在后台线程（非主线程）上执行的，这是因为NSURLSession使用的是异步执行的模型，它在后台线程上执行网络操作，以避免在主线程上进行网络请求导致的界面冻结或不响应。
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //将原始数据data解析到dic字典中
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        //[self.now addObject:dic[@"data"][0][@"tem"]];
        [self.now addObject:dic[@"data"][0][@"tem"]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    [dataTask resume];
}

- (void)pressSearch {
    AddViewController *searchVC = [[AddViewController alloc]init];
    searchVC.delegate = self;
    searchVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:searchVC animated:YES completion:nil];
}


//自定义cell方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_now count] != [_array count]) {
        return 0;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111" forIndexPath:indexPath];
    cell.nameLabel.text = _array[indexPath.row];
    cell.nowLabel.text = _now[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

//- (void)pressContent:(NSMutableArray *)array {
//    [_array addObject:array];
//    //[self creatPost: _array[[_array count] - 1]];
//    [self creatPost:_array.lastObject];
//    [_tableView reloadData];
//}

- (void)pressContent:(NSMutableArray *)array {
    
    NSString *newCity = array.lastObject;
    
    //判断是否已存在于数组中
    if ([_array containsObject:newCity]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"所选地区已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [_array addObject:newCity];
    
    [self creatPost:newCity];
    
    [_tableView reloadData];
    
}

@end
