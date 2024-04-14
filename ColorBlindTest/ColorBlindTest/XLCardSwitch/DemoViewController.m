//
//  DemoViewController.m
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import "DemoViewController.h"
#import "XLCardSwitch.h"
#import "Manager.h"
#import "ColorTestModel.h"
#import "XLCardCell.h"
#import <SDWebImage/SDWebImage.h>
#import "ReturnModel.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NSMutableArray * _Nullable optionArray;

@interface DemoViewController ()<XLCardSwitchDelegate, UICollectionViewDelegate, UICollectionViewDataSource, XLCardCellDelegate>

@property (nonatomic, strong) XLCardSwitch *cardSwitch;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray<XLCardModel *> *models;

@property (nonatomic, strong) NSMutableArray<ReturnModel *> *returnModels;

@property (nonatomic, strong) NSDictionary *dictionaryModel;

@property (nonatomic, strong) NSDictionary *optionDictionaryModel;

//@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) BOOL showSubmitButton;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"XLCardSwitch";
    self.view.backgroundColor = [UIColor whiteColor];
    optionArray = [NSMutableArray arrayWithCapacity:4];
    NSLog(@"self.model.count = %lu",(unsigned long)self.models.count);
    
    for (NSInteger i = 0; i < 8; i++) {
        [optionArray addObject:@""];
    }
    
    [self getColorTestModel];
}

- (void)getColorTestModel {
    
    [[Manager sharedManager] requestColorBlindTest:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb0lkIjoyLCJleHAiOjE3MTMxMDcyMDAsImlhdCI6MTcxMzA2NDAwMCwiaXNzIjoi5bCP6LW1Iiwic3ViIjoiY29sb3IifQ.0Kb5ac6io-HN5lLXTVhOoflcM4lDx3uYVM94fOQwm0g" success:^(ColorTestModel * _Nonnull colorTestModel) {
        
        //这里有个理解，Model本身，一定是一个字典，只是，你拿到什么数据，取决于你Model中定义了哪些属性，所以先转为字典
        self.dictionaryModel = [colorTestModel toDictionary];

        NSArray *dataArray = [[NSArray alloc] initWithArray:self.dictionaryModel[@"data"]];

        [self saveData:dataArray];
        
    } failure:^(NSError * _Nonnull error) {
        if (error)
            NSLog(@"网络连接失败");
    }];
}

- (void)saveData:(NSArray *)array {

    
    self.models = [NSMutableArray new];
    NSMutableDictionary *temDictionary = [[NSMutableDictionary alloc] init];

    for (NSDictionary *dic in array) {

        NSString *string1 = [NSString stringWithFormat:@"%@", dic[@"OptionA"]];
        NSString *string2 = [NSString stringWithFormat:@"%@", dic[@"OptionB"]];
        NSString *string3 = [NSString stringWithFormat:@"%@", dic[@"OptionC"]];
        NSString *string4 = [NSString stringWithFormat:@"%@", dic[@"OptionD"]];
        NSString *imageName = dic[@"Issue"][@"image"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"./" withString:@""];
        NSString *imageNameString = [NSString stringWithFormat:@"http://zy520.online:8081/%@", imageName];

        [temDictionary setObject:string1 forKey:@"OptionA"];
        [temDictionary setObject:string2 forKey:@"OptionB"];
        [temDictionary setObject:string3 forKey:@"OptionC"];
        [temDictionary setObject:string4 forKey:@"OptionD"];
        [temDictionary setObject:imageNameString forKey:@"imageName"];
        
        NSLog(@" temDictionary[] = %@",temDictionary[@"imageName"]);

        XLCardModel *model = [[XLCardModel alloc] init];
        [model setValuesForKeysWithDictionary:temDictionary];
        [self.models addObject:model];

    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addImageView];
        [self addCardSwitch];
        [self.cardSwitch.submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        self.cardSwitch.collectionView.delegate = self;
        self.cardSwitch.collectionView.dataSource = self;
//        [self.cardSwitch.collectionView reloadData];
        self.cardSwitch.models = self.models;
        
        [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
    });
}

//提交按钮的点击方法
- (void)submitButtonTapped {
    [[Manager sharedManager] postColorBlindOptionArray:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb0lkIjoyLCJleHAiOjE3MTMxMDcyMDAsImlhdCI6MTcxMzA2NDAwMCwiaXNzIjoi5bCP6LW1Iiwic3ViIjoiY29sb3IifQ.0Kb5ac6io-HN5lLXTVhOoflcM4lDx3uYVM94fOQwm0g" success:^(OptionModel * _Nonnull optionModel) {
        
        self.optionDictionaryModel = [optionModel toDictionary];
        //        NSLog(@"网络请求成功");
        NSArray *dataArray = [[NSArray alloc] initWithArray:self.dictionaryModel[@"data"]];
//        NSLog(@"daraArray = %@", dataArray);
        
        [self saveReturnData:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showPopup];
        });
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"post失败");
    } didSelectOption:optionArray];
}

- (void)showPopup {
    // 创建PopupViewController实例
    PopupViewController *popupViewController = [[PopupViewController alloc] init];
    
    // 设置数据源数组
    popupViewController.dataSourceArray = self.returnModels;
    
    // 设置弹出视图的样式
    popupViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    // 设置弹出视图的大小
    popupViewController.preferredContentSize = CGSizeMake(myWidth, myHeight - 200);
    
    // 弹出视图
    [self presentViewController:popupViewController animated:YES completion:nil];
}

- (void)saveReturnData:(NSArray *)array {
//    self.transDataArray = [[NSMutableArray alloc] init];
    
    self.returnModels = [NSMutableArray new];
    NSMutableDictionary *temDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dic in array) {
//        NSLog(@"dic = %@", dic);

        NSString *string1 = [NSString stringWithFormat:@"%@", dic[@"Key"]];
        NSString *string2 = [NSString stringWithFormat:@"%@", dic[@"Mykey"]];
        NSString *string3 = [NSString stringWithFormat:@"%@", dic[@"Point"]];
        NSString *Flag = [NSString stringWithFormat:@"%@", dic[@"Flag"]];
        
        NSString *imageName = dic[@"image"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"./" withString:@""];
        NSString *imageNameString = [NSString stringWithFormat:@"http://zy520.online:8081/%@", imageName];

        [temDictionary setObject:string1 forKey:@"Key"];
        [temDictionary setObject:string2 forKey:@"Mykey"];
        [temDictionary setObject:string3 forKey:@"Point"];
        [temDictionary setObject:imageNameString forKey:@"Image"];
        [temDictionary setObject:Flag forKey:@"Flag"];
        
//        NSLog(@" temDictionary[] = %@",temDictionary[@"imageName"]);

        ReturnModel *model = [[ReturnModel alloc] init];
        [model setValuesForKeysWithDictionary:temDictionary];
        [self.returnModels addObject:model];
    }
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
    self.cardSwitch.frame = self.view.bounds;
}



- (void)addImageView {
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    
    //毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.imageView addSubview:effectView];
}

- (void)addCardSwitch {
    //初始化
    self.cardSwitch = [[XLCardSwitch alloc] initWithFrame:self.view.bounds];
    
    [self.cardSwitch.collectionView registerClass:[XLCardCell class] forCellWithReuseIdentifier:@"XLCardCell"];
    //设置代理方法
    self.cardSwitch.delegate = self;
    //分页切换
    self.cardSwitch.pagingEnabled = true;
    [self.view addSubview:self.cardSwitch];
}

- (void)segMethod:(UISegmentedControl *)seg {
//    NSLog(@"%ld", seg.selectedSegmentIndex);
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.cardSwitch.pagingEnabled = NO;
            break;
        case 1:
            self.cardSwitch.pagingEnabled = YES;
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.models count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"XLCardCell";
    XLCardCell *card = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    if (indexPath.item == 0) {
//        card.testButton1.tag = 1;
//        card.testButton1.tag = 1;
//    } else if (indexPath.item == 1) {
//
//    }
    card.delegate = self;
    card.model = self.models[indexPath.item];
    
    return card;
}

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.cardSwitch.pagingEnabled) {return;}
    self.cardSwitch.dragStartX = scrollView.contentOffset.x;
    self.cardSwitch.dragAtIndex = self.cardSwitch.selectedIndex;
}

//手指拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.cardSwitch.pagingEnabled) {return;}
    self.cardSwitch.dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cardSwitch fixCellToCenter];
    });
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    self.cardSwitch.selectedIndex = indexPath.row;
    [self.cardSwitch scrollToCenterAnimated:YES];
    [self.cardSwitch performClickDelegateMethod];
}

//点击卡片代理方法
- (void)cardSwitchDidClickAtIndex:(NSInteger)index {
    NSLog(@"点击了：%zd", index);
    [self configImageViewOfIndex:index];
}

//滚动卡片代理方法
- (void)cardSwitchDidScrollToIndex:(NSInteger)index {
    NSLog(@"滚动到了：%zd", index);
    [self configImageViewOfIndex:index];
}


- (void)configImageViewOfIndex:(NSInteger)index {
    //更新背景图
    XLCardModel *model = self.models[index];

    NSURL *url = [NSURL URLWithString:model.imageName];

    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"背景图片加载失败");
        } else {
            NSLog(@"背景图片加载成功");
        }
    }];
    
}

- (void)switchPrevious {
    NSInteger index = self.cardSwitch.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = self.cardSwitch.selectedIndex + 1;
    index = index > self.models.count - 1 ? self.models.count - 1 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

//???
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cardCellDidSelectAllOptions:(XLCardCell *)cell isAll:(BOOL)allQuestionAnswered {
    // 当所有题目都有选择时，显示提交按钮
    NSLog(@"allQuestionAnswered = %d", allQuestionAnswered);
    if (allQuestionAnswered) {
        self.cardSwitch.submitButton.hidden = NO; //显示提交按钮
    } else {
        self.cardSwitch.submitButton.hidden = YES;
    }
}


- (NSIndexPath *)buttonTappedInCell:(UICollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.cardSwitch.collectionView indexPathForCell:cell];
//    NSLog(@"item = %ld", indexPath.item);
    return indexPath;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
