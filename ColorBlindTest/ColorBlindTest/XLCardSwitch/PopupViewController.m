//
//  PopupViewController.m
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/29.
//

#import "PopupViewController.h"
#import "ResultCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface PopupViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.itemSize = CGSizeMake(175, 200);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ResultCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 使用本身有的数据源数组来确定collectionView中的item个数
    // 这里假设数据源数组是一个数组，数组中的每个元素也是一个数组，包含图片名称、标签1、标签2、标签3
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // 根据indexPath获取对应的数据
    NSDictionary *data = self.dataSourceArray[indexPath.row];
    
//    NSString *Flag = data[@"Flag"];
    
    // 设置cell的图片和标签内容
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", data[@"Image"]]];
    NSURL *url = [NSURL URLWithString:@"file:///Users/chenglin/Library/Containers/com.tencent.xinWeChat/Data/Library/Application%20Support/com.tencent.xinWeChat/2.0b4.0.9/94048adb9cce724b88ec628344d0bb11/Message/MessageTemp/d29f410141ef58adb2c8f8047eb0451a/Image/11001711538196_.pic.jpg"];
    
    
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"Result图片加载失败");
        } else {
            NSLog(@"Result图片加载成功");
        }
    }];
    
//    cell.imageView.image = [UIImage imageNamed:data[@"Image"]];
//    cell.label1.text = data[@"Key"];
//    cell.label2.text = data[@"Mykey"];
//    cell.label3.text = data[@"Point"];
    
    
//    cell.imageView.image = [UIImage imageNamed:data[@"Image"]];
    cell.label1.text = @"1";
    cell.label2.text = @"2";
    cell.label3.text = @"3";
    
    return cell;
}

@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

