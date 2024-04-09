//
//  MedicineBoxView.m
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import "MedicineBoxView.h"
#import "Masonry.h"


#define WIDTH 393
#define HEIGHT 852
@implementation MedicineBoxView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initView {
    //设置渐变色背景
    //设置毛玻璃效果
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight] ;
    UIVisualEffectView* visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect] ;
    visualEffectView.frame = self.frame ;
    UIImageView* backImageView = [[UIImageView alloc] initWithFrame:self.frame] ;
    backImageView.image = [UIImage imageNamed:@"collectionViewBackImage.jpg"] ;
    //为了保证backimageview上的控件可以交互
    backImageView.userInteractionEnabled = YES ;
    
    [self addSubview:backImageView] ;
    [backImageView addSubview:visualEffectView] ;
    
    //设置顶部立体框头视图
    UIView* headView = [[UIView alloc] init] ;
    [visualEffectView.contentView addSubview:headView] ;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(90) ;
        make.left.mas_offset(15) ;
        make.height.mas_equalTo(80) ;
        make.width.mas_equalTo(self.bounds.size.width - 30) ;
    }] ;
    headView.alpha = 0.5 ;
    headView.layer.cornerRadius = 8.0 ;
    headView.layer.masksToBounds = NO ;
    
    headView.layer.shadowColor = [[UIColor darkGrayColor] CGColor] ;
    headView.layer.shadowOffset = CGSizeMake(9, 9) ;
    headView.layer.shadowOpacity = 0.5 ;
    headView.layer.shadowRadius = 2.0 ;
    headView.layer.borderWidth = 2 ;
    headView.layer.borderColor = [[UIColor lightGrayColor] CGColor] ;
    
    
    //设置搜索栏
    self.searchtextfield = [[UITextField alloc] init] ;
    [headView addSubview:self.searchtextfield] ;
    [self.searchtextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10) ;
        make.left.mas_offset(80) ;
        make.height.mas_equalTo(60) ;
        make.width.mas_equalTo(self.frame.size.width - 120 ) ;
    }] ;
    self.searchtextfield.backgroundColor = UIColor.whiteColor ;
    self.searchtextfield.text = @"" ;
    self.searchtextfield.borderStyle = UITextBorderStyleLine ;
    self.searchtextfield.delegate = self ;
    self.searchtextfield.textAlignment = NSTextAlignmentLeft ;
    self.searchtextfield.textColor = UIColor.blackColor ;
    self.searchtextfield.font = [UIFont systemFontOfSize:30] ;
    self.searchtextfield.placeholder = @"搜索药品名" ;
    self.searchtextfield.layer.cornerRadius = 16 ;
    self.searchtextfield.layer.masksToBounds = YES ;
    self.searchtextfield.layer.borderWidth = 4.0 ;
    //清空按钮
    self.searchtextfield.clearButtonMode = UITextFieldViewModeWhileEditing ;
    //搜索栏图标
    UIImageView* searchimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] ;
    searchimageview.image = [UIImage imageNamed:@"sousuo-2.png"] ;
    self.searchtextfield.leftView = searchimageview ;
    self.searchtextfield.leftViewMode = UITextFieldViewModeAlways ;
    
    //初始化药箱添加按钮
    self.addbox_btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [self.addbox_btn setImage:[UIImage imageNamed:@"tianjia.png"] forState:UIControlStateNormal] ;
    self.addbox_btn.layer.cornerRadius = 30 ;
    self.addbox_btn.layer.masksToBounds = YES ;
    self.addbox_btn.layer.borderWidth = 3.0 ;
    [headView addSubview:self.addbox_btn] ;
    [self.addbox_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10) ;
        make.left.mas_offset(10) ;
        make.height.mas_equalTo(60) ;
        make.width.mas_equalTo(60) ;
    }] ;
    
    
    
    
    
    //瀑布流布局（collectionView）
    //layout 布局类
//    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init] ;
    _layout = [[MyFlowLayout alloc] init] ;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical ;//设置布局为垂直分布
    
//    layout.itemSize = CGSizeMake(WIDTH / 3 - 10, WIDTH / 3 - 10) ;//设置每一个item的大小
//    layout.itemSize = CGSizeMake(150, 150) ;
    //初始化collectionView
    
    self.MedicineBox_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.bounds.size.width, self.bounds.size.height - 200) collectionViewLayout:_layout] ;
    UIImageView* backimageview = [[UIImageView alloc] initWithFrame:self.MedicineBox_collectionView.frame] ;
    backimageview.image = [UIImage imageNamed:@"collectionViewBackImage.jpg"] ;
    self.MedicineBox_collectionView.backgroundView =  backimageview;
    self.MedicineBox_collectionView.layer.cornerRadius = 15 ;
    //注册item类型,和Uitableview不同，这里只能用注册
//    self.MedicineBox_collectionView.delegate = self ;
//    self.MedicineBox_collectionView.dataSource = self ;
    [visualEffectView.contentView addSubview:self.MedicineBox_collectionView] ;
    
 
}


//点击return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchtextfield resignFirstResponder] ;
    return YES;
}

////UIcollectionView必选实现协议
////设置每一个分区的item数：
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 9;
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}


////返回每一个item的属性
//- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 /255.0 alpha:arc4random() % 255 /255.0] ;
//    return cell;
//}

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

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    UIEdgeInsets sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10) ;
//    return sectionInsets;
//}












//UicollectionView可选实现协议
//允许某个item高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//item高亮时触发
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//结束高亮触发
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//是否可以选中某个item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//是否可以取消选中某个item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//选中某个item触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//取消选中触发的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//将要加载某个item时调用的方法
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//将要加载头尾视图时调用的方法
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
}

//已经展示某个item触发
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//已经展示某个头尾视图触发
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
}

//进行重新布局时调用的方法
//- (nonnull UICollectionViewTransitionLayout* )collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
//
//}


@end
