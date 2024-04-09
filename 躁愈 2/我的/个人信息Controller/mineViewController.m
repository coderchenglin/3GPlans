//
//  mineViewController.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineViewController.h"
#import "mineView.h"
#import "mineCollectionView.h"
#import "mineTableview.h"
extern UIColor *colorOfBack;
@interface mineViewController ()

@property (nonatomic, strong) mineView* view1;
@property (nonatomic, strong) mineCollectionView* view2;
@property (nonatomic, strong) mineTableview* view3;

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorOfBack;
    
    [self addView];
    [self addCollectionView];
    [self addTableview];

    
}



- (void) addView {
    self.view1 = [[mineView alloc] initWithFrame:CGRectMake(0, 98.5, self.view.frame.size.width, 130)];
    [self.view addSubview:self.view1];
}

- (void) addCollectionView {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    //布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置每个 Cell 的大小
    layout.itemSize = CGSizeMake(167, 80);
    // 设置 Cell 之间的最小水平间距
    layout.minimumInteritemSpacing = 10;
    // 设置 UICollectionView 的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    self.view2 = [[mineCollectionView alloc] initWithFrame:CGRectMake(0, 234, self.view.frame.size.width, 190) collectionViewLayout:layout];
    //self.view2.backgroundColor = UIColor.grayColor;
    [self.view addSubview: self.view2];
}


- (void) addTableview {

    self.view3 = [[mineTableview alloc] initWithFrame:CGRectMake(0, 424, 393, 346) style:UITableViewStyleGrouped];
    self.view3.scrollEnabled = NO;
    self.view3.backgroundColor = colorOfBack;
    self.view3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.view3];
    
}


@end
