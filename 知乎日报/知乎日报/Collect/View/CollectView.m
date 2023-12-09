//
//  CollectView.m
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import "CollectView.h"
#import "FreeStyleTableViewCell.h"

@implementation CollectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatMoreUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReceived:) name:@"TransALLDataNoti" object:nil];
    
    if ([self.allTransDataArray count]) {
        self.judgeThings = 1;
    } else {
        self.judgeThings = 0;
    }
    
    if (self.judgeThings == 0) {
        self.tipsLabel = [[UILabel alloc] init];
        self.tipsLabel.text = @"还没有收藏";
        [self.tipsLabel setFont:[UIFont systemFontOfSize:25]];
        self.tipsLabel.textColor = [UIColor systemGrayColor];
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    } else {
        self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 9.93, myWidth, myHeight * 9 / 10) style:UITableViewStylePlain];
        self.showTableView.backgroundColor = [UIColor systemGray6Color];
        self.showTableView.delegate = self;
        self.showTableView.dataSource = self;
        self.showTableView.separatorStyle = UITableViewCellAccessoryNone;
        [self addSubview:self.showTableView];
        
        [self.showTableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.showCell = [self.showTableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
    self.showCell.mainLabel.text = self.allTransDataArray[indexPath.row][0];
    self.showCell.subLabel.text = self.allTransDataArray[indexPath.row][1];
    [self.showCell.showImageView sd_setImageWithURL:self.allTransDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
    self.showCell.backgroundColor = [UIColor whiteColor];
    return self.showCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *dicString = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    [dic setObject:dicString forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TongWangZhiWang" object:nil userInfo:dic];
}

//滑动删除的回调
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.allTransDataArray removeObjectAtIndex:indexPath.row];
    [self.showTableView reloadData];
    
    if ([self.allTransDataArray count]) {
        self.judgeThings = 1;
    } else {
        self.judgeThings = 0;
    }
    
    if (self.judgeThings == 0) {
        
        [self.showTableView removeFromSuperview];
        
        self.tipsLabel = [[UILabel alloc] init];
        self.tipsLabel.text = @"还没有收藏";
        [self.tipsLabel setFont:[UIFont systemFontOfSize:25]];
        self.tipsLabel.textColor = [UIColor systemGrayColor];
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
}

//下拉刷新
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -30) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ActionStart" object:nil userInfo:nil];
        [self.showTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTransDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)notiReceived:(NSNotification *)sender {
    self.allTransDataArray = sender.userInfo[@"transData"];
    [self initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
}

- (void)creatMoreUI {
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight / 10)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
    [self.topView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(myWidth / 20);
        make.top.equalTo(self.topView).offset(myWidth / 8);
        make.size.equalTo(@30);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"我的收藏";
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [self.topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(myWidth / 2.6);
        make.top.equalTo(self.topView).offset(myWidth / 10);
        make.width.equalTo(@(myWidth / 2));
        make.height.equalTo(@(myWidth / 8));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
