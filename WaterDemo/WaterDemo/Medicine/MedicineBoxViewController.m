//
//  MedicineBoxViewController.m
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import "MedicineBoxViewController.h"
#import "MedicineBox_CollectionViewCell.h"

@interface MedicineBoxViewController ()

@end

@implementation MedicineBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //MVC初始化
    self.mModel = [[MedicineBoxModel alloc] init] ;
    [self.mModel initModel] ;
    self.mView = [[MedicineBoxView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)] ;
    [self.mView initView] ;
    [self.view addSubview:self.mView] ;
    //设置瀑布流的代理
    self.mView.MedicineBox_collectionView.delegate = self ;
    self.mView.MedicineBox_collectionView.dataSource = self ;
    [self.mView.MedicineBox_collectionView registerClass:[MedicineBox_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"] ;
    
    self.mView.layout.medicine_array = self.mModel.medicine_array ;
    [self.mModel.medicine_array addObject:@(8)] ;
    [self.mView.layout invalidateLayout] ;
    
    //设置长按移动手势
    UILongPressGestureRecognizer* longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressLong:)] ;
    [self.mView.MedicineBox_collectionView addGestureRecognizer:longGesture] ;
    
    
}

//UIcollectionView必选实现协议
//设置每一个分区的item数：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mModel.medicine_array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每一个item的属性
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MedicineBox_CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.layer.cornerRadius = 8.0 ;
    cell.layer.masksToBounds = NO ;
    
    cell.layer.shadowColor = [[UIColor darkGrayColor] CGColor] ;
    cell.layer.shadowOffset = CGSizeMake(9, 9) ;
    cell.layer.shadowOpacity = 0.5 ;
    cell.layer.shadowRadius = 2.0 ;
    cell.layer.borderWidth = 2 ;
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor] ;
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 /255.0 alpha:arc4random() % 255 /255.0] ;
    cell.backgroundColor = [UIColor colorWithRed:80.0f / 255.0f green:169.0f / 255.0f blue:167.0f /255.0f alpha:0.25] ;
    
    NSInteger medicine_count = [self.mModel.medicine_array[indexPath.row] intValue] ;
    //设置药品图标，可随药品种数增加
    for (int i = 0; i < medicine_count; i++) {
        UIImageView* medicine_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i % 3 * 40, 60 + 40 * (i / 3), 30, 30)] ;
        [medicine_imageview setImage:[UIImage imageNamed:@"yaoping.png"]] ;
        [cell.contentView addSubview:medicine_imageview] ;
    }
    
    //设置药箱名称
    cell.namelabel.text = self.mModel.medicine_name_array[indexPath.row] ;
    
    return cell;
}


//长按移动的实现
- (void)pressLong : (UILongPressGestureRecognizer*) longGesture  {
    
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan: {
            //判断手势起始位置是否在集合视图上
            NSLog(@"begin") ;
            NSIndexPath* indexPath = [self.mView.MedicineBox_collectionView indexPathForItemAtPoint:[longGesture locationInView:self.mView.MedicineBox_collectionView]] ;
            if (indexPath == nil) {
                break;
            }
            //开始移动对应的item
            [self.mView.MedicineBox_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath] ;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            //移动过程中更新item的位置,使移动流畅
//            NSLog(@"move") ;
            NSLog(@"%@",self.mModel.medicine_array[0]) ;
            [self.mView.MedicineBox_collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.mView.MedicineBox_collectionView]] ;
            break;
        }
        case UIGestureRecognizerStateEnded: {
            //移动结束关闭item的移动
            NSLog(@"end") ;
            [self.mView.MedicineBox_collectionView endInteractiveMovement] ;
            [self.mView.layout invalidateLayout] ;
            break;
        }
            
        default:
            [self.mView.MedicineBox_collectionView cancelInteractiveMovement] ;
            break;
    }
}
//设置允许移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//交换资源
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"%ld %ld",sourceIndexPath.item, destinationIndexPath.item) ;
    NSNumber* number = [self.mModel.medicine_array objectAtIndex:sourceIndexPath.item] ;
    [self.mModel.medicine_array removeObjectAtIndex:sourceIndexPath.item] ;
    [self.mModel.medicine_array insertObject:number atIndex:destinationIndexPath.item] ;
    
    NSString* str = [self.mModel.medicine_name_array objectAtIndex:sourceIndexPath.item] ;
    [self.mModel.medicine_name_array removeObjectAtIndex:sourceIndexPath.item] ;
    [self.mModel.medicine_name_array insertObject:str atIndex:destinationIndexPath.item] ;
    
}


////布局的调整
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 2) {
//        CGSize itemsize = CGSizeMake(150, 200) ;
//        return itemsize;
//    } else {
//        CGSize itemsize = CGSizeMake(150, 100) ;
//        return itemsize;
//    }
//
//
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    UIEdgeInsets sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10) ;
//    return sectionInsets;
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
