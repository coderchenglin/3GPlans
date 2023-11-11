//
//  MyImformationViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "MyInformationViewController.h"

@interface MyInformationViewController ()<NameDelegate>

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameMutableArray = [NSMutableArray arrayWithObjects:@"guanzhu_normal.png", @"guanzhu_normal.png" ,@"guanzhu_normal.png" ,@"guanzhu_normal.png" ,@"guanzhu_normal.png" ,@"guanzhu_normal.png", nil];
    _nameArray = [[NSArray alloc] initWithObjects:@"评论", @"推荐我的", @"新关注的", @"私信", @"活动通知", nil];
    _numberArray = [[NSArray alloc] initWithObjects:@"7", @"9", @"5", @"4", @"1", nil];
    
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
    title.text = @"我的信息";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MyInformationTableViewCell class] forCellReuseIdentifier:@"information"];
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"information" forIndexPath:indexPath];
    cell.label.text = _nameArray[indexPath.row];
    cell.numberLabel.text = _numberArray[indexPath.row];
    cell.goodImageView.image = [UIImage imageNamed:@"img3.png"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"目前没有新内容" preferredStyle:UIAlertControllerStyleAlert];
        [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:tips animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"目前没有新内容" preferredStyle:UIAlertControllerStyleAlert];
        [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:tips animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        FollowViewController *follow = [[FollowViewController alloc] init];
        follow.delegate = self;
        follow.nameMutableArray = _nameMutableArray;
        follow.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:follow animated:YES completion:nil];
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tranName:(NSMutableArray *)nameMutableArray {
    for (int i = 0; i < 6; i++) {
        [_nameMutableArray replaceObjectAtIndex:i withObject:nameMutableArray[i]];
    }
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
