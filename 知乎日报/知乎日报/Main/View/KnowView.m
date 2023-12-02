//
//  KnowView.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.

//
//#import "KnowView.h"
//#import "FreeStyleTableViewCell.h"
//
//@implementation KnowView
//
//- (instancetype) initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:frame];
//    self.backgroundColor = [UIColor whiteColor];
//
//    [self creatFalseView];
//
//    self.storiesTitle = [[NSMutableArray alloc] init];
//    self.storiesHint = [[NSMutableArray alloc] init];
//    self.storiesImages = [[NSMutableArray alloc] init];
//    self.storiesUrl = [[NSMutableArray alloc] init];
//    self.storiesId = [[NSMutableArray alloc] init];
//    self.allOffset = 0;
//
//    self.top_storiesTitle = [[NSMutableArray alloc] init];
//    self.top_storiesHint = [[NSMutableArray alloc] init];
//    self.top_storiesId = [[NSMutableArray alloc] init];
//    self.top_storiesUrl = [[NSMutableArray alloc] init];
//    self.top_storiesIamge = [[NSMutableArray alloc] init];
//
//    self.allNetworkData = [[NSMutableArray alloc] init];
//    self.allTopNetworkData = [[NSMutableArray alloc] init];
//    self.allTransURL = [[NSMutableArray alloc] init];
//    self.allTransID = [[NSMutableArray alloc] init];
//    self.allRollButton = [[NSMutableArray alloc] init];
//    self.rollLocation = 0;
//
//    //是否需要再添加视图到滚动视图上的标识
//    self.UnkNowflag = 0;
//    self.againFlag = 0;
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetworkModel:) name:@"Network" object:nil];
//
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 10, myWidth, myHeight * 1.06)];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.showsHorizontalScrollIndicator = NO;
//    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.tag = 957;
//    [self addSubview:self.tableView];
//
//    [self.tableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
//
//    return self;
//}
//
////这段代码实现了从通知中获取网络请求返回的数据，并进行解析存储
//- (void)getNetworkModel:(NSNotification *)getModel {
//
//    self.storiesTitle = [[NSMutableArray alloc] init];
//    self.storiesHint = [[NSMutableArray alloc] init];
//    self.storiesImages = [[NSMutableArray alloc] init];
//    self.storiesUrl = [[NSMutableArray alloc] init];
//    self.storiesId = [[NSMutableArray alloc] init];
//
//    self.temporaryArray = [[NSMutableArray alloc] init];
//
//    //NSLog(@"%@",getModel.userInfo);
//
//    for (int i = 0; i < 5; i++) {
//        //主标题
//        NSString *stringOne = getModel.userInfo[@"stories"][i][@"title"];
//        [self.storiesTitle addObject:stringOne];
//        //副标题
//        NSString *stringTwo = getModel.userInfo[@"stories"][i][@"hint"];
//        [self.storiesHint addObject:stringTwo];
//        //图片地址
//        NSString *stringThree = getModel.userInfo[@"stories"][i][@"images"][0];
//        [self.storiesImages addObject:stringThree];
//        //url
//        NSString *stringFour = getModel.userInfo[@"stories"][i][@"url"];
//        [self.storiesUrl addObject:stringFour];
//        [self.allTransURL addObject:stringFour];
//        //id
//        NSString *stringFive = getModel.userInfo[@"stories"][i][@"id"];
//        [self.storiesId addObject:stringFive];
//        [self.allTransID addObject:stringFive];
//    }
//
//    [self.temporaryArray addObject:self.storiesTitle]; //0
//    [self.temporaryArray addObject:self.storiesHint];  //1
//    [self.temporaryArray addObject:self.storiesImages];//2
//    [self.temporaryArray addObject:self.storiesUrl];   //3
//
//    //获取日期
//    NSString *string = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
//    [self.temporaryArray addObject:string];   //4
//
//    [self.temporaryArray addObject:self.storiesId];    //5
//
//    //单个新闻的所有内容都存入了 temporaryArray，再将temporaryArray存入二维数组allNetworkData
//    [self.allNetworkData addObject:self.temporaryArray];
//
//    //如果 againFlag 为 0，表示这是第一次获取数据，此时还会处理头条故事的信息，并将其存储在 allTopNetworkData 数组中。
//    if (self.againFlag == 0) {
//        self.temporaryArray = [[NSMutableArray alloc] init];
//
//        for (int i = 0; i < 5; i++) {
//            NSString *stringOne = getModel.userInfo[@"top_stories"][i][@"title"];
//            [self.top_storiesTitle addObject:stringOne];
//
//            NSString *stringTwo = getModel.userInfo[@"top_stories"][i][@"hint"];
//            [self.top_storiesHint addObject:stringTwo];
//
//            NSString *stringThree = getModel.userInfo[@"top_stories"][i][@"image"];
//            [self.top_storiesIamge addObject:stringThree];
//
//            NSString *stringFour = getModel.userInfo[@"top_stories"][i][@"url"];
//            [self.top_storiesUrl addObject:stringFour];
//
//            NSString *stringFive = getModel.userInfo[@"top_stories"][i][@"id"];
//            [self.top_storiesId addObject:stringFive];
//        }
//        [self.temporaryArray addObject:self.top_storiesTitle]; //0
//        [self.temporaryArray addObject:self.top_storiesHint];  //1
//        [self.temporaryArray addObject:self.top_storiesIamge]; //2
//        [self.temporaryArray addObject:self.top_storiesUrl];   //3
//
//        NSString *string = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
//        [self.temporaryArray addObject:string]; //4
//
//        [self.temporaryArray  addObject:self.top_storiesId]; //5
//
//        [self.allTopNetworkData addObject:self.temporaryArray];
//    }
//    self.againFlag = 1;
//    [self.flashView stopAnimating]; //让小菊花停止转
//    [self.tableView reloadData];
//}
//
////移除对所有通知的观察
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
////按钮事件
//
//
///*
//{"date":"20231129",
//    "stories":[
//        {"image_hue":"0x056ba3",
//            "title":"哥布林鲨存活了 1.3 亿年，为什么没有进化成智慧物种，人为什么区区几百万年就可以达到这样的高度？",
//            "url":"https:\/\/daily.zhihu.com\/story\/9767641",
//            "hint":"犬君拌汪酱 · 2 分钟阅读",
//            "ga_prefix":"112907",
//            "images":["https:\/\/pic1.zhimg.com\/v2-75ac7713671dc4aafeedffd951463a2c.jpg?source=8673f162"],
//            "type":0,
//            "id":9767641},
// */
//
//
////下拉加载逻辑
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.tag == 957) {
//
//        CGFloat height = scrollView.frame.size.height;
//        CGFloat contenOffsetY = scrollView.contentOffset.y;
//        CGFloat bottomOffset = scrollView.contentSize.height - contenOffsetY;
//
//        if (bottomOffset <= height * 0.9) {
//            [self.flashView startAnimating]; //加载小菊花，让它转
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnInformation" object:nil userInfo:nil];
//        }
//    }
//}
//
//
//- (void)creatFalseView {
//
//    self.flaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6, myHeight / 50, myWidth / 3, myHeight / 10)];
//    self.flaseLabel.text = @"知乎日报";
//    self.flaseLabel.textAlignment = NSTextAlignmentLeft;
//    [self.flaseLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];//加粗的黑体字
//    [self addSubview:self.flaseLabel];
//
//    self.flaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.flaseButton setImage:[UIImage imageNamed:@"1-5.jpeg"] forState:UIControlStateNormal];
//    self.flaseButton.layer.cornerRadius = 18;
//    self.flaseButton.layer.masksToBounds = YES;
//    [self addSubview:self.flaseButton];
//    //Masonry库
//    //mas_makeConstraints是方法名，后面一大坨是参数，这个参数是一个块，(void(^)(MASConstraintMaker *)
//    [self.flaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self).offset(-myHeight / 30);
//            make.top.equalTo(self).offset(myHeight / 21);
//            make.width.and.height.equalTo(@38);
//            //make.width.and.height.mas_equalTo(38);
//    }];
//
//    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 35, myWidth / 5, myHeight / 15)];
//    self.dayLabel.textAlignment = NSTextAlignmentCenter;
//    [self.dayLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
//    [self addSubview:self.dayLabel];
//
//    self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myHeight / 20, myWidth / 5, myHeight / 15)];
//    self.monthLabel.textAlignment = NSTextAlignmentCenter;
//    [self.monthLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
//    [self addSubview:self.monthLabel];
//
//    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 6.5, myHeight / 18, 1, myHeight / 30)];
//    self.lineLabel.backgroundColor = [UIColor systemGrayColor];
//    self.lineLabel.numberOfLines = 2;
//    [self addSubview:self.lineLabel];
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        NSLog(@"rollButton");
//    } else {
//        FreeStyleTableViewCell *nowCell = [self.tableView cellForRowAtIndexPath:indexPath];
//        NSLog(@"%@", nowCell.mainLabel.text);
//
//        NSInteger atLocation = 0;
//        if (indexPath.section == 0) {
//            atLocation = indexPath.row - 1;
//        } else {
//            atLocation = indexPath.section * 6 + indexPath.row;
//        }
//
//        NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", (long)atLocation];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:self.allTransURL forKey:@"url"];
//        [dic setObject:self.allTransID forKey:@"id"];
//        [dic setObject:stringLocation forKey:@"location"];
//        [dic setObject:self.allNetworkData forKey:@"allData"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
//
//
//    }
//}
//
////创建单元格
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        //顶部的scrollView
//        self.rollCell = [[UITableViewCell alloc] init];
//        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
//        self.scrollView.contentSize = CGSizeMake(myWidth * (self.top_storiesIamge.count + 2), myWidth);
//        self.scrollView.backgroundColor = [UIColor orangeColor];
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.showsHorizontalScrollIndicator = NO;
//        self.scrollView.showsVerticalScrollIndicator = NO;
//        self.scrollView.delegate = self;
//        self.scrollView.tag == 111;
//        [self.rollCell.contentView addSubview:self.scrollView];
//
//        //总图片数
//        self.allIndex = 5;
//        //当前中心位置
//        self.currentIndex = self.rollLocation;
//
//        self.pageControl = [[UIPageControl alloc] init];
//        self.pageControl.numberOfPages = self.allIndex;
//        self.pageControl.currentPage = 0;
//        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
//        [self.rollCell.contentView addSubview:self.pageControl];
//        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.offset(myWidth / 3);
//            make.top.offset(myWidth / 1.1);
//            make.width.equalTo(@(myWidth / 3));
//            make.height.equalTo(@(myWidth / 10));
//        }];
//
//        //第一次加载的话，设置定时器
//        if (self.UnkNowflag == 0) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"lp" repeats:YES];
//            [self reloadRollButton];
//            [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
//        } else {
//            //给scrollView设置按钮，每张图片都是按钮
//            for (int i = 0; i < self.allRollButton.count; i++) {
//                UIButton *tempButton = self.allRollButton[i];
//                tempButton.frame = CGRectMake(myWidth * i, 0, myWidth, myWidth);
//                [self.scrollView addSubview:tempButton];
//            }
//            [self.scrollView setContentOffset:CGPointMake(myWidth * self.rollLocation, 0) animated:NO];
//        }
//        self.UnkNowflag = 1; //代表不是第一次加载了
//
//        return self.rollCell;
//    } else if (indexPath.section == 0 && indexPath.row == 6) {
//
//        self.flashCell = [[UITableViewCell alloc] init];
//        self.flashCell.backgroundColor = [UIColor clearColor];
//
//        //设置小菊花
//        [self setFlashFlower];
//
//        return self.flashCell;
//    } else if (indexPath.section == 0 && indexPath.row != 0) {
//
//        self.showCell.mainLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row - 1];
//        self.showCell.subLabel.text = self.allNetworkData[indexPath.section][1][indexPath.row - 1];
//        //使用SDWebImage库异步加载网络图片，将图片显示在UITableViewCell中的UIImageView中
//        [self.showCell.showImageView sd_setImageWithURL:self.allNetworkData[indexPath.section][2][indexPath.row - 1] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]]; //placeholderImage：图片加载过程中使用的占位图
//        return self.showCell;
//    } else if (indexPath.section == self.allNetworkData.count - 1 && indexPath.row == [self.allNetworkData[0][0] count]) {
//
//        self.flashCell = [[UITableViewCell alloc] init];
//        self.flashCell.backgroundColor = [UIColor clearColor];
//
//        //设置小菊花
//        [self setFlashFlower];
//        return self.flashCell;
//    } else {
//        self.showCell = [self.tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
//        self.showCell.mainLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row];
//        self.showCell.subLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row];
//        [self.showCell.showImageView sd_setImageWithURL:self.allNetworkData[indexPath.section][2][indexPath.row] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
//        return self.showCell;
//    }
//}
//
//- (void)reloadRollButton {
//    for (int i = 0; i < self.top_storiesIamge.count + 2; i++) {
//
//        if (i < self.top_storiesIamge.count) {
//
//            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            tempButton.tag = i;
//            //异步加载网络图片
//            [tempButton sd_setImageWithURL:self.top_storiesIamge[i] forState:UIControlStateNormal];
//            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//            tempButton.frame = CGRectMake(myWidth * (i + 1), 0, myWidth, myWidth);
//            [self.scrollView addSubview:tempButton];
//
//            //设置渐变色 ---
//            UIView *colorView = [[UIView alloc] init];
//            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
//            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:1.0];
//            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:0.0];
//            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
//            CAGradientLayer *gradient = [CAGradientLayer layer];
//            //设置开始和结束，（渐变的方向）
//            gradient.startPoint = CGPointMake(0, 0.8);
//            gradient.endPoint = CGPointMake(0, 0);
//            gradient.colors = colors;
//            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth/1.4);
//            [colorView.layer insertSublayer:gradient atIndex:0];
//            [tempButton addSubview:colorView];
//
//
//            //设置主标题
//            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 / 10, myWidth / 7)];
//            tempLabel.text = self.top_storiesTitle[i];
//            tempLabel.numberOfLines = 0;
//            tempLabel.textColor = [UIColor whiteColor];
//            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
//            [tempLabel addSubview:tempLabel];
//
//            //设置副标题
//            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
//            subLabel.text = self.top_storiesHint[i];
//            subLabel.numberOfLines = 0;
//            subLabel.textColor = [UIColor systemGray2Color];
//            [tempButton addSubview:subLabel];
//
//            [self.allRollButton addObject:tempButton];
//        } else if (i == self.top_storiesIamge.count) {
//
//            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            tempButton.tag = 0;
//            [tempButton sd_setImageWithURL:self.top_storiesIamge[0] forState:UIControlStateNormal];
//            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//            tempButton.frame = CGRectMake(myWidth * 6, 0, myWidth, myWidth);
//            [self.scrollView addSubview:tempButton];
//
//            //设置渐变色 ---
//            UIView *colorView = [[UIView alloc] init];
//            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
//            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:1.0];
//            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:0.0];
//            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
//            CAGradientLayer *gradient = [CAGradientLayer layer];
//            //设置开始和结束，（渐变的方向）
//            gradient.startPoint = CGPointMake(0, 0.8);
//            gradient.endPoint = CGPointMake(0, 0);
//            gradient.colors = colors;
//            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth/1.4);
//            [colorView.layer insertSublayer:gradient atIndex:0];
//            [tempButton addSubview:colorView];
//
//            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 , myWidth / 7)];
//            tempLabel.text = self.top_storiesTitle[0];
//            tempLabel.numberOfLines = 0;
//            tempLabel.textColor = [UIColor whiteColor];
//            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
//
//            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
//            subLabel.text = self.top_storiesHint[0];
//            subLabel.numberOfLines = 0;
//            subLabel.textColor = [UIColor systemGray2Color];
//            [tempButton addSubview:subLabel];
//
//            [self.allRollButton addObject:tempButton];
//        } else {
//            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            tempButton.tag = 4;
//            [tempButton sd_setImageWithURL:self.top_storiesIamge[4] forState:UIControlStateNormal];
//            tempButton.frame =  CGRectMake(0, 0, myWidth, myWidth);
//            [self.scrollView addSubview:tempButton];
//
//            //设置渐变色 ---
//            UIView *colorView = [[UIView alloc] init];
//            colorView.frame = CGRectMake(0, myWidth / 1.4, myWidth, myWidth - myWidth / 1.4);
//            UIColor *colorOne = [[[self class] mostColor:[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:1.0];
//            UIColor *colorTwo = [[[self class] mostColor:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.top_storiesIamge[i]]]]] colorWithAlphaComponent:0.0];
//            NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
//            CAGradientLayer *gradient = [CAGradientLayer layer];
//            //设置开始和结束，（渐变的方向）
//            gradient.startPoint = CGPointMake(0, 0.8);
//            gradient.endPoint = CGPointMake(0, 0);
//            gradient.colors = colors;
//            gradient.frame = CGRectMake(0, 0, myWidth, myWidth - myWidth/1.4);
//            [colorView.layer insertSublayer:gradient atIndex:0];
//            [tempButton addSubview:colorView];
//
//            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.4, myWidth * 9 / 10, myWidth / 7)];
//            tempLabel.text = self.top_storiesTitle[4];
//            tempLabel.numberOfLines = 0;
//            tempLabel.textColor = [UIColor whiteColor];
//            [tempLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
//            [tempButton addSubview:tempLabel];
//
//            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(myWidth / 20, myWidth / 1.2, myWidth * 9 / 10, myWidth / 7)];
//            subLabel.text = self.top_storiesHint[4];
//            subLabel.numberOfLines = 0;
//            subLabel.textColor = [UIColor systemGray2Color];
//            [tempButton addSubview:subLabel];
//
//            [self.allRollButton addObject:tempButton];
//        }
//    }
//}
//
//
////提取主色调 - 2
//+ (UIColor *)mostColor:(UIImage*)image {
//
//    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
//
//    //缩小图片，加快计算速度
//    CGSize thumbSize = CGSizeMake(image.size.width/20, image.size.height/20);
//
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace,bitmapInfo);
//
//    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
//    CGContextDrawImage(context, drawRect, image.CGImage);
//    CGColorSpaceRelease(colorSpace);
//
//    //统计每个点的像素值
//    unsigned char *data = CGBitmapContextGetData(context);
//    if (data == NULL) {
//        return nil;
//    }
//    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
//
//    for (int x = 0; x < thumbSize.width; x++) {
//        for (int y = image.size.height / 30; y < thumbSize.height; y++) {
//            int offset = 4 * (x * y);
//            int red = data[offset];
//            int green = data[offset+1];
//            int blue = data[offset+2];
//            int alpha = data[offset+3];
//            //去除透明
//            if (alpha > 0) {
//                //去除白色
//                if (red >= 180 || green >= 180 || blue >= 180) {
//
//                } else {
//                    NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
//                    [cls addObject:clr];
//                }
//            }
//        }
//    }
//    CGContextRelease(context);
//    //找到出现次数最多的那个颜色
//    NSEnumerator *enumerator = [cls objectEnumerator];
//    NSArray *curColor = nil;
//    NSArray *MaxColor=nil;
//    NSUInteger MaxCount=0;
//    while ( (curColor = [enumerator nextObject]) != nil) {
//        NSUInteger tmpCount = [cls countForObject:curColor];
//        if ( tmpCount < MaxCount ) {
//            continue;
//        }
//        MaxCount = tmpCount;
//        MaxColor = curColor;
//
//    }
//    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
//}
//
////按钮事件
//- (void)pressButton:(UIButton*)button {
//    NSLog(@"%ld", button.tag);
//    NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", button.tag];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:self.top_storiesUrl forKey:@"url"];
//    [dic setObject:self.top_storiesId forKey:@"id"];
//    [dic setObject:stringLocation forKey:@"location"];
//    [dic setObject:self.allTopNetworkData forKey:@"allData"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
//}
//
//- (void)setFlashFlower {
//    //设置小菊花
//    self.flashView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
//    [self.flashCell.contentView addSubview:self.flashView];
//    self.flashView.color = [UIColor grayColor];
//    self.flashView.backgroundColor = [UIColor clearColor];
//    self.flashView.hidesWhenStopped = YES;
//    [self.flashView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(myWidth));
//        make.height.equalTo(@100);
//        make.top.equalTo(self.flashCell).offset(0);
//        make.left.equalTo(self.flashCell).offset(0);
//    }];
//}
//
//
//
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
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.allNetworkData.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        return myWidth; //头条正方形，高=宽
//    } else {
//        return 100;
//    }
//}
//
////组间距
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    } else {
//        return 30;
//    }
//}
//
////两个方法一起，设置头部标题
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.contentView.backgroundColor = [UIColor clearColor];
//    NSString *string = [[NSString alloc] initWithFormat:@"%@     ——————————————", self.allNetworkData[section][4]];
//    header.textLabel.text = string;
//    [header.textLabel setFont:[UIFont systemFontOfSize:20]];
//}
//-  (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"111"; //是什么都无所谓
//}
//
////滚动停止事件
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (scrollView.tag == 111) {
//        //获取滑动后对位置
//        if (self.allOffset < self.scrollView.contentOffset.x) {
//            //向右滑
//            self.currentIndex = (self.currentIndex + 1) % self.allIndex;
//        } else if (self.allOffset > self.scrollView.contentOffset.x) { //向左滑
//            self.currentIndex = (self.currentIndex + self.allIndex - 1) % self.allIndex;
//        }
//        if (self.scrollView.contentOffset.x == myWidth * 6) {
//            [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
//        }
//        if (self.scrollView.contentOffset.x == 0) {
//            [self.scrollView setContentOffset:CGPointMake(myWidth * 5, 0) animated:NO];
//        }
//        self.pageControl.currentPage = self.currentIndex;
//        self.allOffset = self.scrollView.contentOffset.x;
//
//    }
//
//}
//
////用户手动拖动scrollView时，暂停计时器
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (scrollView.tag == 111) {
//        [self.timer invalidate];
//        self.timer = [[NSTimer alloc] init];
//    }
//}
//
////当scrollView停止拖动之后调用，调用此方法
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    if (scrollView.tag == 111) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"lp" repeats:YES];
//    }
//}
//
////滚动时就调用，确定滚动的位置
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.tag == 111) {
//        self.rollLocation = self.scrollView.contentOffset.x / myWidth - 1;
//    }
//}
//
////定时器事件
//- (void)autoScroll:(NSTimer*)timer {
//    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + myWidth, 0) animated:YES];
//
//    self.currentIndex = (self.currentIndex + 1) % self.allIndex;
//    CGPoint offset = [self.scrollView contentOffset];
//    if (offset.x == myWidth * 6) {
//        [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
//    }
//    if (offset.x == myWidth * 0) {
//        [self.scrollView setContentOffset:CGPointMake(myWidth * 5, 0) animated:NO];
//    }
//    self.pageControl.currentPage = self.currentIndex;
//}
//
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end


#import "KnowView.h"
#import "FreeStyleTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@implementation KnowView

//视图的初始化，包括设置背景颜色、添加子视图、注册表格单元格等。
- (instancetype)initWithFrame:(CGRect)frame {
    
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
    self.top_storiesImage = [[NSMutableArray alloc] init];
    self.top_storiesUrl = [[NSMutableArray alloc] init];
    self.top_storiesId = [[NSMutableArray alloc] init];
    
    self.allNetworkData = [[NSMutableArray alloc] init];
    self.allTopNetworkData = [[NSMutableArray alloc] init];
    self.allTransURL = [[NSMutableArray alloc] init];
    self.allTransID = [[NSMutableArray alloc] init];
    self.allRollButton = [[NSMutableArray alloc] init];
    self.rollLocation = 0;
    
    //是否需要再添加视图到滚动视上的标识
    self.UnKnowflag = 0;
    self.againFlag = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetworkModel:) name:@"Network" object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight / 10, myWidth, myHeight * 1.06) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tag = 957;
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:[FreeStyleTableViewCell class] forCellReuseIdentifier:@"show"];
    
    return self;
}

//配置表格单元格的内容，包括轮播图、新闻列表和加载更多的小菊花等。
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        self.rollCell = [[UITableViewCell alloc] init];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myWidth)];
        self.scrollView.contentSize = CGSizeMake(myWidth * (self.top_storiesImage.count + 2), myWidth);
        self.scrollView.backgroundColor = [UIColor orangeColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.tag = 111;
        [self.rollCell.contentView addSubview:self.scrollView];
        
        //总图片数
        self.allIndex = 5;
        //当前中心位置
        self.currentIndex = self.rollLocation;
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = self.allIndex;
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self.rollCell.contentView addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(myWidth / 3);
            make.top.offset(myWidth / 1.1);
            make.width.equalTo(@(myWidth / 3));
            make.height.equalTo(@(myWidth / 10));
        }];
        
        if (self.UnKnowflag == 0) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"帅哥哥" repeats:YES];
            [self reloadRollButton];
            [self.scrollView setContentOffset:CGPointMake(myWidth, 0) animated:NO];
        } else {
            for (int i = 0; i < self.allRollButton.count; i++) {
                UIButton *tempButton = self.allRollButton[i];
                tempButton.frame = CGRectMake(myWidth * i, 0, myWidth, myWidth);
                [self.scrollView addSubview:tempButton];
            }
            [self.scrollView setContentOffset:CGPointMake(myWidth * self.rollLocation, 0) animated:NO];
        }
        self.UnKnowflag = 1;
        
        return self.rollCell;
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        self.flashCell = [[UITableViewCell alloc] init];
        self.flashCell.backgroundColor = [UIColor clearColor];
        
        //设置小菊花
        [self setFlashFlower];
        
        return self.flashCell;
    } else if (indexPath.section == 0 && indexPath.row != 0) {
        self.showCell = [self.tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        self.showCell.mainLabel.text = self.allNetworkData[indexPath.section][0][indexPath.row - 1];
        self.showCell.subLabel.text = self.allNetworkData[indexPath.section][1][indexPath.row - 1];
        [self.showCell.showImageView sd_setImageWithURL:self.allNetworkData[indexPath.section][2][indexPath.row - 1] placeholderImage:[UIImage imageNamed:@"1-5.jpeg"]];
        return self.showCell;
    } else if (indexPath.section == self.allNetworkData.count - 1 && indexPath.row == [self.allNetworkData[0][0] count]) {
        self.flashCell = [[UITableViewCell alloc] init];
        self.flashCell.backgroundColor = [UIColor clearColor];
        
        //设置小菊花
        [self setFlashFlower];
        
        return self.flashCell;
    } else {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.allNetworkData.count == 1) {
            return 7;
        } else {
            return 6;
        }
    } else if (section == self.allNetworkData.count - 1) {
        return 6;
    } else {
        return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allNetworkData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return myWidth;
    } else {
        return 100;
    }
}

//组间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 30;
    }
}

//与下面一同作用才能设置头标题
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= [UIColor clearColor];
    NSString *string = [[NSString alloc] initWithFormat:@"%@     ——————————————", self.allNetworkData[section][4]];
    header.textLabel.text = string;
    [header.textLabel setFont:[UIFont systemFontOfSize:20]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"111";
}

//cell选中 - 1
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        NSLog(@"rollButton");
    } else {
        FreeStyleTableViewCell *nowCell = [self.tableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"%@", nowCell.mainLabel.text);
        NSLog(@"either");
        NSInteger atLocation = 0;
        if (indexPath.section == 0) {
            atLocation = indexPath.row - 1;
        } else {
            atLocation = indexPath.section * 6 + indexPath.row;
        }
        NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", (long)atLocation];
        NSLog(@"atLocation = %ld", (long)atLocation);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.allTransURL forKey:@"url"];
        [dic setObject:self.allTransID forKey:@"id"];
        [dic setObject:stringLocation forKey:@"location"];
        [dic setObject:self.allNetworkData forKey:@"allData"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
        //传给视图控制器
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 957) {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY; //计算屏幕差
        if (bottomOffset <= height * 0.9) {
            
            [self.flashView startAnimating]; //加载小菊花，让它转
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnInformation" object:nil userInfo:nil];
        }
    }
}

//滚动停止事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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
        self.pageControl.currentPage = self.currentIndex;
        self.allOffset = self.scrollView.contentOffset.x;
    }
}

//用户手动拖动scrollView时，暂停计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag == 111) {
        [self.timer invalidate];
        self.timer = [[NSTimer alloc] init];
    }
}

//当scrollView停止拖动之后调用，调用此方法
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.tag == 111) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:@"帅哥哥" repeats:YES];
    }
}

//滚动时就调用，确定滚动的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 111) {
        self.rollLocation = self.scrollView.contentOffset.x / myWidth - 1;
    }
}

//定时器事件
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
    self.pageControl.currentPage = self.currentIndex;
}

//通知传值
- (void)getNetworkModel:(NSNotification *)getModel {
    
    self.storiesTitle = [[NSMutableArray alloc] init];
    self.storiesHint = [[NSMutableArray alloc] init];
    self.storiesImages = [[NSMutableArray alloc] init];
    self.storiesUrl = [[NSMutableArray alloc] init];
    self.storiesId = [[NSMutableArray alloc] init];
    
    self.temporaryArray = [[NSMutableArray alloc] init];
    
    //for (int i = 0; i < 6; i++) {
    for (int i = 0; i < 5; i++) {
        NSString *stringOne = getModel.userInfo[@"stories"][i][@"title"];
        [self.storiesTitle addObject:stringOne];
        
        NSString *stringTwo = getModel.userInfo[@"stories"][i][@"hint"];
        [self.storiesHint addObject:stringTwo];
        
        NSString *stringThree = getModel.userInfo[@"stories"][i][@"images"][0];
        [self.storiesImages addObject:stringThree];
        
        NSString *stringFour = getModel.userInfo[@"stories"][i][@"url"];
        [self.storiesUrl addObject:stringFour];
        [self.allTransURL addObject:stringFour];
        
        NSString *stringFive = getModel.userInfo[@"stories"][i][@"id"];
        [self.storiesId addObject:stringFive];
        [self.allTransID addObject:stringFive];
    }
    
    [self.temporaryArray addObject:self.storiesTitle]; //0
    [self.temporaryArray addObject:self.storiesHint];  //1
    [self.temporaryArray addObject:self.storiesImages];//2
    [self.temporaryArray addObject:self.storiesUrl];   //3
    
    NSString *string = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
    
    [self.temporaryArray addObject:string];  //4
    
    [self.temporaryArray addObject:self.storiesId]; //5
    
    [self.allNetworkData addObject:self.temporaryArray];
    
    if (self.againFlag == 0) {
        self.temporaryArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
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
        [self.temporaryArray addObject:self.top_storiesTitle];
        [self.temporaryArray addObject:self.top_storiesHint];
        [self.temporaryArray addObject:self.top_storiesImage];
        [self.temporaryArray addObject:self.top_storiesUrl];
        NSString *string = [[NSString alloc] initWithFormat:@"%@月%@日", [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(4, 2)], [getModel.userInfo[@"date"] substringWithRange:NSMakeRange(6, 2)]];
        [self.temporaryArray addObject:string];
        [self.temporaryArray addObject:self.top_storiesId];
        [self.allTopNetworkData addObject:self.temporaryArray];
    }
    self.againFlag = 1;
    
    [self.flashView stopAnimating];  //让小菊花停止转
    
    [self.tableView reloadData];
}
//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//按钮事件
- (void)pressButton:(UIButton*)button {
    NSLog(@"%ld", button.tag);
    NSString *stringLocation = [[NSString alloc] initWithFormat:@"%ld", button.tag];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.top_storiesUrl forKey:@"url"];
    [dic setObject:self.top_storiesId forKey:@"id"];
    [dic setObject:stringLocation forKey:@"location"];
    [dic setObject:self.allTopNetworkData forKey:@"allData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"transUrl" object:nil userInfo:dic];
}

//创建一个假导航栏
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

//重新加载自动轮播图的按钮
- (void)reloadRollButton {
    for (int i = 0; i < self.top_storiesImage.count + 2; i++) {
        if (i < self.top_storiesImage.count) {
            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tempButton.tag = i;
            [tempButton sd_setImageWithURL:self.top_storiesImage[i] forState:UIControlStateNormal];
            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.frame =  CGRectMake(myWidth * (i + 1), 0, myWidth, myWidth);
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
            UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tempButton.tag = 0;
            [tempButton sd_setImageWithURL:self.top_storiesImage[0] forState:UIControlStateNormal];
            [tempButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.frame =  CGRectMake(myWidth * 6, 0, myWidth, myWidth);
            [self.scrollView addSubview:tempButton];
            
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

//给最后一个cell设置小菊花
- (void)setFlashFlower {
    //设置小菊花
    self.flashView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self.flashCell.contentView addSubview:self.flashView];
    self.flashView.color = [UIColor grayColor];
    self.flashView.backgroundColor = [UIColor clearColor];
    self.flashView.hidesWhenStopped = YES;
    [self.flashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(myWidth));
        make.height.equalTo(@100);
        make.top.equalTo(self.flashCell).offset(0);
        make.left.equalTo(self.flashCell).offset(0);
    }];
}


//提取主色调 - 2
+ (UIColor *)mostColor:(UIImage*)image {
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //缩小图片，加快计算速度
    CGSize thumbSize = CGSizeMake(image.size.width/20, image.size.height/20);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace,bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //统计每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = image.size.height / 30; y < thumbSize.height; y++) {
            int offset = 4 * (x * y);
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
    NSEnumerator *enumerator = [cls objectEnumerator];
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
