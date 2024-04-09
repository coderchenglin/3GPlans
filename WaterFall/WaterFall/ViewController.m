//
//  ViewController.m
//  WaterFall
//
//  Created by chenglin on 2024/4/6.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "MyCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MyLayout *myLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLayout = [[MyLayout alloc] init];
    
    // 初始化 UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.myLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"MyCell"];
    [self.view addSubview:self.collectionView];
}

// UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 返回需要展示的 cell 个数
    return 20; // 这里可以根据需要设置实际的 cell 数量
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    // 在这里可以设置 cell 的数据
    return cell;
}

@end
