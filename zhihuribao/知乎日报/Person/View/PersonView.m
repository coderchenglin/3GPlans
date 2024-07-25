//
//  PersonView.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import "PersonView.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation PersonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(myWidth / 20);
        make.top.equalTo(self).offset(myHeight / 15);
        make.size.equalTo(@30);
    }];
    
    //头像按钮
    self.headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headButton setImage:[UIImage imageNamed:@"1-5.jpeg"] forState:UIControlStateNormal];
    self.headButton.layer.cornerRadius = 48;
    self.headButton.layer.masksToBounds = YES;
    [self addSubview:self.headButton];
    [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(myHeight / 7);
        make.size.equalTo(@100);
    }];
    //名字Label
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"成林";
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:35]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(myHeight / 4.3);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@(myWidth));
        make.height.equalTo(@(myHeight / 10));
    }];
    
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 2, myWidth, myHeight / 7) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //令tableview不能滑动
    self.tableView.scrollEnabled = NO;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(myHeight / 3);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@(myWidth));
        make.height.equalTo(@(myHeight / 6));
    }];
    [self.tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"Collection"];
    
    return self;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"Collection" forIndexPath:indexPath];
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //右侧配饰
    return self.cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"我的收藏");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CollectView" object:nil userInfo:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
