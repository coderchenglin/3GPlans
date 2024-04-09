//
//  CollectionViewController.m
//  CengCiCollectionVIew
//
//  Created by chenglin on 2024/4/4.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "MyDataModel.h"
#import "EWWaterFallLayout.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //初始化数据源
//    self.dataSource = [NSMutableArray array];
//    //在这里添加数据到self.dataSource
//    MyDataModel *data1 = [[MyDataModel alloc] init];
//    data1.image = @"2.jpg"; // 假设图片名称为image1.jpg
//    data1.label = @"This is a sample label text."; // 示例标签文本内容
//    [self.dataSource addObject:data1];
//
//    MyDataModel *data2 = [[MyDataModel alloc] init];
//    data2.image = @"3.jpg"; // 假设图片名称为image2.jpg
//    data2.label = @"Another example label text that may span multiple lines."; // 示例标签文本内容，跨多行
//    [self.dataSource addObject:data2];
    
    //创建布局
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    EWWaterFallLayout *FallLayout = [[EWWaterFallLayout alloc] init];
//    FallLayout.minimumLineSpacing = 10;
//    FallLayout.minimumInteritemSpacing = 10;
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:FallLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.dataSource.count;
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
//    MyDataModel *data = self.dataSource[indexPath.item];
    
//    cell.imageView.image = [UIImage imageNamed:data.image];
//    cell.label.text = data.label;
    cell.imageView.image = [UIImage imageNamed:@"2.jpg"];
    cell.label.text = @"sadadsad";
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    //从数据源中获取对应的数据
//    MyDataModel *data = self.dataSource[indexPath.item];
//
////    CGFloat cellWidth = CGRectGetWidth(collectionView.frame) / 2 ;
////    CGFloat imageHeight = 100;
////    CGFloat imageWidth = cellWidth;
////    CGFloat scaleFactor = imageWidth / 100;
////    CGFloat scaledHeight = 100 * scaleFactor;
//
//    CGFloat labelHeight = [self calculateLabelHeightForText:data.label width:(myWidth / 2) ];
//
//    return CGSizeMake((myWidth / 2) - 20 , 200 + labelHeight );
//}

// 根据文本内容和宽度计算label的高度
//- (CGFloat)calculateLabelHeightForText:(NSString *)text width:(CGFloat)width {
//    CGSize constraintSize = CGSizeMake(width, CGFLOAT_MAX);
//    CGRect textRect = [text boundingRectWithSize:constraintSize
//                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
//                                         context:nil];
//    return ceil(textRect.size.height);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
