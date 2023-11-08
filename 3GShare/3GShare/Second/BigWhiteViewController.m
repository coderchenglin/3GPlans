//
//  BigWhiteViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import "BigWhiteViewController.h"
#import "ShowTableViewCell.h"

@interface BigWhiteViewController ()

@end

@implementation BigWhiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(25, 35, 50, 50);
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    UIView* newView = [[UIView alloc] init];
    newView.backgroundColor = [UIColor whiteColor];
    newView.frame = CGRectMake(0, 200, width, height - 200);
    [self.view addSubview:newView];
    
    _titleArray = [[NSArray alloc] initWithObjects:@"Icon Of Baymax", @"每一个人都需要一个大白", nil];
    _describeArray = [[NSArray alloc] initWithObjects:@"share小白  原创-UI-Icon", @"share小王  原创作品-摄影", nil];
    
    //创建数据视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 200) style:UITableViewStylePlain];
    //这个属性选择就两种，要么有细线分割，要么没有
    //UITableViewCellSeparatorStyleNone:表示不显示分隔符线 看起来像连在一起
    //UITableViewCellSeparatorStyleSingleLine:表示在单元格之间显示单一横线作为分隔符。这是分割不同单元格的常见方式，呈现为细线分隔每个单元格。（默认）
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //这个是设置子视图随父视图的改变，相应做改变
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [newView addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    
    //1. 在我的UITableView实例中“注册”自定义的UITableViewCell类
    //复用类ShowTableViewCell
    [_tableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//2.调用UITableViewDataSourse数据源方法
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建单元格，有可重用的就用，没有就创建新的
    ShowTableViewCell *showCell = [_tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
    NSString *imageName = [[NSString alloc] initWithFormat:@"dabai%ld.jpg", indexPath.row + 1];
    showCell.showImageView.image = [UIImage imageNamed:imageName];
    showCell.titleLable.text = _titleArray[indexPath.row];
    showCell.describeLable.text = _describeArray[indexPath.row];
    return showCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
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
