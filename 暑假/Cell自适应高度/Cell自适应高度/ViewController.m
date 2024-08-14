//
//  ViewController.m
//  Cell自适应高度
//
//  Created by chenglin on 2024/8/13.
//
#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//
//    // 设置表格视图的估计行高和自动调整行高
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [self.view addSubview:self.tableView];
//
//    // 模拟一些数据
//    self.dataArray = @[@"Short text.",
//                       @"This is a longer piece of text that should make the cell expand to fit its content. The text will wrap into multiple lines.",
//                       @"Another short text.",
//                       @"Here's an even longer piece of text. We want to see how well the table view cell adapts to this content, ensuring that everything fits within the view without cutting off any text or requiring manual height adjustments."];
//
//    // 注册自定义的cell
//    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"CustomCell"];
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
//
//    // 配置cell
//    cell.customLabel.text = self.dataArray[indexPath.row];
//
//    return cell;
//}




@end
