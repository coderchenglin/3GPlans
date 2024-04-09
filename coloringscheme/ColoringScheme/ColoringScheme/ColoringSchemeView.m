//
//  ColoringSchemeView.m
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import "ColoringSchemeView.h"
#import "Masonry.h"
#import "MyCollectionViewCell.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface ColoringSchemeView () 

@property (nonatomic, strong) UIImageView *backgroundImageView; //

@property (nonatomic, strong) UILabel *cellLabel;
@property (nonatomic, strong) UIImageView *titleImageView;




@end


@implementation ColoringSchemeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit {
    self.colorArray = [[NSMutableArray alloc] init];
//    self.cellLabel = [[UILabel alloc] init];
    [self titleLabelInit];
//    [self backgroundColorImageViewInit];
    [self collectionViewInit];
    
    [self leftTableViewInit];
    
    
//    [self setTestData];
    
    
}

//测试用数据
//- (void)setTestData {
//    self.R = 10.0;
//    self.G = 20.0;
//    self.B = 30.0;
//    self.A = 1.0;
//}

- (void)titleLabelInit {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"配色方案";
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.height.equalTo(@40);
        make.width.equalTo(@(0.6 * SIZE_WIDTH));
        make.left.equalTo(self).offset(SIZE_WIDTH / 2 - 0.3 * SIZE_WIDTH);
    }];
}


- (void)collectionViewInit {
    //layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((SIZE_WIDTH * 3 / 8) - 10, (SIZE_WIDTH * 3 / 8 - 10));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SIZE_WIDTH * 1 / 4, 90, SIZE_WIDTH * 3 / 4, SIZE_HEIGHT - 90 - 100) collectionViewLayout:layout];
    UIColor *groundColor = [UIColor colorWithRed:(240.0f / 255.f) green:(245.0f / 255.0f) blue:(243.0f / 255.0f) alpha:1.0f];
    self.collectionView.backgroundColor = groundColor;
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self addSubview:self.collectionView];
}

- (void)leftTableViewInit {
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, SIZE_WIDTH * 1 / 4, SIZE_HEIGHT - 90 - 100) style:UITableViewStylePlain];
    UIColor *groundColor = [UIColor colorWithRed:(220.0f / 255.f) green:(220.0f / 255.0f) blue:(225.0f / 255.0f) alpha:1.0f];
    self.leftTableView.backgroundColor = groundColor;
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self addSubview:self.leftTableView];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [self.R count];
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed: [self.R[indexPath.item] doubleValue] / 255.0 green: [self.G[indexPath.item] doubleValue] / 255.0 blue: [self.B[indexPath.item] doubleValue] / 255.0 alpha: [self.A[indexPath.item] doubleValue] / 255.0];
//    self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height * 2 / 3, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height * 1 / 3)];
//    self.cellLabel.textAlignment = NSTextAlignmentLeft;
//    self.cellLabel.backgroundColor = [UIColor whiteColor];
//
//    //self.cellLabel.text = [NSString stringWithFormat:@"%.1f %.1f %.1f,%.1f",self.R,self.G,self.B,self.A];
//    [cell.contentView addSubview:self.cellLabel];
//
//
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.nameArray count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
////    cell.textLabel.text = [NSString stringWithFormat:@"方案%ld",(long)indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.nameArray[indexPath.row]];
//
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
////    NSLog(@"%ld", indexPath.row);
//    self.tableViewCellIndex = indexPath.row;
//
//}

- (void)updateViewWithRGBArray: (NSArray *)rgbArray {
    if (rgbArray == nil || rgbArray.count == 0) {
        return;
    }
    
    self.nameArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in rgbArray) {
        [self.nameArray addObject: dict[@"Name"]];
    }
//    NSLog(@"%@,%lu", nameArray,(unsigned long)nameArray.count);
    [self.leftTableView reloadData];
}

- (void)updateCollectionViewWithRGBArray: (NSArray *)rgbArray andIndex: (NSInteger)tableViewCellIndex {
    self.colorArray = [[NSMutableArray alloc] init];
    NSDictionary* colorDict = rgbArray[tableViewCellIndex];
    self.R = colorDict[@"R"];
    NSLog(@"%@", self.R);
    self.G = colorDict[@"G"];
    self.B = colorDict[@"B"];
    self.A = colorDict[@"A"];
    [self.collectionView reloadData];
//    self.R = [[NSMutableArray alloc] init];
//    self.G = [[NSMutableArray alloc] init];
//    self.B = [[NSMutableArray alloc] init];
//    self.A = [[NSMutableArray alloc] init];
}



@end
