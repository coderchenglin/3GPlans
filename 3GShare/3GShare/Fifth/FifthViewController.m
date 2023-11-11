//
//  FifthViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "FifthViewController.h"



@interface FifthViewController ()

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameArray = [[NSArray alloc] initWithObjects:@"我上传的", @"我的信息" , @"我推荐的", @"院系通知", @"设置", @"退出",nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人信息";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册两种自定义cell
    [_tableView registerClass:[SetTableViewCell class] forCellReuseIdentifier:@"set"];
    [_tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"person"];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonTableViewCell *personCell = [_tableView dequeueReusableCellWithIdentifier:@"person" forIndexPath:indexPath];
        personCell.selectionStyle = UITableViewCellSelectionStyleNone;
        personCell.backgroundColor = [UIColor whiteColor];
        personCell.nameLabel.text = @"share小白";
        personCell.descriptionLabel.text = @"数媒/设计爱好者";
        personCell.signatureLabel.text = @"开心了就笑，不开心了就过会再笑";
        personCell.personImageView.image = [UIImage imageNamed:@"works_head.png"];
        return personCell;
    } else {
        SetTableViewCell *setCell = [_tableView dequeueReusableCellWithIdentifier:@"set" forIndexPath:indexPath];
        setCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *name = [[NSString alloc] initWithFormat:@"person%ld.png", indexPath.row + 1];
        setCell.aImageView.image = [UIImage imageNamed:name];
        setCell.backgroundColor = [UIColor whiteColor];
        setCell.mainLabel.text = _nameArray[indexPath.row];
        NSString *name1 = [[NSString alloc] initWithFormat:@"img3.png"];
        NSLog(@"%@",name1);
        setCell.bImageView.image = [UIImage imageNamed:name1];
        return setCell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 6;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self myUpload];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        [self myInformation];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        [self myRecommend];
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        [self notice];
    } else if (indexPath.section == 1 && indexPath.row == 4) {
        [self setUp];
    } else if (indexPath.section == 1 && indexPath.row == 5) {
        [self sigout];
    }
}


- (void)myUpload {
    MyUpViewController *myUp = [[MyUpViewController alloc] init];
    myUp.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:myUp animated:YES completion:nil];
}

- (void)myInformation {
    MyInformationViewController *myInformation = [[MyInformationViewController alloc] init];
    myInformation.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:myInformation animated:YES completion:nil];
}

- (void)myRecommend {
    MyRecommendViewController *recommend = [[MyRecommendViewController alloc] init];
    recommend.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:recommend animated:YES completion:nil];
}

- (void)notice {
    UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"您目前没有通知！" preferredStyle:UIAlertControllerStyleAlert];
    [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:tips animated:YES completion:nil];
}

- (void)setUp {
    SetUpViewController *setUp = [[SetUpViewController alloc] init];
    setUp.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:setUp animated:YES completion:nil];
}

- (void)sigout {
    UIAlertController *tips = [UIAlertController alertControllerWithTitle:nil message:@"需求被驳回" preferredStyle:UIAlertControllerStyleAlert];
    [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:tips animated:YES completion:nil];
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
