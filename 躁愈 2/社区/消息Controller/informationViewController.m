//
//  informationViewController.m
//  new
//
//  Created by mac on 2024/2/28.
//

#import "informationViewController.h"
#import "myTableViewCell.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
extern UIColor *colorOfBack;
extern UIColor *darkerColorOfBack;
@interface informationViewController () <UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic, strong) myTableView* tableview;
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) NSArray* array0;
@property (nonatomic, strong) NSArray* array1;
@property (nonatomic, strong) NSArray* array2;
@property (nonatomic, strong) NSArray* array3;
@end

@implementation informationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorOfBack;
    self.tabBarController.tabBar.barTintColor = colorOfBack;
    [self loadarrays];
    [self navigationadd];
    [self Tableviewadd];
    self.tabBarController.tabBar.barTintColor = darkerColorOfBack;
//    self.tabBarController.tabBar.translucent = NO;
    self.tabBarItem.badgeColor = darkerColorOfBack;

}
- (void) loadarrays {
    self.array0 = @[@"杯莫停", @"十四", @"二十一"];
    self.array1 = @[@"赵医生", @"钱医生", @"孙医生", @"李医生", @"周医生", @"吴医生", @"郑医生"];
    self.array2 = @[@"吃饭了吗？", @"快来点赞", @"谢谢关注", @"擅长情绪相关障碍及精神障碍", @"抑郁、睡眠障碍的药物治疗和心理治疗", @"擅长情绪障碍", @"擅长治疗睡眠障碍、焦虑障碍，抑郁障碍", @"擅长中西医结合治疗精神分裂症", @"擅长治疗抑郁症，双相情感障碍", @"擅长儿童青少年情绪及行为问题"];
    self.array3 = @[@"赞和收藏", @"新增关注", @"评论和@"];
}

- (void) navigationadd {
    
    //设置一个自定义的视图添加到导航栏上。
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 395, 44)];
    
    view1.center = self.navigationController.navigationBar.center;
    view1.backgroundColor = colorOfBack;
    
    //创建一个标题
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 100, 44)];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:25.0];
    title.text = @"消 息";
    title.font = font;
    [view1 addSubview:title];
    
    self.navigationItem.titleView = view1;
}

- (void) Tableviewadd {

    self.tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableview.backgroundColor = [UIColor clearColor];
    
    self.tableview.backgroundColor = colorOfBack;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@110);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@(SIZE_HEIGHT - 100));
//        make.bottom.equalTo(self.navigationController.navigationBar.mas_top);
    }];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 7;
    }
   
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        return 90;
    } else {
        return 90;
    }
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myTableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[myTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    if (indexPath.section == 0) {
        NSString* MyCustomer = @"ReportCell";
        UITableViewCell* cell1 = [self.tableview dequeueReusableCellWithIdentifier: MyCustomer];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: MyCustomer];
        }
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell1.backgroundColor = UIColor.clearColor;
        for (int i = 0; i < 3; i++) {
            UIImageView* imageview = [[UIImageView alloc] init];
            UILabel* label = [[UILabel alloc] init];
            
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i + 6]];
            label.text = self.array3[i];
            
            imageview.layer.cornerRadius = 20;
            imageview.layer.masksToBounds = YES;
            
            imageview.frame = CGRectMake(50+115*i, -10, 60, 60);
            label.frame = CGRectMake(45+117*i, 55, 100, 30);
            
            [cell1.contentView addSubview: imageview];
            [cell1.contentView addSubview: label];
        }
        return cell1;
    } else if (indexPath.section == 1) {
        //cell.backgroundColor = UIColor.blackColor;
        cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row+9]];
        cell.label.text = self.array0[indexPath.row];
        cell.label2.text = self.array2[indexPath.row];
        
        
    } else {
        cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"yisheng%ld.jpg", indexPath.row+1]];
        cell.label.text = self.array1[indexPath.row];
        cell.label2.text = self.array2[indexPath.row + 3];
        
        [cell.button setTitle:@"关注" forState:UIControlStateNormal];
        [cell.button setTitleColor: UIColor.redColor forState:UIControlStateNormal];
        [cell.button setTitle:@"已关注" forState:UIControlStateSelected];
        [cell.button setTitleColor: UIColor.grayColor forState:UIControlStateSelected];
        
        [cell.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.selected = NO;
        
        [cell.contentView addSubview: cell.button];
    }
    
    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    UILabel* lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(15, 5, 200, 20);
    if (section == 1) {
        lable.text = @"我的好友";
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        [view addSubview:lable];
    }
    if (section == 2) {
        lable.text = @"发现更多医生";
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        [view addSubview:lable];
        
    }
    return view;
}


- (void) buttonClicked: (UIButton*) button {
    if (button.selected == NO) {
        button.selected = YES;
        button.layer.borderColor = [UIColor grayColor].CGColor;
    } else {
        button.selected = NO;
        button.layer.borderColor = [UIColor redColor].CGColor;
    }
}
@end
