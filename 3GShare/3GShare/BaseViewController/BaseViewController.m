//
//  BaseViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//


#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    _firstArray = [[NSArray alloc] initWithObjects:@"如期而至", @"duck学问", @"你的故事", @"八月的惊喜", @"我们在夏枝繁茂时再见", nil];
    _secondArray = [[NSArray alloc] initWithObjects:@"你的故事", @"八月的惊喜", @"如期而至", @"我们在夏枝繁茂时再见", @"duck学问", nil];
    _thirdArray = [[NSArray alloc] initWithObjects:@"我们在夏枝繁茂时再见", @"如期而至", @"duck学问", @"你的故事", @"八月的惊喜", nil];
    //share人
    _oneArray = [[NSArray alloc] initWithObjects:@"share钢蛋", @"share王二麻", @"share和尚", @"share二五", @"share小唐", nil];
    _twoArray = [[NSArray alloc] initWithObjects:@"share王二麻", @"share和尚", @"share钢蛋", @"share小唐", @"share二五", nil];
    _threeArray = [[NSArray alloc] initWithObjects:@"share二五", @"share和尚", @"share王二麻", @"share小唐", @"share钢蛋", nil];
    //时间
    _timeOneArray = [[NSArray alloc] initWithObjects:@"15分钟前", @"1小时前", @"30分钟前", @"20分钟前", @"5小时前", nil];
    _timeTwoArray = [[NSArray alloc] initWithObjects:@"30分钟前", @"20分钟前", @"5小时前", @"15分钟前", @"1小时前", nil];
    _timeThreeArray = [[NSArray alloc] initWithObjects:@"5小时前", @"15分钟前", @"20分钟前", @"1小时前", @"30分钟前", nil];
    //提示
    _tipsOneArray = [[NSArray alloc] initWithObjects:@"过低时", @"说过的", @"十多个", @"古代诗歌", @"根深蒂固", nil];
    _tipsTwoArray = [[NSArray alloc] initWithObjects:@"根深蒂固", @"热狗", @"好地方", @"好地方发呆", @"好烦的", nil];
    _tipsThreeArray = [[NSArray alloc] initWithObjects:@"好烦的烦得很", @"爱上", @"萨芬", @"第三方", @"而非", nil];
    
    //上面的蓝色背景板
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
//    //背景板标题
//    UILabel *title = [[UILabel alloc] init];
//    title.text = @"文章";
//    title.frame = CGRectMake((width - 150)/2, 30, 150, 70);//设置frame剧中
//    title.font = [UIFont systemFontOfSize:28];
//    title.textColor = [UIColor whiteColor];
//    title.textAlignment = NSTextAlignmentCenter; //设置文本居中
//    [_falseView addSubview:title];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, width, height - 225)];//框的位置和大小
    //给segment留40的高度
    _scrollView.contentSize = CGSizeMake(width * 3, height - 225); //画布的位置和大小
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 225) style:UITableViewStylePlain];
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _firstTableView.pagingEnabled = NO;
    _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstTableView.tag = 101;
    [_scrollView addSubview:_firstTableView];
    
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(width, 0, width, height - 225) style:UITableViewStylePlain]; //框的位置和大小
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    _secondTableView.pagingEnabled = NO;
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondTableView.tag = 102;
    [_scrollView addSubview:_secondTableView];
    
    _thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height - 225) style:UITableViewStylePlain];
    _thirdTableView.delegate = self;
    _thirdTableView.dataSource = self;
    _thirdTableView.pagingEnabled = NO;
    _thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thirdTableView.tag = 103;
    [_scrollView addSubview:_thirdTableView];
    
    //给这三个tableView注册cell
    [_firstTableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
    [_secondTableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];
    [_thirdTableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"show"];

//    NSArray *segmentItems = @[@"精选文章", @"热门推荐", @"全部文章"];
//    _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
//    _segmentedControl.frame = CGRectMake(0, 100, width, 40);
//
//    [_segmentedControl addTarget:self action:@selector(pressSegmented:) forControlEvents:UIControlEventValueChanged];
//    _segmentedControl.selectedSegmentIndex = 0;
//    [self.view addSubview:_segmentedControl];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        ShowTableViewCell *cell = [_firstTableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        NSString *name = [[NSString alloc] initWithFormat:@"text%ld.png", indexPath.row + 1];
        cell.showImageView.image = [UIImage imageNamed:name];
        cell.titleLable.text = _firstArray[indexPath.row];
        cell.describeLable.text = _oneArray[indexPath.row];
        cell.timeLable.text = _timeOneArray[indexPath.row];
        cell.tipsLable.text = _tipsOneArray[indexPath.row];
        return cell;
    } else if (tableView.tag == 102) {
        ShowTableViewCell *cell = [_secondTableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        NSString *name = [[NSString alloc] initWithFormat:@"text1%ld.png", indexPath.row + 1];
        cell.showImageView.image = [UIImage imageNamed:name];
        cell.titleLable.text = _secondArray[indexPath.row];
        cell.describeLable.text = _twoArray[indexPath.row];
        cell.timeLable.text = _timeTwoArray[indexPath.row];
        cell.tipsLable.text = _tipsTwoArray[indexPath.row];
        return cell;
    } else {
        ShowTableViewCell *cell = [_thirdTableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        NSString *name = [[NSString alloc] initWithFormat:@"text2%ld.jpeg", indexPath.row +1];
        cell.showImageView.image = [UIImage imageNamed:name];
        cell.titleLable.text = _thirdArray[indexPath.row];
        cell.describeLable.text = _threeArray[indexPath.row];
        cell.timeLable.text = _timeThreeArray[indexPath.row];
        cell.tipsLable.text = _tipsThreeArray[indexPath.row];
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
    return 150;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x == 0) {
        _segmentedControl.selectedSegmentIndex = 0;
    } else if (_scrollView.contentOffset.x == width) {
        _segmentedControl.selectedSegmentIndex = 1;
    } else if (_scrollView.contentOffset.x == width * 2) {
        _segmentedControl.selectedSegmentIndex = 2;
    }
}


- (void)pressSegmented:(UISegmentedControl*)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        [_scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
    } else if (segmentedControl.selectedSegmentIndex == 2) {
        [_scrollView setContentOffset:CGPointMake(width * 2, 0)];
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
