//
//  KnowView.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import "KnowView.h"

@implementation KnowView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatFalseView];
    
    self.storiesTitle = [[NSMutableArray alloc] init];
    self.storiesHint = [[NSMutableArray alloc] init];
    self.storiesImages = [[NSMutableArray alloc] init];
    self.storiesUrl = [[NSMutableArray alloc] init];
    self.storiesId = [[NSMutableArray alloc] init];
    self.allOffset = 0;
    
    self.top_storiesTitle = [[NSMutableArray alloc] init];
    self.top_storiesHint = [[NSMutableArray alloc] init];
    self.top_storiesId = [[NSMutableArray alloc] init];
    self.top_storiesUrl = [[NSMutableArray alloc] init];
    self.top_storiesIamge = [[NSMutableArray alloc] init];
    
    self.allNetworkData = [[NSMutableArray alloc] init];
    self.allTopNetworkData = [[NSMutableArray alloc] init];
    self.allTransURL = [[NSMutableArray alloc] init];
    self.allTransID = [[NSMutableArray alloc] init];
    self.allRollButton = [[NSMutableArray alloc] init];
    self.rollLocation = 0;
    
    //是否需要再添加视图到滚动视图上的标识
    self.UnkNowflag = 0;
    self.againFlag = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetworkModel:) name:@"Network" object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 10, myWidth, myHeight * 1.06)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tag = 957;
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
    
    return self;
}

- (void)creatFalseView {
    
    self.flaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6, myHeight / 50, myWidth / 3, myHeight / 10)];
    self.flaseLabel.text = @"知乎日报";
    self.flaseLabel.textAlignment = NSTextAlignmentLeft;
    [self.flaseLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];//加粗的黑体字
    [self addSubview:self.flaseLabel];
    
    self.flaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flaseButton setImage:[UIImage imageNamed:@"1-5.jpeg"] forState:UIControlStateNormal];
    self.flaseButton.layer.cornerRadius = 18;
    self.flaseButton.layer.masksToBounds = YES;
    [self addSubview:self.flaseButton];
    //Masonry库
    //mas_makeConstraints是方法名，后面一大坨是参数，这个参数是一个块，(void(^)(MASConstraintMaker *)
    [self.flaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-myHeight / 30);
            make.top.equalTo(self).offset(myHeight / 21);
            make.width.and.height.equalTo(@38);
            //make.width.and.height.mas_equalTo(38);
    }];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 35, myWidth / 5, myHeight / 15)];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.dayLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [self addSubview:self.dayLabel];
    
    self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 20, myWidth / 5, myHeight / 15)];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    [self.monthLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self addSubview:self.monthLabel];
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6.5, myHeight / 18, 1, myHeight / 30)];
    self.lineLabel.backgroundColor = [UIColor systemGrayColor];
    self.lineLabel.numberOfLines = 2;
    [self addSubview:self.lineLabel];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
