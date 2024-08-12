//
//  ViewController.m
//  TableViewCell复用
//
//  Created by chenglin on 2024/8/12.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册UITableViewCell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    //将UITableView添加到视图中
    [self.view addSubview:self.tableView];
    
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
//画cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
//    //1.清除之前可能存在的旧数据或子视图
//    cell.textLabel.text = nil;
//    UIView *oldButton = [cell.contentView viewWithTag:1001];
//    if (oldButton) {
//        [oldButton removeFromSuperview];
//    }
    
    if (indexPath.row % 2 == 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(200, 10, 100, 30);
        [button setTitle:@"Button" forState:UIControlStateNormal];
        button.tag = 1001;
        [cell.contentView addSubview:button];
    }
    
    //3. 设置其他cell数据
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    
    return cell;
}


@end
