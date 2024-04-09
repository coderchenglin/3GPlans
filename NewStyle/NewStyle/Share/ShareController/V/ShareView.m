//
//  ShareView.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "ShareView.h"
#import "ShareTableViewCell.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ShareView () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *targetTableView;  //左侧
@property (nonatomic, strong) UITableView *photoTableView;  //右侧

@end

@implementation ShareView

- (void)viewInit {
    self.backgroundColor = [UIColor colorWithRed:(13.0f / 255.0f) green:(12.0f / 255.0f) blue:(15.0f / 255.0f) alpha:1.0f];
    [self segmentedControlInit];
    [self scrollViewInit];
    [self tableViewInit];
    
}

- (void)segmentedControlInit {
    self.segmentedControl = [[UISegmentedControl alloc] init];
    self.segmentedControl.frame = CGRectMake(80, 55, SIZE_WIDTH - 160, 80);
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:(13.0f / 255.0f) green:(12.0f / 255.0f)blue:(15.0f / 255.0f) alpha:1.0f];
    self.segmentedControl.tintColor = [UIColor colorWithRed:(13.0f / 255.0f) green:(12.0f / 255.0f)blue:(15.0f / 255.0f) alpha:1.0f];
    self.segmentedControl.selectedSegmentTintColor = [UIColor colorWithRed:(13.0f / 255.0f) green:(12.0f / 255.0f)blue:(15.0f / 255.0f) alpha:1.0f];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:(146.0f / 255.0f) green:(145.0f / 255.0f)blue:(155.0f / 255.0f) alpha:1.0f], NSFontAttributeName: [UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:20]} forState:UIControlStateSelected];
    [self.segmentedControl insertSegmentWithTitle:@"目标share" atIndex:1 animated:YES];
    [self.segmentedControl insertSegmentWithTitle:@"美图share" atIndex:1 animated:YES];
    [self.segmentedControl addTarget:self action:@selector(pressSegmented) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 1;
}

- (void)scrollViewInit {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 100, SIZE_WIDTH, SIZE_HEIGHT - 190);
    self.scrollView.tag = 666;
    self.scrollView.contentSize = CGSizeMake(SIZE_WIDTH * 2, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(SIZE_WIDTH, 0)];
    [self addSubview:self.scrollView];
}

- (void)tableViewInit {
    self.targetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT - 190) style:UITableViewStylePlain];
    self.targetTableView.backgroundColor = [UIColor whiteColor];
    self.targetTableView.tag = 0;
    self.targetTableView.delegate = self;
    self.targetTableView.dataSource = self;
    self.targetTableView.separatorColor = [UIColor grayColor];
    self.targetTableView.rowHeight = UITableViewAutomaticDimension;
    self.targetTableView.estimatedRowHeight = 400;
    [self.scrollView addSubview:self.targetTableView];
    [self.targetTableView registerClass:[ShareTableViewCell class] forCellReuseIdentifier:@"share"];
    
    self.photoTableView = [[UITableView alloc] initWithFrame:CGRectMake(SIZE_WIDTH, 0, SIZE_WIDTH, SIZE_HEIGHT - 190) style:UITableViewStylePlain];
    self.photoTableView.backgroundColor = [UIColor whiteColor];
    self.photoTableView.tag = 1;
    self.photoTableView.delegate = self;
    self.photoTableView.dataSource = self;
    self.photoTableView.separatorColor = [UIColor grayColor];
    self.photoTableView.rowHeight = UITableViewAutomaticDimension;
    self.photoTableView.estimatedRowHeight = 400;
    [self.scrollView addSubview:self.photoTableView];
    [self.photoTableView registerClass:[ShareTableViewCell class] forCellReuseIdentifier:@"share2"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        ShareTableViewCell *cell = [self.targetTableView dequeueReusableCellWithIdentifier:@"share" forIndexPath:indexPath];
        return cell;
    } else {
        ShareTableViewCell *cell = [self.photoTableView dequeueReusableCellWithIdentifier:@"share2" forIndexPath:indexPath];
        return cell;
    }
}

- (void)pressSegmented {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        [self.scrollView setContentOffset:CGPointMake(SIZE_WIDTH, 0) animated:YES];
    }
}

- (void)scrollViewDidscroll:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x == 0) {
        _segmentedControl.selectedSegmentIndex = 0;
    } else if (self.scrollView.contentOffset.x == SIZE_WIDTH) {
        _segmentedControl.selectedSegmentIndex = 1;
    }
}

@end
