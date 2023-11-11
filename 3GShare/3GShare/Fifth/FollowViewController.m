//
//  FollowViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "FollowViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameArray = [[NSArray alloc] initWithObjects:@"share小格", @"share小蓝", @"share小明", @"share小雪", @"share萌萌", @"shareLity", nil];
    
    _name = [[NSString alloc] init];
    
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
    title.text = @"新关注的";
    title.frame = CGRectMake(155, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[FollowTableViewCell class] forCellReuseIdentifier:@"follow"];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FollowTableViewCell *followCell = [_tableView dequeueReusableCellWithIdentifier:@"follow" forIndexPath:indexPath];
    followCell.nameLabel.text = _nameArray[indexPath.row];
    NSString *imageName = [[NSString alloc] initWithFormat:@"19-%ld.jpeg", indexPath.row + 1];
    followCell.headImageView.image = [UIImage imageNamed:imageName];
    _name = _nameMutableArray[indexPath.row];
    [followCell.followButton setImage:[UIImage imageNamed:_name] forState:UIControlStateNormal];
    
    if ([_name isEqualToString:@"guanzhu_normal.png"]) {
        followCell.followButton.tag = indexPath.row + 100;
    } else {
        followCell.followButton.tag = indexPath.row;
    }
    [followCell.followButton addTarget:self action:@selector(pressFollow:) forControlEvents:UIControlEventTouchUpInside];
    return followCell;
}

- (void)pressFollow:(UIButton*)button {
    if (button.tag > 99) {
        [button setImage:[UIImage imageNamed:@"guanzhu_pressed.png"] forState:UIControlStateNormal];
        button.tag -= 100;
        [_nameMutableArray replaceObjectAtIndex:button.tag withObject:@"guanzhu_pressed.png"];
    } else {
        [button setImage:[UIImage imageNamed:@"guanzhu_normal.png"] forState:UIControlStateNormal];
        button.tag += 100;
        [_nameMutableArray replaceObjectAtIndex:button.tag - 100 withObject:@"guanzhu_normal.png"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)pressBack:(UIButton*)button {
    [_delegate tranName:_nameMutableArray];
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
