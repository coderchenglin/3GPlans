//
//  KnowView.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/17.
//

//主界面视图

#import "KnowView.h"
#import "FreeStyleTableViewCell.h"

#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation KnowView

//视图的初始化，包括设置背景颜色、添加子视图、注册表格单元格等。 *
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    //创建假的导航栏目
    [self creatFalseView];
    
    //下面的内容
    self.storiesTitle = [[NSMutableArray alloc] init];
    self.storiesHint = [[NSMutableArray alloc] init];
    self.storiesImages = [[NSMutableArray alloc] init];
    self.storiesUrl = [[NSMutableArray alloc] init];
    self.storiesId = [[NSMutableArray alloc] init];
    self.allOffset = 0;//？？
    
    //顶部滚动视图的内容
    self.top_storiesTitle = [[NSMutableArray alloc] init];
    self.top_storiesHint = [[NSMutableArray alloc] init];
    self.top_storiesImage = [[NSMutableArray alloc] init];
    self.top_storiesUrl = [[NSMutableArray alloc] init];
    self.top_storiesId = [[NSMutableArray alloc] init];
    
    //全部信息
    self.allNetworkData = [[NSMutableArray alloc] init];
    self.allTopNetworkData = [[NSMutableArray alloc] init];
    self.allTransURL = [[NSMutableArray alloc] init];
    self.allTransID = [[NSMutableArray alloc] init];
    self.allRollButton = [[NSMutableArray alloc] init]; //存储所有的rollButton
    self.rollLocation = 0; //当前位置
    
    //是否需要再添加视图到滚动视上的标识
    self.UnKnowflag = 0;  //标识是否是第一次配置单元格
    self.againFlag = 0;   //
    
    //设置观察者 - 发起网络请求 - 接收KnowViewController传过来的网络请求转换为字典型数据的信息，并执行方法，将字典型数据解析并存放进入相应数组
    //这里还有可能是KnowViewController的getNewInformation方法传过来的，就是获取陈旧新闻的方法发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetworkModel:) name:@"Network" object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 10, myWidth, myHeight * 1.06) style:UITableViewStyleGrouped]; //分为了两组，滚动视图组，和下面内容组
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//用于表示在 UITableViewCell 中是否有分隔线，此属性有两个枚举值可选，一个有线，一个没有线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tag = 957;  //大的滚动视图
    [self addSubview:self.tableView];
    
    //上面滚动视图rollcell，使用的是系统自带的UItableViewCell，上面直接添加scrollView即可
    //下面内容实用自定义cell
    [self.tableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
    
    return self;
}

//配置表格单元格的内容，包括轮播图、新闻列表和加载更多的小菊花等。 *
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        //首界面轮播图cell
//        NSLog(@"section == %ld self.storiesImages.count == %ld",indexPath.section, self.storiesImages.count);
        self.rollCell = [[UITableViewCell alloc] init];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myWidth)];
        self.scrollView.contentSize = CGSizeMake(myWidth * (self.top_storiesImage.count + 2), myWidth);
        self.scrollView.backgroundColor = [UIColor orangeColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.tag = 111;  //顶部轮播图
        [self.rollCell.contentView addSubview:self.scrollView];
        
        WeakSelf(weakSelf);
        //总图片数
        //self.allIndex = 5;
        self.allIndex = self.top_storiesImage.count;
        //NSLog(@"self.top_storiesImage.count = %lu",(unsigned long)self.top_storiesImage.count);
        //当前中心位置
        self.currentIndex = self.rollLocation; //rollLocation随滑动虽然确定，也就是当前轮播图所处的位置
        
        //设置UIpageControl的属性 - 轮播图等小点点
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = self.allIndex;
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];//选中的小点点的颜色
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];//未选中的小点点的颜色
        [self.rollCell.contentView addSubview:self.pageControl];
        
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.offset(myWidth / 3);
            make.centerX.equalTo(weakSelf.rollCell.contentView);
            make.top.offset(myWidth / 1.1);
            make.width.equalTo(@(myWidth / 2));
            make.height.equalTo(@(myWidth / 10));
        }];
        
        //第一次配置单元格，会配置定时器，加载自动轮播图的按钮，设置轮播图初始偏移量
        if (self.UnKnowflag == 0) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"帅哥哥" repeats:YES];
            [self reloadRollButton];  //加载自动轮播图的图片按钮
            [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO]; //初始的偏移量设置为myWidth，即7张图的第2张图的位置
        } else {
            //不是第一次的话
            for (int i = 0; i < self.allRollButton.count; i++) {
                UIButton *tempButton = self.allRollButton[i];
                tempButton.frame = CGRectMake(myWidth * i, 0, myWidth, myWidth);
                [self.scrollView addSubview:tempButton];
            }
            [self.scrollView setContentOffset:CGPointMake(myWidth * self.rollLocation, 0) animated:NO];
        }
        self.UnKnowflag = 1; //标识为不是第一次配置单元格
        
        return self.rollCell;
    } else if (indexPath.section == 0 && indexPath.row == self.top_storiesImage.count + 1) {
        self.flashCell = [[UITableViewCell alloc] init];
        self.flashCell.backgroundColor = [UIColor clearColor];
        
        //设置小菊花
        [self setFlashFlower];
        
        return self.flashCell;
    } else if (indexPath.section == 0 && indexPath.row != 0) {
        //第一部分除了顶部滚动视图以外的新闻
        self.showCell = [self.tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        self.showCell.mainLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row - 1];//拿全部信息的，第section组的，第一个一维数组（存主标题的数组）的第几个数据，这个几就是indexPath.row - 1，-1是减去第一个section有一个顶部轮播图
        self.showCell.subLabel.text = self.allNetworkData[indexPath.section][1][indexPath.row - 1];//同理，拿到副标题
        [self.showCell.showImageView sd_setImageWithURL:self.allNetworkData[indexPath.section][2][indexPath.row - 1] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]]; //拿到WebView图片
        return self.showCell;
    } else if (indexPath.section == self.allNetworkData.count - 1 && indexPath.row == [self.allNetworkData[indexPath.section][0] count]) {
        //最后一个section的最后一个cell，设置小菊花
        self.flashCell = [[UITableViewCell alloc] init];
        self.flashCell.backgroundColor = [UIColor clearColor];
        
        //设置小菊花
        [self setFlashFlower];
        
        return self.flashCell;
    } else {
        //中间所有其他cell
        self.showCell = [self.tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        self.showCell.mainLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row];
        self.showCell.subLabel.text = self.allNetworkData[indexPath.section][1][indexPath.row];
        [self.showCell.showImageView sd_setImageWithURL:self.allNetworkData[indexPath.section][2][indexPath.row] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
        return self.showCell;
    }
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        if (self.allNetworkData.count == 1) {
//            return 8;
//        } else {
//            return 7;
//        }
//    } else if (section == self.allNetworkData.count - 1) {
//        return 7;
//    } else {
//        return 6;
//    }
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        if (self.allNetworkData.count == 1) {
//            return 7;
//        } else {
//            return 6;
//        }
//    } else if (section == self.allNetworkData.count - 1) {
//        return 6;
//    } else {
//        return 5;
//    }
//}


//每个section的row数 *
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //如果只有一组新闻（5个），那么section1的row为7，给小菊花留的
        if (self.allNetworkData.count == 1) {
//            return 7;
//            return self.storiesImages.count + 2;
            return [self.allNetworkData[section][0] count] + 2;
        } else {
            //不止一组新闻，section1的row为6
//            return 6;
//            return self.storiesImages.count + 1;
            return [self.allNetworkData[section][0] count] +1;
        }
    } else if (section == self.allNetworkData.count - 1) {
//        return 6;  //最后一个section，且不是section1
//        return self.storiesImages.count + 1;
        return [self.allNetworkData[section][0] count] + 1;
    } else {
//        return 5;  //其他section
//        NSLog(@"self.storiesImages.count == %ld",self.storiesImages.count);
//        return self.storiesImages.count;
        return [self.allNetworkData[section][0] count];
    }
}

//有多少个section *
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allNetworkData.count;
}

//每排的高度 *
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        //轮播图的高度为myWidth
        return myWidth;
    } else {
        //其他排的高度均设为100
        return 100;
    }
}

//组间距 *
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 30; //这里标了那个中间的日期，即头标题
    }
}

//与下面一同作用才能设置头标题 *
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= [UIColor clearColor];
    NSString *string = [[NSString alloc] initWithFormat:@"%@     ——————————————", self.allNetworkData[section][4]]; //解析后的日期 （几月几日）
    header.textLabel.text = string;
    [header.textLabel setFont:[UIFont systemFontOfSize:14]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"111";
}

//cell选中 - 1 *
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        //NSLog(@"rollButton");
    } else {
        FreeStyleTableViewCell *nowCell = [self.tableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"%@", nowCell.mainLabel.text);
        //NSLog(@"either");
        NSInteger atLocation = 0;
        if (indexPath.section == 0) {
            atLocation = indexPath.row - 1;
        } else {
//            atLocation = indexPath.section * 6 + indexPath.row;
            atLocation = [self totalNumberOfRows:indexPath.section] + indexPath.row - 1; //当前section之前到所有row总和+当前section到row数 -1 （也就是减掉第一个section的多出来的轮播图）
        }
        NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", (long)atLocation];
        //NSLog(@"atLocation = %ld", (long)atLocation);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.allTransURL forKey:@"url"];
        [dic setObject:self.allTransID forKey:@"id"];
        [dic setObject:stringLocation forKey:@"location"];
        [dic setObject:self.allNetworkData forKey:@"allData"];
        //传给KnowViewController，以字典的形式
        [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
    }
}

//计算当前section之前的所有row总和，包括第一个轮播图cell
- (NSInteger)totalNumberOfRows:(NSInteger)currentSection {
    NSInteger totalRows = 0;
    for (NSInteger section = 0; section < currentSection ; section++) {
        totalRows += [self.tableView numberOfRowsInSection:section];
    }
    NSLog(@"totalRows = %ld,%d",totalRows,__LINE__);
    return totalRows;
}

//大的scrollView，用于实现下拉加载的逻辑 *
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 957) {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y; //是正值代表在向上滚动，即上拉加载
        //NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY; //计算屏幕差
        if (bottomOffset <= height * 0.9) {
            //上拉了0.1倍的height就加载新数据
            [self.flashView startAnimating]; //加载小菊花，让它转
            
            //发送通知给KnowViewController，加载旧的数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnInformation" object:nil userInfo:nil];
        }
    }
}

//滚动停止事件 *
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //顶部轮播图的scrollView
    if (scrollView.tag == 111) {
        //获取滑动后的位置
        if (self.allOffset < self.scrollView.contentOffset.x) { //向右滑动
            self.currentIndex = (self.currentIndex + 1) % self.allIndex;
        } else if (self.allOffset > self.scrollView.contentOffset.x) { //向左滑动
            self.currentIndex = (self.currentIndex + self.allIndex - 1) % self.allIndex;
        }
        if (self.scrollView.contentOffset.x == myWidth * 6) {
            [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
        }
        if (self.scrollView.contentOffset.x == 0) {
            [self.scrollView setContentOffset:CGPointMake(myWidth * 5, 0) animated:NO];
        }
        self.pageControl.currentPage = self.currentIndex; //改变下面那个小圆点
        self.allOffset = self.scrollView.contentOffset.x; //改变基准值
    }
}

//用户手动拖动scrollView时，暂停计时器 *
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //顶部的轮播图
    if (scrollView.tag == 111) {
        [self.timer invalidate];
        self.timer = [[NSTimer alloc] init];
    }
}

//当用户拖动滚动视图并且手指将要离开屏幕时调用，重新启动计时器 *
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.tag == 111) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"帅哥哥" repeats:YES];
    }
}

//滚动时就调用，确定滚动的位置 - rollLocation *
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //顶部的轮播图
    if (scrollView.tag == 111) {
        self.rollLocation = self.scrollView.contentOffset.x / myWidth - 1; //随着滑动，rollLocation是随时确定的
    }
}

//定时器事件 - 自动轮播 *
- (void)autoScroll:(NSTimer*)timer {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + myWidth, 0) animated:YES];
    
    self.currentIndex = (self.currentIndex + 1) % self.allIndex;
    CGPoint offset = [self.scrollView contentOffset];
    if (offset.x == myWidth * 6) {
        [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
    }
    if (offset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(myWidth * 5, 0) animated:NO];
    }
    self.pageControl.currentPage = self.currentIndex;//改变小圆点
}

//通知传值 *
//将传过来的字典形式的数据，依依解析下来存入相应数组中便于使用，总共有两个大数组，分别存顶部和下面的其他新闻
- (void)getNetworkModel:(NSNotification *)getModel {
    
    self.storiesTitle = [[NSMutableArray alloc] init];
    self.storiesHint = [[NSMutableArray alloc] init];
    self.storiesImages = [[NSMutableArray alloc] init];
    self.storiesUrl = [[NSMutableArray alloc] init];
    self.storiesId = [[NSMutableArray alloc] init];
    
    self.temporaryArray = [[NSMutableArray alloc] init];
    
    //for (int i = 0; i < 6; i++) {
    //for (int i = 0; i < 5; i++) {
    for (int i = 0; i < [getModel.userInfo[@"stories"] count]; i++) { //动态确定有几个新闻
        //一个循环就是一个新闻的所有信息，这些都是一维数组
        //title
        //NSLog(@"getModel.userInfo[@stories] count = %ld,%d",[getModel.userInfo[@"stories"] count],__LINE__);
        NSString *stringOne = getModel.userInfo[@"stories"][i][@"title"];
        [self.storiesTitle addObject:stringOne]; //1 主标题
        //hint
        NSString *stringTwo = getModel.userInfo[@"stories"][i][@"hint"];
        [self.storiesHint addObject:stringTwo];  //2 副标题
        //图片
        NSString *stringThree = getModel.userInfo[@"stories"][i][@"images"][0];
        [self.storiesImages addObject:stringThree]; //3 WebView图片
        //url
        NSString *stringFour = getModel.userInfo[@"stories"][i][@"url"];
        [self.storiesUrl addObject:stringFour];  //4 URl，用于打开网页的
        [self.allTransURL addObject:stringFour];
        //id
        NSString *stringFive = getModel.userInfo[@"stories"][i][@"id"];
        [self.storiesId addObject:stringFive];   //5 id,长评论的API需要用到id
        [self.allTransID addObject:stringFive];
    }
    //二维数组
    [self.temporaryArray addObject:self.storiesTitle]; //0
    [self.temporaryArray addObject:self.storiesHint];  //1
    [self.temporaryArray addObject:self.storiesImages];//2
    [self.temporaryArray addObject:self.storiesUrl];   //3
    //日期
    NSString *datestring = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
    
    [self.temporaryArray addObject:datestring];  //4
    
    [self.temporaryArray addObject:self.storiesId]; //5
    //三维数组 用来存下面新闻的所有信息
    [self.allNetworkData addObject:self.temporaryArray];
    
    //存顶部滚动视图的信息
    if (self.againFlag == 0) {
        self.temporaryArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [getModel.userInfo[@"top_stories"] count]; i++) {
            //一维数组
            NSString *stringOne = getModel.userInfo[@"top_stories"][i][@"title"];
            [self.top_storiesTitle addObject:stringOne];
            
            NSString *stringTwo = getModel.userInfo[@"top_stories"][i][@"hint"];
            [self.top_storiesHint addObject:stringTwo];
            
            NSString *stringThree = getModel.userInfo[@"top_stories"][i][@"image"];
            [self.top_storiesImage addObject:stringThree];
            
            NSString *stringFour = getModel.userInfo[@"top_stories"][i][@"url"];
            [self.top_storiesUrl addObject:stringFour];
            
            NSString *stringFive = getModel.userInfo[@"top_stories"][i][@"id"];
            [self.top_storiesId addObject:stringFive];
        }
        //二维数组
        [self.temporaryArray addObject:self.top_storiesTitle]; //0
        [self.temporaryArray addObject:self.top_storiesHint];  //1
        [self.temporaryArray addObject:self.top_storiesImage]; //2
        [self.temporaryArray addObject:self.top_storiesUrl];   //3
        NSString *string = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
        [self.temporaryArray addObject:string];  //4
        [self.temporaryArray addObject:self.top_storiesId]; //5
        //三维数组 用来存顶部轮播图的全部信息
        [self.allTopNetworkData addObject:self.temporaryArray];
    }
    self.againFlag = 1; //标识已经存过了
    
    [self.flashView stopAnimating];  //让小菊花停止转
    
    [self.tableView reloadData];
}

//移除通知 *
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//图片按钮点击事件 *
- (void)pressButton:(UIButton*)button {
    NSLog(@"%ld", button.tag);
    NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", button.tag]; //tag表示的就是，要展示的5张图片中的第几张
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.top_storiesUrl forKey:@"url"];
    [dic setObject:self.top_storiesId forKey:@"id"];
    [dic setObject:stringLocation forKey:@"location"];
    [dic setObject:self.allTopNetworkData forKey:@"allData"];
    //发送通知，将图片按钮的部分信息，以字典的形式，发给KnowViewController
    [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
}

//创建一个假导航栏 *
- (void)creatFalseView {
    
    self.flaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6, myHeight / 50, myWidth / 3, myHeight / 10)];
    self.flaseLabel.text = @"知乎日报";
    self.flaseLabel.textAlignment = NSTextAlignmentLeft;
    [self.flaseLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    [self addSubview:self.flaseLabel];
    
    self.flaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flaseButton setImage:[UIImage imageNamed:@"1-5.jpeg"] forState:UIControlStateNormal];
    self.flaseButton.layer.cornerRadius = 18;
    self.flaseButton.layer.masksToBounds = YES;
    [self addSubview:self.flaseButton];
    [self.flaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-myHeight / 30);
        make.top.equalTo(self).offset(myHeight / 21);
        make.width.and.height.equalTo(@38);
    }];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 35, myWidth / 5, myHeight / 15)];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.dayLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [self addSubview:self.dayLabel];
    
    self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 20, myWidth / 5, myHeight / 15)];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    [self.monthLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self addSubview:self.monthLabel];
    
    // 设置分割线
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6.5, myHeight / 18, 1, myHeight / 30)];
    self.lineLabel.backgroundColor = [UIColor systemGrayColor];
    self.lineLabel.numberOfLines = 2;
    [self addSubview:self.lineLabel];
    
}

//重新加载自动轮播图的图片按钮 *
- (void)reloadRollButton {
    for (int i = 0; i < self.top_storiesImage.count + 2; i++) {
        if (i < self.top_storiesImage.count) {
            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tempButton.tag = i; //tag表示第几张图，（真正要展示的5张的第几张）
            [tempButton sd_setImageWithURL:self.top_storiesImage[i] forState:UIControlStateNormal];
            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.frame =  CGRectMake(myWidth * (i + 1), 0, myWidth, myWidth); //把第1，2，3，4，5张图，分别放在 第2，3，4，5，6的位置
            [self.scrollView addSubview:tempButton];
            
            //设置渐变色
            UIView *colorView = [[UIView alloc] init];
            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[i]]]]] colorWithAlphaComponent:1.0];
            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[i]]]]] colorWithAlphaComponent:0.0];
            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
            CAGradientLayer *gradient = [CAGradientLayer layer];
            //设置开始和结束位置(设置渐变的方向)
            gradient.startPoint = CGPointMake(0, 0.8);
            gradient.endPoint = CGPointMake(0, 0);
            gradient.colors = colors;
            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth / 1.4);
            [colorView.layer insertSublayer:gradient atIndex:0];
            [tempButton addSubview:colorView];
            
            //设置主标题
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 / 10, myWidth / 7)];
            tempLabel.text = self.top_storiesTitle[i];
            tempLabel.numberOfLines = 0;
            tempLabel.textColor = [UIColor whiteColor];
            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
            [tempButton addSubview:tempLabel];
            
            //设置副标题
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
            subLabel.text = self.top_storiesHint[i];
            subLabel.numberOfLines = 0;
            subLabel.textColor = [UIColor systemGray2Color];
            [tempButton addSubview:subLabel];
            
            [self.allRollButton addObject:tempButton];
        } else if (i == self.top_storiesImage.count) {
            //在第7个位置，放第一张图片
            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tempButton.tag = 0;
            [tempButton sd_setImageWithURL:self.top_storiesImage[0] forState:UIControlStateNormal];//第1张图片
            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.frame =  CGRectMake(myWidth * 6, 0, myWidth, myWidth);
            [self.scrollView addSubview:tempButton]; //在第7个位置
            
            //设置渐变色
            UIView *colorView = [[UIView alloc] init];
            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[0]]]]] colorWithAlphaComponent:1.0];
            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[0]]]]] colorWithAlphaComponent:0.0];
            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
            CAGradientLayer *gradient = [CAGradientLayer layer];
            //设置开始和结束位置(设置渐变的方向)
            gradient.startPoint = CGPointMake(0, 0.8);
            gradient.endPoint = CGPointMake(0, 0);
            gradient.colors = colors;
            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth / 1.4);
            [colorView.layer insertSublayer:gradient atIndex:0];
            [tempButton addSubview:colorView];
            
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 / 10, myWidth / 7)];
            tempLabel.text = self.top_storiesTitle[0];
            tempLabel.numberOfLines = 0;
            tempLabel.textColor = [UIColor whiteColor];
            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
            [tempButton addSubview:tempLabel];
            
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
            subLabel.text = self.top_storiesHint[0];
            subLabel.numberOfLines = 0;
            subLabel.textColor = [UIColor systemGray2Color];
            [tempButton addSubview:subLabel];
            
            [self.allRollButton addObject:tempButton];
        } else {
            //在第1个位置，放第5章图片
            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tempButton.tag = 4;
            [tempButton sd_setImageWithURL:self.top_storiesImage[4] forState:UIControlStateNormal];
            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.frame =  CGRectMake(0, 0, myWidth, myWidth);
            [self.scrollView addSubview:tempButton];
            
            UIView *colorView = [[UIView alloc] init];
            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[4]]]]] colorWithAlphaComponent:1.0];
            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesImage[4]]]]] colorWithAlphaComponent:0.0];
            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
            CAGradientLayer *gradient = [CAGradientLayer layer];
            //设置开始和结束位置(设置渐变的方向)
            gradient.startPoint = CGPointMake(0, 0.8);
            gradient.endPoint = CGPointMake(0, 0);
            gradient.colors = colors;
            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth / 1.4);
            [colorView.layer insertSublayer:gradient atIndex:0];
            [tempButton addSubview:colorView];
            
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 / 10, myWidth / 7)];
            tempLabel.text = self.top_storiesTitle[4];
            tempLabel.numberOfLines = 0;
            tempLabel.textColor = [UIColor whiteColor];
            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
            [tempButton addSubview:tempLabel];
            
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
            subLabel.text = self.top_storiesHint[4];
            subLabel.numberOfLines = 0;
            subLabel.textColor = [UIColor systemGray2Color];
            [tempButton addSubview:subLabel];
            
            [self.allRollButton addObject:tempButton];
        }
    }
}

//给最后一个cell设置小菊花 *
- (void)setFlashFlower {
    //设置小菊花
    self.flashView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge]; //设置大菊花View
    [self.flashCell.contentView addSubview:self.flashView]; //添加到flashCell上
    self.flashView.color = [UIColor grayColor]; //小菊花颜色设置为灰色
    self.flashView.backgroundColor = [UIColor clearColor]; //背景颜色设置为透明色
    self.flashView.hidesWhenStopped = YES; //停下来以后，图片隐藏
    [self.flashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(myWidth));
        make.height.equalTo(@100);
        make.top.equalTo(self.flashCell).offset(0);
        make.left.equalTo(self.flashCell).offset(0);
    }];
}


//提取主色调 - 2
+ (UIColor *)mostColor:(UIImage*)image {
    
    //这行代码定义了一个 bitmapInfo 变量，它用于创建位图上下文（CGBitmapContext）
    //kCGBitmapByteOrderDefault：表示使用默认的字节顺序
    //kCGImageAlphaPremultipliedLast：表示每个像素的颜色分量是预乘的（premultiplied）
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //缩小图片，加快计算速度
    CGSize thumbSize = CGSizeMake(image.size.width/20, image.size.height/20);
    
    //CGColorSpaceCreateDeviceRGB() 函数用于创建一个标准的 RGB 设备颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    //这行代码使用 CGBitmapContextCreate 函数创建一个图形上下文（CGContextRef）
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace,bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage); //这行代码将图像绘制到图形上下文中
    //context: 是目标图形上下文。
    //drawRect: 是指定图像绘制区域的矩形。
    //image.CGImage: 是要绘制的图像的 CGImage 对象。
    CGColorSpaceRelease(colorSpace); //这行代码释放了之前创建的颜色空间，避免内存泄漏
    
    //统计每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context); //这行代码用于获取指向图形上下文数据的指针。通过这个指针，你可以直接访问和操作绘制在图形上下文中的像素数据
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];//这行代码创建了一个NSCountedSet对象，用于统计像素颜色的出现次数。
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = image.size.height / 30; y < thumbSize.height; y++) {
            //int offset = 4 * (x * y);
            int offset = 4 * (thumbSize.width * y + x);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha = data[offset+3];
            //去除透明
            if (alpha > 0) {
                //去除白色
                if (red >= 180 || green >= 180 || blue >= 180) {
                    
                } else {
                    NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                    [cls addObject:clr];
                }
            }
        }
    }
    CGContextRelease(context);
    //找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator]; //枚举器
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) {
            continue;
        }
        MaxCount = tmpCount;
        MaxColor = curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
