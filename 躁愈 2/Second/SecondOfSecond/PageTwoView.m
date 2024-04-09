//
//  PageTwoView.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/19.
//

#import "PageTwoView.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
extern UIColor *colorOfBack;
@implementation PageTwoView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = colorOfBack;
    [self addTableView];
    [self addLoad];
    return self;
}

- (void)addTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height + 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = colorOfBack;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 10;
    [self addSubview:self.tableView];
}

- (void)addLoad {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleLarge)];
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor blackColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor clearColor];
}

#pragma mark 加载动画
- (void)showLoadMoreView {
    // 创建和配置加载动画视图
    self.activityIndicator.frame = CGRectMake(0, 0, 320, 33);
    self.activityIndicator.tag = 123; // 设置一个标记以便后续移除
    [self.activityIndicator startAnimating];
    // 将加载动画视图添加到UIScrollView的底部
    self.tableView.tableFooterView = self.activityIndicator;
}
- (void)hideLoadMoreView {
    // 停止加载动画
    UIActivityIndicatorView *activityIndicator = [self.tableView.tableFooterView viewWithTag:123];
    [activityIndicator stopAnimating];
    
    // 隐藏加载动画视图
    self.tableView.tableFooterView = nil;
}

@end
