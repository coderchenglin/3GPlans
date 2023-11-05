//
//  FirstViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "FirstViewController.h"



@interface FirstViewController ()

@property (nonatomic, strong) ShowTableViewCell* cell;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置表格视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 90) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    //设置顶上的视图
    self.view.backgroundColor = [UIColor whiteColor];
//    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
//    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
//    [_falseView addSubview:falseImageView];
    [self.view addSubview:falseImageView];
    
    //设置顶上视图的标题文字
    UILabel *title = [[UILabel alloc] init];
    title.text = @"SHARE";
    title.frame = CGRectMake(170, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
//    [_falseView addSubview:title];
//    [self.view addSubview:title];
    [falseImageView addSubview:title];
    
    _titleArray = [[NSArray alloc] initWithObjects:@"假日", @"国外画册欣赏", @"collection扁平设计", @"版式整理术：高校解决多风格要求", nil];
    _describeArray = [[NSArray alloc] initWithObjects:@"原创-插画-练习习作", @"平面设计——画册设计", @"平面设计——海报设计", @"平面设计——样式设计", nil];
    _timeArray = [[NSArray alloc] initWithObjects:@"15分钟前", @"1小时前", @"30分钟前", @"20分钟前", nil];
    _tipsArray = [[NSArray alloc] initWithObjects:@"share小白", @"share帅哥", @"share时尚", @"share复古", nil];
    
    //如何使用注册使用自定义cell？
    //1. 创建自定义的 UITableViewCell 类：首先，创建一个继承自 UITableViewCell 的自定义单元格类。
    //2. 在我的ViewController的ViewDidLoad中，“注册”自定义单元格类
    //3. 使用自定义的 UITableViewCell 类：在 tableView:cellForRowAtIndexPath: 方法中，指定使用自定义的 UITableViewCell
    [_tableView registerClass:[RollTableViewCell class] forCellReuseIdentifier:@"roll"];
    [_tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
}

//也就是在这个协议函数中，指定使用自定义的UITableViewCell
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RollTableViewCell *rollCell = [_tableView dequeueReusableCellWithIdentifier:@"roll" forIndexPath:indexPath];
        return rollCell;
    } else {
        ShowTableViewCell *showCell = [_tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        _imageName = [[NSString alloc] initWithFormat:@"list_img%ld.png",indexPath.row];
        showCell.showImageView.image = [UIImage imageNamed:_imageName];
        showCell.titleLable.text = _titleArray[indexPath.row - 1];
        showCell.describeLable.text = _describeArray[indexPath.row - 1];
        showCell.timeLable.text = _timeArray[indexPath.row - 1];
        showCell.tipsLable.text = _tipsArray[indexPath.row - 1];
        if (indexPath.row == 1) {
            _look = showCell.lookButton.titleLabel.text;
            _lookNumber = [_look integerValue]; //获取字符串的数字
        }
        return showCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    } else {
        return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 53;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
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
