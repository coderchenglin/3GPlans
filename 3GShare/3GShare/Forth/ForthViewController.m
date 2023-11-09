//
//  ForthViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "ForthViewController.h"


@interface ForthViewController ()

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _actionArray = [[NSArray alloc] initWithObjects:@"“众乐纪music” 画出一首歌的模样", @"下厨也要美美的，从一条围裙开始——六月围裙创意设计赛", @"篮球世界", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, width, height - 70) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"活动";
    title.frame = CGRectMake(185, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    //注册自定义cell
    [_tableView registerClass:[ActionTableViewCell class] forCellReuseIdentifier:@"action"];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionTableViewCell *actionCell = [_tableView dequeueReusableCellWithIdentifier:@"action" forIndexPath:indexPath];
    NSString *imageName = [[NSString alloc] initWithFormat:@"act%ld.png", indexPath.section + 1 ];
    actionCell.actionImageView.image = [UIImage imageNamed:imageName];
    actionCell.actionLabel.text = _actionArray[indexPath.section];
    return actionCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 225;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
