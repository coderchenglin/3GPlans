//
//  SecondOfFirstTableViewCell.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/10.
//

#import "SecondOfFirstTableViewCell.h"
#import "SecondCollectionViewCell.h"
#import "Masonry.h"
#import "PageOneModel.h"
#import "FirstCollectionViewCell.h"
#import "ChaosViewController.h"
@implementation SecondOfFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.pageOneModel = [[PageOneModel alloc] init];
    [self.pageOneModel setSecondOfFirstTableViewCellArray];
    [self.pageOneModel setSecondOfFirstTableViewCellUrlArray];
    [self.pageOneModel setSecondOfFirstTableViewCellUrlArray];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.seeLabel = [[UILabel alloc] init];
    self.seeLabel.font = [UIFont systemFontOfSize:14];
    self.seeLabel.textColor = [UIColor grayColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置item的大小
    layout.itemSize = CGSizeMake(170, 170);
    layout.minimumLineSpacing = 10;
    //创建collectionView 通过一个布局策略layout来创建
    self.customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 230) collectionViewLayout:layout];
    self.customCollectionView.delegate = self;
    self.customCollectionView.dataSource = self;
    //注册item类型 这里先使用系统的类型
    self.customCollectionView.showsHorizontalScrollIndicator = NO;
    self.customCollectionView.showsVerticalScrollIndicator = NO;
    self.customCollectionView.backgroundColor = [UIColor clearColor];

    [self.customCollectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:@"secondOfFirstTableViewCell"];
    
    [self.contentView addSubview:self.customCollectionView];
    [self.contentView addSubview:self.seeLabel];
    [self.contentView addSubview:self.titleLabel];
    
    return self;
}

- (void)layoutSubviews {
    self.titleLabel.frame = CGRectMake(10, 10, 100, 15);
    [self.seeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_top);
            make.bottom.equalTo(self.titleLabel.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.equalTo(@50);
    }];
    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.height.equalTo(@215);
            make.width.equalTo(@373);
            make.left.equalTo(self.titleLabel.mas_left);
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        SecondCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondOfFirstTableViewCell" forIndexPath:indexPath];
        NSString *t1 = [NSString stringWithFormat:@"SecondOfFirstTableViewCell%ld.png", (long)indexPath.row + 1];
        cell.bigImageView.image = [UIImage imageNamed:t1];
        cell.titleLabel.text = _pageOneModel.secondOfFirstTableViewCellArray[indexPath.row];
        return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 假设你有一个视频URLs数组，对应于每个单元格
    NSString *t = self.pageOneModel.secondOfFirstTableViewCellUrlArray[indexPath.item];
    _urlDic = [[NSDictionary alloc] init];
    _urlDic = @{@"key": t};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"article" object:nil userInfo:_urlDic];
}



@end
