//
//  AddViewController.m
//  weather_forecast
//
//  Created by chenglin on 2023/11/18.
//

#import "AddViewController.h"

@interface AddViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property UITextField *searchTextFiled;
@property NSMutableArray *searchArray;
@property NSMutableArray *nowArray;
@property UITableView *tableView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backview2.jpeg"]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 110)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 375, 20)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"输入城市，邮政编码或机场位置";
    label.textAlignment = NSTextAlignmentCenter;
    
    _searchTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 300, 40)];
    _searchTextFiled.backgroundColor = [UIColor whiteColor];
    [_searchTextFiled addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];//文本框的编辑内容发生变化时触发
    _searchTextFiled.delegate = self;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 60, 50, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [view addSubview:_searchTextFiled];
    [view addSubview:cancelButton];
    [view addSubview:label];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, 375, 557) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _searchArray = [NSMutableArray array];
    _nowArray = [NSMutableArray array];
}

- (void)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldChange {
    if (_searchTextFiled.text != nil) {
        //这是为了确保在进行新的搜索之前，先清空之前的搜索结果，以避免保存了上一次搜索的结果
        [_searchArray removeAllObjects];
        
        [self creatPost];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_searchTextFiled resignFirstResponder];
}

//这个方法在用户在键盘上点击 "Return" 键时被调用，用于处理文本框的返回操作。
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 放弃文本框的第一响应者状态，即关闭键盘
    [_searchTextFiled resignFirstResponder];
    
    // 返回 YES 表示响应 "Return" 键的操作
    return YES;
}

- (void)creatPost {
    //构建API请求URL
    NSString *str = [NSString stringWithFormat:@"https://geoapi.qweather.com/v2/city/lookup?location=%@&key=7f0d61794aea4090a5d2f5edaaaa48b3",_searchTextFiled.text];
    
    //构建NSURL对象
    NSURL *url = [NSURL URLWithString:str];
    // 创建 NSURLRequest 对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 创建 NSURLSession 对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建数据任务，用于发送网络请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            // 解析返回的 JSON 数据
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            // 提取城市信息数组
            NSArray *basic = objc[@"location"];
            // 遍历城市信息数组
            for(int i = 0; i < basic.count; i++) {
                //提取城市名称
                NSMutableArray * name = basic[i][@"name"];
                //将城市名称添加到数组中
                [self->_searchArray addObject:name];
            }
            
            //在主线程上执行UI操作，更新表格视图
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            
        }
        
    }];
    
    //启动数据任务
    [dataTask resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_searchArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([_searchArray count] != 0) {
        cell.textLabel.text = _searchArray[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    for (int i = 0; i < _array.count; i++) {
//        if ([_searchArray[indexPath.row] isEqualToString:_array[i]]) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"所选地区已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:sureAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//            return;
//        }
//    }
//
//    [self.delegate pressContent:_searchArray[indexPath.row]];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedCity = _searchArray[indexPath.row];
    
    // 判断是否存在于主视图控制器的城市数组中
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        if ([self.delegate didSelectCity:selectedCity]) {
            // 城市已存在，显示提示信息
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"所选地区已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:sureAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    
    // 添加新城市到主视图控制器
    [self.delegate presscontent:selectedCity];
    
    // 关闭当前视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)didSelectCity:(NSString *)selectedCity {
    return [_array containsObject:selectedCity];
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
