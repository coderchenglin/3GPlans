//
//  BasicViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameArray = [[NSArray alloc] initWithObjects:@"头像", @"昵称", @"签名", @"性别", @"邮箱", nil];
    
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
    title.text = @"基本资料";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MyInformationTableViewCell class] forCellReuseIdentifier:@"label"];
    [_tableView registerClass:[MyInformationTableViewCell class] forCellReuseIdentifier:@"sex"];
    [_tableView registerClass:[MyInformationTableViewCell class] forCellReuseIdentifier:@"head"];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"head" forIndexPath:indexPath];
        cell.label.text = _nameArray[indexPath.row];
        cell.aImageView.image = [UIImage imageNamed:@"works_head.png"];
        return cell;
    } else if (indexPath.row == 3) {
        MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"sex" forIndexPath:indexPath];
        cell.label.text = _nameArray[indexPath.row];
        return cell;
    } else if (indexPath.row == 1) {
        MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"label" forIndexPath:indexPath];
        cell.label.text = _nameArray[indexPath.row];
        cell.desLabel.text = @"share小白";
        return cell;
    } else if (indexPath.row == 2) {
        MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"label" forIndexPath:indexPath];
        cell.label.text = _nameArray[indexPath.row];
        cell.desLabel.text = @"开心了就笑，不开心了就过会儿再笑";
        return cell;
    } else {
        MyInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"label" forIndexPath:indexPath];
        cell.label.text = _nameArray[indexPath.row];
        cell.desLabel.text = @"1234567890@qq.com";
        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
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
