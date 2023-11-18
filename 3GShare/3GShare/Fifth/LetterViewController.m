//
//  LetterViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import "LetterViewController.h"

@interface LetterViewController ()

@end

@implementation LetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameArray = [[NSArray alloc] initWithObjects:@"share小格", @"share小蓝", @"share小明", @"share小雪", nil];
    _timeArray = [[NSArray alloc] initWithObjects:@"07-28 15:24", @"07-28 16:34", @"07-28 19:25", @"07-28 20:34", nil];
    _desArray = [[NSArray alloc] initWithObjects:@"你的作品我很喜欢！", @"谢谢，已关注你", @"为你点赞", @"你好可以问问你是怎么拍的吗？", nil];
    
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
    title.text = @"私信";
    title.frame = CGRectMake(185, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[FollowTableViewCell class] forCellReuseIdentifier:@"letter"];
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *follow = [_tableView dequeueReusableCellWithIdentifier:@"letter" forIndexPath:indexPath];
    NSString *imageName = [[NSString alloc] initWithFormat:@"19-%ld.jpeg", indexPath.row + 1];
    follow.headImageView.image = [UIImage imageNamed:imageName];
    follow.nameLabel.text = _nameArray[indexPath.row];
    follow.timeLabel.text = _timeArray[indexPath.row];
    follow.desLabel.text = _desArray[indexPath.row];
    return follow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
