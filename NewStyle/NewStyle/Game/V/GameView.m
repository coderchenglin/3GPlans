//
//  GameView.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "GameView.h"
#import "Masonry.h"
#import "MyCollectionViewCell.h"
#import "FirstCollectionViewCell.h"
#import "PlusCollectionViewCell.h"
#import "FMDB.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GameView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation GameView

- (void)viewInit {
    self.flagOfPhoto = 0;
    self.flagOfDelete = 0;
    self.photoArray = [[NSMutableArray alloc] init];
    [self titleLabelInit];
    [self backgroundImageViewInit];
    //[self databaseInit];
    //[self queryData];  //查询数据
    [self collectionViewInit];
}

//顶部标题初始化
- (void)titleLabelInit {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"照片墙";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter; //文本对齐方式
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.height.equalTo(@30);
        make.width.equalTo(@(0.6 * SIZE_WIDTH));
        make.left.equalTo(self).offset(SIZE_WIDTH / 2 - 0.3 * SIZE_WIDTH);
    }];
}

//背景图片初始化
- (void)backgroundImageViewInit {
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.image = [UIImage imageNamed:@"bj.jpg"];
    self.backgroundImageView.frame = CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT);
    [self addSubview:self.backgroundImageView];
}

- (void)collectionViewInit {
    //leyout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //单个元素大小
    layout.itemSize = CGSizeMake(SIZE_WIDTH / 3 - 20, SIZE_WIDTH / 3 - 20);
    //用这个瀑布流来初始化网格视图
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, SIZE_WIDTH, SIZE_HEIGHT - 90) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //注册网格视图
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"mainCell"];
    [self.collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:@"firstCell"];
    [self.collectionView registerClass:[PlusCollectionViewCell class] forCellWithReuseIdentifier:@"plusCell"];
    
    [self addSubview:self.collectionView];
    
}

//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.flagOfPhoto == 0) {
        return 1;
    } else {
        return self.photoArray.count + 2;
    }
}

//返回每个item
//__kindof关键字 表示这个类型可以是 该类或者是该类的子类
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.item == self.photoArray.count + 1) {
        PlusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"plusCell" forIndexPath:indexPath];
        return cell;
    }
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    
    ////
    
    
    return cell;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
