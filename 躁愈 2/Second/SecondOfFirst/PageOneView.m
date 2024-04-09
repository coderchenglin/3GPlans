//
//  SecondView.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import "PageOneView.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
extern UIColor *colorOfBack;
@implementation PageOneView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = colorOfBack;

    
    [self addTableView];
    
    return self;
}

- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = colorOfBack;
    
    _tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = colorOfBack;
//    self.tableView.backgroundColor = [UIColor redColor]
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:_tableView]; // 将表格视图添加到 View 上
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@-30);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        //        make.height.equalTo(@(SIZE_HEIGHT));
        make.bottom.equalTo(self).mas_offset(-170);
        
//        make.top.equalTo(self);
//        make.left.equalTo(@0);
//        make.width.equalTo(@SIZE_WIDTH);
//        make.height.equalTo(@(SIZE_HEIGHT - 100));
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

}




@end
