//
//  FirstView.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import "FirstView.h"
#import "Masonry.h"
#import "FirstCollectionViewCell.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ButtonTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "FourthTableViewCell.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
extern UIColor *colorOfBack;
@implementation FirstView

#pragma mark 导航栏
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = colorOfBack;
    
    self.Date = [[UILabel alloc] init];
    self.Date.font = [UIFont systemFontOfSize:20];
    self.Date.frame = CGRectMake(10, 56, 30, 20);
    self.Date.textAlignment = NSTextAlignmentCenter; // 水平居中对齐
    [self addSubview:self.Date];
    
    self.Month = [[UILabel alloc] init];
    self.Month.frame = CGRectMake(8, 25 + 56, 35, 13);
    self.Month.font = [UIFont systemFontOfSize:10];
    self.Month.textAlignment = NSTextAlignmentCenter; // 水平居中对齐
    [self addSubview:self.Month];
    
    self.Tip = [[UILabel alloc] init];
    self.Tip.frame = CGRectMake(65, 5 + 54, 100, 30);
    self.Tip.font = [UIFont systemFontOfSize:23];
    [self addSubview:self.Tip];
    
    self.Line = [UIImage imageNamed:@"home_line2.png"];
    self.LineView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 2 + 56, 1, 34)];
    self.LineView.image = self.Line;
    [self addSubview:self.LineView];
    
    self.btn_head = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_head setImage:[UIImage imageNamed:@"zhihugou.jpg"] forState:UIControlStateNormal];
    self.btn_head.frame = CGRectMake(380 - 34, 2 + 55, 32, 32);
    self.btn_head.backgroundColor = [UIColor whiteColor];
    self.btn_head.layer.cornerRadius = self.btn_head.frame.size.width / 2;
    self.btn_head.layer.masksToBounds = YES;
    self.btn_head.clipsToBounds = YES;
    [self addSubview:self.btn_head];
    
    self.pastArray = [[NSMutableArray alloc] init];
    self.pastTimeArray = [[NSMutableArray alloc] init];
    self.allArray = [[NSMutableArray alloc] init];
    
    [self addTableView];
    
    return self;

    
}

- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];

    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.tableView.backgroundColor = colorOfBack;
//    self.tableView.backgroundColor = [UIColor redColor]
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:_tableView]; // 将表格视图添加到 View 上
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@110);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@(SIZE_HEIGHT - 100));
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}



@end
