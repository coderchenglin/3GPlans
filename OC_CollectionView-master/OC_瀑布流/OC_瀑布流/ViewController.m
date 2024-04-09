//
//  ViewController.m
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import "UUCollectionViewFlowLayout.h"
#import "CustomViewCell.h"
@interface ViewController () <UICollectionViewDataSource,UUCollectionViewFlowLayoutDelegate,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *shops;
@end

@implementation ViewController

-(NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
        NSArray *data = [[NSArray alloc] initWithContentsOfFile:filePath];
        for (NSDictionary *dict in data) {
            TestModel *model = [[TestModel alloc] initWithDict:dict];
            [_shops addObject:model];
        }
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UUCollectionViewFlowLayout *layout = [[UUCollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CustomViewCell class] forCellWithReuseIdentifier:@"class"];
    [self.view addSubview:_collectionView];
    layout.delegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"class" forIndexPath:indexPath];
    cell.model = self.shops[indexPath.item];
    return cell;
}

- (CGFloat)WaterFlowLayout:(UUCollectionViewFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth
{
    TestModel *shop = self.shops[index];
    return itemWidth * shop.h / shop.w;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
