//
//  CollectView.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/30.
//

#import "CollectView.h"
#import "FreeStyleTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation CollectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//构建界面 *
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self creatMoreUI]; //构建假的顶部视图
    //接受CollectViewController中creatUI传过来的通知，传值是AllTransDataArray
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReceived:) name:@"TransALLDataNoti" object:nil]; //讲传过来的数据 存储起来
    
    //1代表有数据（即有收藏内容），代表没有数据
    if ([self.allTransDataArray count]) {
        self.judgeThings = 1;
    } else {
        self.judgeThings = 0;
    }

    //没有收藏内容的展示界面
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
        //有收藏内容的展示界面
        self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 9.93, myWidth, myHeight * 9 / 10) style:UITableViewStylePlain];
        self.showTableView.backgroundColor = [UIColor systemGray6Color];
        self.showTableView.delegate = self;
        self.showTableView.dataSource = self;
        self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:self.showTableView];
        
        [self.showTableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
    }
    
    return self;
}

//构建表单元 *
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.showCell = [self.showTableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
    self.showCell.mainLabel.text = self.allTransDataArray[indexPath.row][0];//主标题
    self.showCell.subLabel.text = self.allTransDataArray[indexPath.row][1];//副标题
    [self.showCell.showImageView sd_setImageWithURL:self.allTransDataArray[indexPath.row][2] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]]; //图片
    self.showCell.backgroundColor = [UIColor whiteColor];
    return self.showCell;
}

//点击cell *
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *dicString = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    [dic setObject:dicString forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TongWangZhiWang" object:nil userInfo:dic]; //这个字典中存储了当前的index，也就是row值
    //传通知给CollectViewController
}

//UITableView的滑动删除功能 *
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.allTransDataArray removeObjectAtIndex:indexPath.row];
    [self.showTableView reloadData];
    
    //删除完以后，判断是否还有收藏内容
    if ([self.allTransDataArray count]) {
        self.judgeThings = 1;
    } else {
        self.judgeThings = 0;
    }
    
    //由有内容转到无内容，展示以下内容
    if (self.judgeThings == 0) {
        //将当前tableView删除
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

// 下拉刷新 *
//当用户停止拖动滚动视图时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -30) {
        //下拉刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ActionStart" object:nil userInfo:nil];
        [self.showTableView reloadData];
    }
}

//行数 *
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//排数 *
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTransDataArray.count;
}

//每排高度 *
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

//将传过来的数据存储起来 *
- (void)notiReceived:(NSNotification *)sender {
    self.allTransDataArray = sender.userInfo[@"transData"];
    [self initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
}

// 构建假导航栏（顶部视图） *
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

@end
 
