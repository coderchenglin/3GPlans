//
//  SetUpViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "SetUpViewController.h"

@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameArray = [[NSArray alloc] initWithObjects:@"基本资料", @"修改密码", @"消息设置", @"关于SHARE", @"清除缓存", nil];
    
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
    title.text = @"设置";
    title.frame = CGRectMake(185, 30, 150, 70);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BasicViewController *basic = [[BasicViewController alloc] init];
        basic.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:basic animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    }
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"information" forIndexPath:indexPath];
    cell.label.text = _nameArray[indexPath.row]; //记住这种用法，用数组，配合tableViewcell的下表，也就是indexPath.row的值，来对每一个cell进行初始化
    cell.numberLabel.text = nil;
    cell.goodImageView.image = [UIImage imageNamed:@"img3.png"];
    return cell;
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
