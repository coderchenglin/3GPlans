//
//  ViewController.m
//  触摸事件
//
//  Created by chenglin on 2024/8/11.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.title = @"手势冲突测试";
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.tableMain = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableMain.delegate = self;
//    self.tableMain.dataSource = self;
//    [self.view addSubview:self.tableMain];
//
//    CGFloat buttonHeight = 50;
//    self.bottomButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.bottomButton.frame = CGRectMake(0, self.view.bounds.size.height - buttonHeight, self.view.bounds.size.width, buttonHeight);
//    [self.bottomButton setTitle:@"点我无压力" forState:UIControlStateNormal];
//    self.bottomButton.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.8 alpha:1.0]; // 设置按钮背景颜色
//    [self.bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.bottomButton addTarget:self action:@selector(bottomButtonTapped) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.bottomButton];
//
////    // 确保 tableView 不被按钮覆盖
////    UIEdgeInsets contentInsets = self.tableMain.contentInset;
////    contentInsets.bottom = buttonHeight;
////    self.tableMain.contentInset = contentInsets;
////    self.tableMain.scrollIndicatorInsets = contentInsets;
//
//
//
//
//
//    //底部是一个绑定了单击手势的backView
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapView)];
//    [_backView addGestureRecognizer:tap];
//
//    //上面是一个常规的tableView
//    _tableMain.tableFooterView = [UIView new];
//    [self.view addSubview:_tableMain];
//    [self.view addSubview:_bottomButton];
//    [self.tableMain addSubview:_backView];
//    //还有一个和tableView同级的button
//    [_bottomButton addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
//
//}
//
//- (void)actionTapView{
//    NSLog(@"backview taped");
//}
//
//- (void)buttonTap {
//    NSLog(@"button clicked!");
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell selected!");
//}
//
//////////---------
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30; // 假设有10个cell
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"cellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.backgroundColor = [UIColor orangeColor]; // 设置cell的背景颜色
//    }
//
//    cell.textLabel.text = @"点我~";
//
//    return cell;
//}
//
//- (void)bottomButtonTapped {
//    NSLog(@"底部按钮被点击");
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化 backView 单击手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapView)];
    [self.backView addGestureRecognizer:tap];
    self.backView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.backView];

    // 配置 tableView
    self.tableMain = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableMain.tableFooterView = [UIView new]; // 去掉多余的分隔线
    self.tableMain.delegate = self;
    self.tableMain.dataSource = self;
    [self.view addSubview:self.tableMain];

    // 配置按钮点击事件
    [self.button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

// backView 的点击事件处理
- (void)actionTapView {
    NSLog(@"backview taped");
}

// button 的点击事件处理
- (void)buttonTap {
    NSLog(@"button clicked!");
}

// tableView 的 cell 被选中的事件处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell selected!");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30; // 假设有10行
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor orangeColor]; // 设置cell的背景颜色与图片一致
    }
    
    cell.textLabel.text = @"点我~"; // 设置cell显示的文本
    cell.textLabel.textColor = [UIColor blackColor]; // 设置文本颜色为黑色
    cell.textLabel.textAlignment = NSTextAlignmentLeft; // 文本左对齐
    
    return cell;
}
@end



