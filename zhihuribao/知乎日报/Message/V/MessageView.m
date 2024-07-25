//
//  MessageView.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import "MessageView.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation MessageView

// *
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.longDataArray = [[NSMutableArray alloc] init];
    self.shortDataArray = [[NSMutableArray alloc] init];
    self.longOpenFlagArray = [[NSMutableArray alloc] init];
    self.shortOpenFlagArray = [[NSMutableArray alloc] init];
    //接收MessageController发送的通知，同时接受传过来的值，一个字典，里面存了长评论的数组和长回复的数组
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiLongHeight:) name:@"TransLongHeightDictionary" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiShortHeight:) name:@"TransShortHeightDictionary" object:nil];
    
    //接收MessageController发送到通知，同时接受传过来的值，保存网络请求下来的数据的字典
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiLong:) name:@"TransLongDictionary" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiShort:) name:@"TransShortDictionary" object:nil];
    
    //接收并存储下所有内容后，开始画UI
    [self createUI];
    
    //设置tableView的大小，协议，分割样式，背景颜色
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 10, myWidth, myHeight * 9 / 10) style:UITableViewStyleGrouped];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.messageTableView.backgroundColor = [UIColor systemGray6Color];
    [self addSubview:self.messageTableView];
    
    [self.messageTableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"Message"];

    return self;
}

//设置给个cell单元格 *
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.messageCell = [self.messageTableView dequeueReusableCellWithIdentifier:@"Message" forIndexPath:indexPath];
    self.messageCell.backgroundColor = [UIColor whiteColor];
    self.messageCell.userInteractionEnabled = YES;
    self.messageCell.selectionStyle = UITableViewCellAccessoryNone;
    
    if (self.longNumber && self.shortNumber) {  //有短评也有长评----------------------------------------------------------
        if (indexPath.section == 0) { //长评论
            
            [self.messageCell.headImageView sd_setImageWithURL:self.longDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]]; //头像
            self.messageCell.nameLabel.text = self.longDataArray[indexPath.row][0];//用户名
            self.messageCell.showLabel.text = self.longDataArray[indexPath.row][1];//内容
            self.messageCell.timeLabel.text = [self getTimeFromTimestamp:self.longDataArray[indexPath.row][3]];//时间
            if ([self.longDataArray[indexPath.row] count] == 6) { //如果此评论有回复的话
                if ([self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {//如果打开状态为0的话
                    self.messageCell.replyLabel.numberOfLines = 2; //行数设为2
                } else {
                    self.messageCell.replyLabel.numberOfLines = 0; //否则行数为自适应
                }
                //回复的格式化内容
                NSString *replyString = [[NSString alloc] initWithFormat:@"//%@：%@", self.longDataArray[indexPath.row][4], self.longDataArray[indexPath.row][5]];
                self.messageCell.replyLabel.text = replyString;
            } else {
                //没有评论就设为空
                self.messageCell.replyLabel.text = @"";
            }
            self.messageCell.openButton.tag = indexPath.row * 2 + 1;  //长评奇数
            //设置按钮不同状态的文字
            if ([self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                [self.messageCell.openButton setTitle:@"点击展开" forState:UIControlStateNormal];
            } else {
                [self.messageCell.openButton setTitle:@"收起" forState:UIControlStateNormal];
            }
            [self.messageCell.openButton addTarget:self action:@selector(pressOpen:) forControlEvents:UIControlEventTouchUpInside];
            //回复的高度大于40再显示按钮，否则就显示按钮
            if ([self.longReplyHeightArray[indexPath.row] floatValue] > 40) {
                self.messageCell.openButton.hidden = NO;
            } else {
                self.messageCell.openButton.hidden = YES;
            }
        } else {
            //section == 1是短评
            [self.messageCell.headImageView sd_setImageWithURL:self.shortDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
            self.messageCell.nameLabel.text = self.shortDataArray[indexPath.row][0];
            self.messageCell.showLabel.text = self.shortDataArray[indexPath.row][1];
            self.messageCell.timeLabel.text = [self getTimeFromTimestamp:self.shortDataArray[indexPath.row][3]];
            
            if ([self.shortDataArray[indexPath.row] count] == 6) {
                if ([self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                    self.messageCell.replyLabel.numberOfLines = 2;
                } else {
                    self.messageCell.replyLabel.numberOfLines = 0;
                }
                NSString *replyString = [[NSString alloc] initWithFormat:@"//%@：%@", self.shortDataArray[indexPath.row][4], self.shortDataArray[indexPath.row][5]];
                self.messageCell.replyLabel.text = replyString;
            } else {
                self.messageCell.replyLabel.text = @"";
            }
            self.messageCell.openButton.tag = indexPath.row * 2;
            //按钮的文字
            if ([self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                [self.messageCell.openButton setTitle:@"点击展开" forState:UIControlStateNormal];
            } else {
                [self.messageCell.openButton setTitle:@"收起" forState:UIControlStateNormal];
            }
            [self.messageCell.openButton addTarget:self action:@selector(pressOpen:) forControlEvents:UIControlEventTouchUpInside];
            if ([self.shorReplytHeightArray[indexPath.row] floatValue] > 40) {
                self.messageCell.openButton.hidden = NO;
            } else {
                self.messageCell.openButton.hidden = YES;
            }
        }
    } else if (self.longNumber) {  //只有长评----------------------------------------------------------
        
        [self.messageCell.headImageView sd_setImageWithURL:self.longDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
        self.messageCell.nameLabel.text = self.longDataArray[indexPath.row][0];
        self.messageCell.showLabel.text = self.longDataArray[indexPath.row][1];
        self.messageCell.timeLabel.text = [self getTimeFromTimestamp:self.longDataArray[indexPath.row][3]];
        if ([self.longDataArray[indexPath.row] count] == 6) {
            if ([self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                self.messageCell.replyLabel.numberOfLines = 2;
            } else {
                self.messageCell.replyLabel.numberOfLines = 0;
            }
            NSString *replyString = [[NSString alloc] initWithFormat:@"//%@：%@", self.longDataArray[indexPath.row][4], self.longDataArray[indexPath.row][5]];
            self.messageCell.replyLabel.text = replyString;
        } else {
            self.messageCell.replyLabel.text = @"";
        }
        self.messageCell.openButton.tag = indexPath.row * 2 + 1;
        //按钮的文字
        if ([self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
            [self.messageCell.openButton setTitle:@"点击展开" forState:UIControlStateNormal];
        } else {
            [self.messageCell.openButton setTitle:@"收起" forState:UIControlStateNormal];
        }
        [self.messageCell.openButton addTarget:self action:@selector(pressOpen:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.longReplyHeightArray[indexPath.row] floatValue] > 40) {
            self.messageCell.openButton.hidden = NO;
        } else {
            self.messageCell.openButton.hidden = YES;
        }
    } else {  //只有短评----------------------------------------------------------
        
        [self.messageCell.headImageView sd_setImageWithURL:self.shortDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
        self.messageCell.nameLabel.text = self.shortDataArray[indexPath.row][0];
        self.messageCell.showLabel.text = self.shortDataArray[indexPath.row][1];
        self.messageCell.timeLabel.text = [self getTimeFromTimestamp:self.shortDataArray[indexPath.row][3]];
        if ([self.shortDataArray[indexPath.row] count] == 6) {
            if ([self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                self.messageCell.replyLabel.numberOfLines = 2;
            } else {
                self.messageCell.replyLabel.numberOfLines = 0;
            }
            NSString *replyString = [[NSString alloc] initWithFormat:@"//%@：%@", self.shortDataArray[indexPath.row][4], self.shortDataArray[indexPath.row][5]];
            self.messageCell.replyLabel.text = replyString;
        } else {
            self.messageCell.replyLabel.text = @"";
        }
        self.messageCell.openButton.tag = indexPath.row * 2;
        //按钮的文字
        if ([self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
            [self.messageCell.openButton setTitle:@"点击展开" forState:UIControlStateNormal];
        } else {
            [self.messageCell.openButton setTitle:@"收起" forState:UIControlStateNormal];
        }
        [self.messageCell.openButton addTarget:self action:@selector(pressOpen:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.shorReplytHeightArray[indexPath.row] floatValue] > 40) {
            self.messageCell.openButton.hidden = NO;
        } else {
            self.messageCell.openButton.hidden = YES;
        }
    }
    return self.messageCell;
}

//section数 *
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.longNumber && self.shortNumber) {
        return 2;
    } else {
        return 1;
    }
}

//section的row数 *
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.longNumber && self.shortNumber) {
        if (section == 0) {
            return self.longNumber;
        } else {
            return self.shortNumber;
        }
    } else if (self.longNumber) {
        return self.longNumber;
    } else {
        return self.shortNumber;
    }
}

//计算出cell每排高度 （这是重点）*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前cell，为了设置当前cell的行数numberOfLines
    MessageTableViewCell *nowCell = [self.messageTableView cellForRowAtIndexPath:indexPath];
    if (self.longNumber && self.shortNumber) {
        if (indexPath.section == 0) { //高度大于40，并且状态为没展开就将它设为2
            if ([self.longReplyHeightArray[indexPath.row] floatValue] > 40 && [self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                nowCell.replyLabel.numberOfLines = 2;
                return [self.longHeightArray[indexPath.row] floatValue] + 36 + 90;
            } else {
                nowCell.replyLabel.numberOfLines = 0;
                return [self.longHeightArray[indexPath.row] floatValue] + [self.longReplyHeightArray[indexPath.row] floatValue] + 90;
            }
        } else {
            if ([self.shorReplytHeightArray[indexPath.row] floatValue] > 40 && [self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
                nowCell.replyLabel.numberOfLines = 2;
                return [self.shortHeightArray[indexPath.row] floatValue] + 36 + 90;
            } else {
                nowCell.replyLabel.numberOfLines = 0;
                return [self.shortHeightArray[indexPath.row] floatValue] + [self.shorReplytHeightArray[indexPath.row] floatValue] + 90;
            }
        }
    } else if (self.longNumber) { //只有长评
        if ([self.longReplyHeightArray[indexPath.row] floatValue] > 40 && [self.longOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
            nowCell.replyLabel.numberOfLines = 2;
            return [self.longHeightArray[indexPath.row] floatValue] + 36 + 90;
        } else {
            nowCell.replyLabel.numberOfLines = 0;
            return [self.longHeightArray[indexPath.row] floatValue] + [self.longReplyHeightArray[indexPath.row] floatValue] + 90;
        }
    } else {
        //只有短评
        if ([self.shorReplytHeightArray[indexPath.row] floatValue] > 40 && [self.shortOpenFlagArray[indexPath.row] isEqualToString:@"0"]) {
            nowCell.replyLabel.numberOfLines = 2;
            return [self.shortHeightArray[indexPath.row] floatValue] + 36 + 90;
        } else {
            nowCell.replyLabel.numberOfLines = 0;
            return [self.shortHeightArray[indexPath.row] floatValue] + [self.shorReplytHeightArray[indexPath.row] floatValue] + 90;
        }
    }
}

//与下面一同作用才能设置section头标题 *
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= [UIColor whiteColor];
    NSString *string = [[NSString alloc] init];
    if (self.longNumber && self.shortNumber) {
        if (section == 0) {
            string = [[NSString alloc] initWithFormat:@"%ld条长评论", self.longNumber];
        } else {
            string = [[NSString alloc] initWithFormat:@"%ld条短评论", self.shortNumber];
        }
    } else if (self.longNumber) {
        string = [[NSString alloc] initWithFormat:@"%ld条长评论", self.longNumber];
    } else {
        string = [[NSString alloc] initWithFormat:@"%ld条短评论", self.shortNumber];
    }
    header.textLabel.text = string;
    header.textLabel.textColor = [UIColor blackColor];
    [header.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    self.allMessageNumber = [[NSString alloc] initWithFormat:@"%ld条评论", self.longNumber + self.shortNumber];
    self.titleLabel.text = self.allMessageNumber; //设置顶部Label
    return @"111";
}

//设置头标题高度 *
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//设置脚视图高度 *
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
//设置脚视图 *
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

// 画UI *
- (void)createUI {
    //顶部视图
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight / 10)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
    [self.topView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(myWidth / 20); //左对齐偏一点
        make.top.equalTo(self.topView).offset(myWidth / 8); //顶部对齐偏一点
        make.size.equalTo(@30); //长宽为30的正方形
    }];
    //顶部标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"评论";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [self.topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(0); //左对齐
        make.top.equalTo(self.topView).offset(myWidth / 10); //高度向下偏一点
        make.width.equalTo(@(myWidth)); //宽度为屏宽
        make.height.equalTo(@(myWidth / 8)); //高度为 myWidth / 8
    }];
    //顶部的横线
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = [UIColor systemGray6Color];
    self.lineLabel.text = @"";
    [self.topView addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView).offset(0); //贴着topView底部
        make.left.equalTo(self.topView).offset(0); //左对齐
        make.width.equalTo(@(myWidth)); //宽为屏宽
        make.height.equalTo(@1); //高度为1的横线
    }];
}

//接收网络请求下来的长字典数据后的方法 *
- (void)notiLong:(NSNotification*)sender {
    self.longNumber = [sender.userInfo[@"comments"] count];
    for (int i = 0; i < self.longNumber; i++) {
        self.tempArray = [[NSMutableArray alloc] init];
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"author"]];  //1
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"content"]]; //2
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"avatar"]];  //3
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"time"]];    //4
        if ([sender.userInfo[@"comments"][i] objectForKey:@"reply_to"]) {
            [self.tempArray addObject:sender.userInfo[@"comments"][i][@"reply_to"][@"author"]];   //5
            [self.tempArray addObject:sender.userInfo[@"comments"][i][@"reply_to"][@"content"]];  //6
        }
        [self.longDataArray addObject:self.tempArray];
    }
    //判断是否打开的标志 0为没展开 1为展开
    //开始全部初始化为0
    for (int i = 0; i < self.longNumber; i++) {
        [self.longOpenFlagArray addObject:@"0"];
    }
    
}

//接收网络请求下来的短字典数据后的方法 *
- (void)notiShort:(NSNotification*)sender {
    self.shortNumber = [sender.userInfo[@"comments"] count];  //存储有几条评论
    for (int i = 0; i < self.shortNumber; i++) {
        self.tempArray = [[NSMutableArray alloc] init];
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"author"]];  //0 作者
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"content"]]; //1 评论内容
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"avatar"]];  //2 头像
        [self.tempArray addObject:sender.userInfo[@"comments"][i][@"time"]];    //3 时间
        if ([sender.userInfo[@"comments"][i] objectForKey:@"reply_to"]) { //如果有的话，回复
            [self.tempArray addObject:sender.userInfo[@"comments"][i][@"reply_to"][@"author"]]; //4 回复的作者
            [self.tempArray addObject:sender.userInfo[@"comments"][i][@"reply_to"][@"content"]];//5 回复的内容
        }
        [self.shortDataArray addObject:self.tempArray]; //短评论和短回复（如果有的话）的所有内容
    }
    //判断是否打开的标志 0为没展开 1为展开
    for (int i = 0; i < self.shortNumber; i++) {
        [self.shortOpenFlagArray addObject:@"0"];
    }
    
}

//接受长评论和长回复字典后的方法 *
- (void)notiLongHeight:(NSNotification*)sender {
    self.longHeightArray = sender.userInfo[@"Height"];    //存储长评论高度
    self.longReplyHeightArray = sender.userInfo[@"Reply"]; //存储长回复高度
    
}

//接受短评论和短回复字典后的方法 *
- (void)notiShortHeight:(NSNotification*)sender {
    self.shortHeightArray = sender.userInfo[@"Height"];   //存储短评论的高度
    self.shorReplytHeightArray = sender.userInfo[@"Reply"]; //存储短评论的高度
    
}

//解除所有观察者 *
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//展开按钮，改变展开标识数组里值 *
- (void)pressOpen:(UIButton *)button {
    if (button.tag % 2) {  //长评的 - tag是奇数
        if ([self.longOpenFlagArray[(button.tag - 1) / 2] isEqualToString:@"0"]) {
            [self.longOpenFlagArray replaceObjectAtIndex:(button.tag - 1) / 2 withObject:@"1"];
        } else {
            [self.longOpenFlagArray replaceObjectAtIndex:(button.tag - 1) / 2 withObject:@"0"];
        }
    } else {  //短评的 - tas是偶数
        if ([self.shortOpenFlagArray[(button.tag) / 2] isEqualToString:@"0"]) {
            [self.shortOpenFlagArray replaceObjectAtIndex:(button.tag) / 2 withObject:@"1"];
        } else {
            [self.shortOpenFlagArray replaceObjectAtIndex:(button.tag) / 2 withObject:@"0"];
        }
    }
    [self.messageTableView reloadData];
}

//时间戳转时间
- (NSString *)getTimeFromTimestamp:(NSString *)timeString { //把时间戳转换为 日期和时间
    double timeValue = [timeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeValue]; //把时间戳数字转换为日期
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *changeTime = [formatter stringFromDate:date];
    return changeTime;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
