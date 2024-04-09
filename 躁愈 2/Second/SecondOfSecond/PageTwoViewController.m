//
//  PageTwoViewController.m
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import "PageTwoViewController.h"
#import "PageTwoView.h"
#import "PageTwoViewBtnTableViewCell.h"
#import "PageTwoModel.h"
#import "PageTwoViewEmoTableViewCell.h"
#import "Manager.h"
#import "Masonry.h"
#import "QuestionAnalysisViewController.h"
#import "User.h"'
#import "PageTwoViewEmoTableViewCell2.h"
#import "FirstEmoCardViewController.h"
extern UIColor *colorOfBack;

@interface PageTwoViewController ()

@end

@implementation PageTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTwoModel = [[PageTwoModel alloc] init];
    [self.pageTwoModel setEmoArray];
    [self.pageTwoModel setEmoPngArray];
    [self.pageTwoModel setBigTimeArray];
    [self.pageTwoModel setSmallTimeArray];
    
    [self.pageTwoModel setEmojyNameArray];
    [self.pageTwoModel setEmojyImageArray];
    [self.pageTwoModel setSelectedButtonsNamesArray];
    [self.pageTwoModel setEmoTextArray];
    [self.pageTwoModel setSelectedButtonsImagesArray];
    [self.pageTwoModel setMoodTimeArray];
    
    self.pageTwoView = [[PageTwoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 763)];
    
    [self.view addSubview:_pageTwoView];
    [self registeTableViewCell];
    _heightCache = [[NSMutableDictionary alloc] init];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDataFromThirdViewController:)
                                                 name:@"ThirdViewControllerDidFinishNotification"
                                               object:nil];
}

- (void)registeTableViewCell {
    self.pageTwoView.tableView.dataSource = self;
    self.pageTwoView.tableView.delegate = self;
    self.pageTwoView.tableView.rowHeight = UITableViewAutomaticDimension;
    // 步骤2：
    self.pageTwoView.tableView.estimatedRowHeight = 200.0;
    [self.pageTwoView.tableView registerClass:[PageTwoViewBtnTableViewCell class] forCellReuseIdentifier:@"pageTwoViewBtnTableViewCell"];
    [self.pageTwoView.tableView registerClass:[PageTwoViewEmoTableViewCell class] forCellReuseIdentifier:@"pageTwoViewEmoTableViewCell"];
    [self.pageTwoView.tableView registerClass:[PageTwoViewEmoTableViewCell2 class] forCellReuseIdentifier:@"pageTwoViewEmoTableViewCell2"];
//    [self.secondView.tableView registerClass:[SecondOfFirstTableViewCell class] forCellReuseIdentifier:@"secondOfFirstTableViewCell"];

}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 140;
    } else {
        NSString *cacheKey = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
        // 检查缓存
        NSNumber *cachedHeight = [self.heightCache objectForKey:cacheKey];
        if (cachedHeight) {
            NSLog(@"存在缓存%@", cacheKey);
            return cachedHeight.doubleValue;
        } else {
            // 缓存行高
            return UITableViewAutomaticDimension;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _pageTwoModel.selectedButtonsNamesArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 10.0; // 同上，根据需要调整
}

#pragma mark 获取cell的高度而后进行缓存
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect cellFrame = [tableView rectForRowAtIndexPath:indexPath];
//    CGFloat cellHeight = cellFrame.size.height;
    CGFloat cellHeight = cell.frame.size.height;
    NSLog(@"Cell height: %f", cellHeight);
    //添加缓存
    NSString *cacheKey = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    [self.heightCache setObject:@(cellHeight) forKey:cacheKey];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PageTwoViewBtnTableViewCell *cell = [self.pageTwoView.tableView dequeueReusableCellWithIdentifier:@"pageTwoViewBtnTableViewCell" forIndexPath:indexPath];
        [cell.btn1 addTarget:self action:@selector(selectPhotoFromLibrary) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(questionAnalysis) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(nowMood) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }  else {
//        PageTwoViewEmoTableViewCell *cell = [self.pageTwoView.tableView dequeueReusableCellWithIdentifier:@"pageTwoViewEmoTableViewCell" forIndexPath:indexPath];
//        cell.pictureView.image = [UIImage imageNamed:_pageTwoModel.emoPngArray[indexPath.row]];
//        cell.titleLabel.text = _pageTwoModel.emoArray[indexPath.row];
//        cell.labelFirst.text = _pageTwoModel.bigTimeArray[indexPath.row];
//        cell.labelSecond.text = _pageTwoModel.smallTimeArray[indexPath.row];

        PageTwoViewEmoTableViewCell2 *cell = [self.pageTwoView.tableView dequeueReusableCellWithIdentifier:@"pageTwoViewEmoTableViewCell2" forIndexPath:indexPath];
        cell.nameLabel.font = [UIFont systemFontOfSize:24];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        cell.nameLabel.text = self.pageTwoModel.emojyNameArray[indexPath.section - 1];
        cell.commentHeadPhotoImageView.image = [UIImage imageNamed:self.pageTwoModel.emojyImageArray[indexPath.section - 1]];
        cell.contentLabel.text = self.pageTwoModel.EmoTextArray[indexPath.section - 1];
        cell.timeLabel.text = self.pageTwoModel.moodTimeArray[indexPath.section - 1];
        
        UIStackView *stackView = cell.verticalStackView; // 假设你的cell有一个属性叫verticalStackView
        for (UIView *view in stackView.arrangedSubviews) {
            [stackView removeArrangedSubview:view];
            [view removeFromSuperview]; // 这一步确保视图从视图层次结构中完全移除
        }

        // 创建水平 UIStackView 来容纳标签
        UIStackView *horizontalStackView = [self createHorizontalStackView];
        int tagsInRow = 0;
        
        // 假定的图标名，确保你有对应的图片资源
        NSString *iconName = @"1F493_color.png"; // 替换为你的图标资源名称
        
        NSMutableArray *t1 = self.pageTwoModel.selectedButtonsNamesArray[indexPath.section - 1];
        NSMutableArray *t2 = self.pageTwoModel.selectedButtonsImagesArray[indexPath.section - 1];

//        for (NSString *tagText in self.pageTwoModel.selectedButtonsNamesArray) {
        for (int i = 0; i < t1.count; i++) {
            if (tagsInRow >= 3) {
                // 当前行标签已满，添加到垂直 StackView 并创建新行
                [cell.verticalStackView addArrangedSubview:horizontalStackView];
                horizontalStackView = [self createHorizontalStackView];
                tagsInRow = 0;
            }
            
            // 修改这里来创建带图标的标签
            UIStackView *tagView = [self createTagViewWithIcon:t2[i] text:t1[i]];
            [horizontalStackView addArrangedSubview:tagView];
            tagsInRow++;
        }
        
        // 添加最后一行，如果有的话
        //这里有问题
        if (tagsInRow > 0) {
            [cell.verticalStackView addArrangedSubview:horizontalStackView];
        }
        
        return cell;
    }
}


#pragma mark 问卷调查
- (void)questionAnalysis {
    QuestionAnalysisViewController *questionAnalysisViewController = [[QuestionAnalysisViewController alloc] init];
    [self presentViewController:questionAnalysisViewController animated:YES completion:nil];
}

#pragma mark 情绪分析
- (void)selectPhotoFromLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark 今日情绪
- (void)nowMood {
    FirstEmoCardViewController *t = [[FirstEmoCardViewController alloc] init];
    [self presentViewController:t animated:YES completion:nil];
}
// 实现处理通知的方法
- (void)handleDataFromThirdViewController:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *emojiName = userInfo[@"emojiName"];
    NSString *emojiImage = userInfo[@"emojiImage"];
    NSMutableArray *buttonNames = userInfo[@"buttonNames"];
    NSMutableArray *buttonImages = userInfo[@"buttonImages"];
    NSString *moodText = userInfo[@"moodText"];


    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageTwoModel.emojyNameArray addObject:emojiName];
        [self.pageTwoModel.emojyImageArray addObject:emojiImage];
        [self.pageTwoModel.selectedButtonsNamesArray addObject:buttonNames];
        [self.pageTwoModel.selectedButtonsImagesArray addObject:buttonImages];
        [self.pageTwoModel.EmoTextArray addObject:moodText];
        [self.pageTwoModel.moodTimeArray addObject:[self.pageTwoModel getCurrentTimeWithCustomFormat]];

        [self.pageTwoView.tableView reloadData];
    });
    // 在这里处理传回的数据
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        [self.pageTwoView showLoadMoreView];

//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(100, 100, 100, 100);
//        imageView.image = selectedImage;
//        [self.view addSubview:imageView];
        [[Manager shareManager] NetWorkGetWithData:^(EmotionModel * _Nonnull model) {
//            NSLog(@"%@1", model);
            self.modelDictionary = [model toDictionary];
            NSLog(@"%@", self.modelDictionary);
            NSLog(@"%@", self.modelDictionary[@"type"]);
            NSLog(@"%@", [self.pageTwoModel getCurrentDateWithCustomFormat]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                [_pageTwoModel.emoArray addObject:self.modelDictionary[@"type"]];
                [self.pageTwoModel.emojyNameArray addObject:self.modelDictionary[@"type"]];
                [self.pageTwoModel.emojyImageArray addObject:@"yiban.png"];
                [self.pageTwoModel.selectedButtonsNamesArray addObject:[[NSArray alloc]init]];
                [self.pageTwoModel.selectedButtonsImagesArray addObject:[[NSArray alloc]init]];
                [self.pageTwoModel.EmoTextArray addObject:@"注：Photo识别"];
                [self.pageTwoModel.moodTimeArray addObject:[self.pageTwoModel getCurrentTimeWithCustomFormat]];
                
                [User shareUser].points += 10;
                [self.pageTwoView hideLoadMoreView];
                [self.pageTwoView.tableView reloadData];

            });
        } andError:^(NSError * _Nullable error) {
            NSLog(@"error");
        } andImage:selectedImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark stackview
- (UIStackView *)createHorizontalStackView {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.backgroundColor = [UIColor clearColor];
    stackView.spacing = 8;
    return stackView;
}

// 新增的方法来创建带图标的标签视图
- (UIStackView *)createTagViewWithIcon:(NSString *)iconName text:(NSString *)text {
    UIStackView *tagStackView = [[UIStackView alloc] init];
    tagStackView.axis = UILayoutConstraintAxisHorizontal;
    tagStackView.spacing = 8;
    tagStackView.alignment = UIStackViewAlignmentCenter;
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    [iconImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [iconImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.text = text;
    tagLabel.font = [UIFont systemFontOfSize:14];
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.backgroundColor = [UIColor clearColor];
    tagLabel.textAlignment = NSTextAlignmentLeft;
    [tagLabel sizeToFit];
    
    [tagStackView addArrangedSubview:iconImageView];
    [tagStackView addArrangedSubview:tagLabel];
    
    return tagStackView;
}

@end
