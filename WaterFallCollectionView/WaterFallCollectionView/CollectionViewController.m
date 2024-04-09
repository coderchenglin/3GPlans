//
//  CollectionViewController.m
//  WaterFallCollectionView
//
//  Created by chenglin on 2024/4/4.
//

#import "CollectionViewController.h"
#import "WaterFallCollectionViewCell.h"
#import "WaterFallFlowLayout.h"


@interface CollectionViewController ()

@property (nonatomic, strong) NSArray *imgArr;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WaterFallFlowLayout *flowLayout = [[WaterFallFlowLayout alloc] init];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
//    [self loadImage];
    //注册单元格
    [self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
}

//- (void)loadImage {
//    NSMutableArray *muArr = [NSMutableArray array];
//    for (int i = 1; i < 12; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [muArr addObject:image];
//    }
//    _imgArr = muArr;
//}

//懒加载
- (NSArray *)imgArr{
    if (!_imgArr) {
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 1; i < 12; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            [muArr addObject:image];
        }
        _imgArr = muArr;
    }

    return _imgArr;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSLog(@"self.imgArr.count = %ld", self.imgArr.count);
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[WaterFallCollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.image = self.imgArr[indexPath.item];
    
    UILabel *temLabel = [[UILabel alloc] init];
    temLabel.text = [NSString stringWithFormat:@"%ld-abc", indexPath.item];
    cell.label = temLabel;
    
    return cell;
}

- (float)imgHeight:(float)height width:(float)width {
    /*
        高度/宽度 = 压缩后高度/压缩后宽度（100）
     */
    float newHeight = height / width * 176.5;
    return newHeight;
}

#pragma mark - UICollectionView delegate flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image = self.imgArr[indexPath.item];
    float height = [self imgHeight:image.size.height width:image.size.width];
    return CGSizeMake(176.5, height + 35);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    UIEdgeInsets edgeInsets = {5,5,5,5};
    UIEdgeInsets edgeInsets = {10,10,10,10};
    return edgeInsets;
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
