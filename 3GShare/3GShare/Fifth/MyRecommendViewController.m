//
//  MyRecommendViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "MyRecommendViewController.h"


@interface MyRecommendViewController ()

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = [[NSArray alloc] initWithObjects:@"假日", @"国外画册欣赏", @"collection扁平设计", @"版式整理术：高校解决多风格要求", @"我是你先人", nil];
    _describeArray = [[NSArray alloc] initWithObjects:@"原创-插画-练习习作", @"平面设计——画册设计", @"平面设计——海报设计", @"平面设计——样式设计", @"小先人设计", nil];
    _timeArray = [[NSArray alloc] initWithObjects:@"15分钟前", @"1小时前", @"30分钟前", @"20分钟前", @"刚刚", nil];
    _tipsArray = [[NSArray alloc] initWithObjects:@"share小白", @"share帅哥", @"share时尚", @"share复古", @"share柱哥", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(20, 40, 50, 50);
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"我推荐的";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowTableViewCell *showCell = [_tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
    _imageName = [[NSString alloc] initWithFormat:@"list_img%ld.png", indexPath.row + 1];
    showCell.showImageView.image = [UIImage imageNamed:_imageName];
    showCell.titleLable.text = _titleArray[indexPath.row];
    showCell.describeLable.text = _describeArray[indexPath.row];
    showCell.timeLable.text = _timeArray[indexPath.row];
    showCell.tipsLable.text = _tipsArray[indexPath.row];
    return showCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)pressBack:(UIButton*)button {
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
