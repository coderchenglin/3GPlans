//
//  mineTableview.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineTableview.h"
#import "mineTableViewCell.h"
extern UIColor *colorOfBack;
@implementation mineTableview

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    self.backgroundColor = colorOfBack;
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[mineTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (NSInteger) numberOfSections {
    return 1;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    mineTableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
//    cell.backgroundColor = UIColor.yellowColor;
    [cell.imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"jiantou.png"]]];
    if (indexPath.row == 0) {
        cell.label.text = @"联系医生";
    } else if (indexPath.row == 1) {
        cell.label.text = @"密码";
    } else if (indexPath.row == 2) {
        cell.label.text = @"提醒";
    } else if (indexPath.row == 3) {
        cell.label.text = @"偏好设置";
    } else if (indexPath.row == 4) {
        cell.label.text = @"我的收藏";
    } else {
        cell.label.text = @"导出数据";
    }
    return cell;
    
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* view = [[UIView alloc] init];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"其他";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    label.frame = CGRectMake(15, 0, 100, 28);
    [view addSubview:label];
    return view;
    
}
@end
