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
@property (nonatomic, strong) UIImageView *backgroundImageView; //背景视图
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer; //长按识别
@property (nonatomic, strong) FMDatabase *photoDataBase;

@end

@implementation GameView

- (void)viewInit {
    self.flagOfPhoto = 0;
    self.flagOfDelete = 0;
    self.photoArray = [[NSMutableArray alloc] init];
    [self titleLabelInit];
    [self backgroundImageViewInit];
    [self databaseInit];
    [self queryData];  //查询数据
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
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    
    //长按功能
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    self.longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self.longPressGestureRecognizer addTarget:self action:@selector(handleLongPressRecognizer:)];
    [self.collectionView addGestureRecognizer:self.longPressGestureRecognizer];
    
}

// !! 长按触发事件
- (void)handleLongPressRecognizer:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:gesture.view]];
            if (path == nil || path.item == 0 || path.item == self.photoArray.count + 1) {
                break;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:path];
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每个分区的item个数 -- 必须实现
//配合第一个图片的点击按钮，显示和不显示
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.flagOfPhoto == 0) {
        return 1;
    } else {
        return self.photoArray.count + 2;
    }
}

//返回每个item -- 必须实现
//__kindof关键字 表示这个类型可以是 该类或者是该类的子类
//[cell reload]可以让这里重新判断，重新构造网格内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.item == self.photoArray.count + 1) {
        PlusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"plusCell" forIndexPath:indexPath];
        return cell;
    }
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    
    //增加图片的右上角删除按钮
    [cell.deleteButton addTarget:self action:@selector(pressDelete:) forControlEvents:UIControlEventTouchUpInside];
    if (self.flagOfDelete == 0) {
        cell.deleteButton.hidden = YES;
    } else {
        cell.deleteButton.hidden = NO;
    }
    [cell setImage:self.photoArray[indexPath.item - 1] and:indexPath.item];
    
    return cell;
}

//删除按钮点击事件
- (void)pressDelete:(UIButton *)button {
    //这里还有一步删数据库的操作，先删数据库
    [self deletePhotoData:self.photoArray[button.tag - 1]];
    [self.photoArray removeObjectAtIndex:button.tag - 1];
    [self.collectionView reloadData];
}

//item点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        if (self.flagOfPhoto == 0) {
            self.flagOfPhoto = 1;
        } else {
            self.flagOfPhoto = 0;
        }
        [self.collectionView reloadData];
    } else if (indexPath.item == self.photoArray.count + 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presentPicker" object:nil userInfo:nil];
    } else {
        NSDictionary *itemDictionary = @{@"item":[NSString stringWithFormat:@"%ld",indexPath.item]};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"photoBig" object:nil userInfo:itemDictionary];
    }
}

//是否可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//移动函数 - 移动item时回调
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    id item = [self.photoArray objectAtIndex:sourceIndexPath.item - 1];
    NSInteger movedItem = destinationIndexPath.item;
    if (movedItem != 0 && movedItem != self.photoArray.count + 1) {
        [self.photoArray removeObject:item];
        [self.photoArray insertObject:item atIndex:destinationIndexPath.item - 1];
    }
    [self.collectionView reloadData];
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

//FMDB初始化
- (void)databaseInit {
    NSString *photoDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *photoFileName = [photoDoc stringByAppendingPathComponent:@"photoData.sqlite"];
    self.photoDataBase = [FMDatabase databaseWithPath:photoFileName];
    if ([self.photoDataBase open]) {
        BOOL result = [self.photoDataBase executeUpdate:@"CREATE TABLE IF NOT EXITS photoData (photo BLOB NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
}

//FMDB查询结果
- (void)queryData {
    if ([self.photoDataBase open]) {
        //1.执行查询语句
        FMResultSet *photoResultSet = [self.photoDataBase executeQuery:@"SELECT * FROM photoData"];
        //2.遍历结果
        while ([photoResultSet next]) {
            NSData *imageData = [photoResultSet dataForColumn:@"photo"];
            UIImage *image = [UIImage imageWithData:imageData];
            [self.photoArray addObject:image];
        }
        [self.photoDataBase close];
    }
}

//FMDB插入数据
- (void)insertPhotoDataBase:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    if ([self.photoDataBase open]) {
        BOOL result = [self.photoDataBase executeUpdate:@"INSERT INTO photoData (photo) VALUES (?);", imageData];
        if (!result) {
            NSLog(@"增加数据失败");
        } else {
            NSLog(@"增加数据成功");
        }
        [self.photoDataBase close];
    }
    
}

//FMDB删除数据
- (void)deletePhotoData:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    if ([self.photoDataBase open]) {
        BOOL result = [self.photoDataBase executeUpdate:@"delete from photoData WHERE photo = ?", imageData];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.photoDataBase close];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
