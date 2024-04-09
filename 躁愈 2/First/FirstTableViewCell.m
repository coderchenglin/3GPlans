//
//  FirstTableViewCell.m
//  CollectionView1
//
//  Created by 夏楠 on 2024/2/23.
//

#import "FirstTableViewCell.h"
#import "SecondCollectionViewCell.h"
#import "Masonry.h"
#import "FirstCollectionViewCell.h"
#import "FirstModel.h"
@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.homeModel = [[FirstModel alloc] init];
    [self.homeModel setFirstTableViewCellArray];
    [self.homeModel setFirstTableViewCellJpgArray];
    [self.homeModel setFirstTableViewCellVideoArray];
    [self.homeModel setFirstTableViewCellSmallPicArray];
    [self.homeModel setFirstTableViewCellSubTitleArray];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor grayColor];
    
    self.seeLabel = [[UILabel alloc] init];
    self.seeLabel.font = [UIFont systemFontOfSize:14];
    self.seeLabel.textColor = [UIColor grayColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置item的大小
    layout.itemSize = CGSizeMake(250, 225);
    layout.minimumLineSpacing = 10;
    //创建collectionView 通过一个布局策略layout来创建
    self.customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 225) collectionViewLayout:layout];
    self.customCollectionView.delegate = self;
    self.customCollectionView.dataSource = self;
    //注册item类型 这里先使用系统的类型
    [self.customCollectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell1"];
    self.customCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.customCollectionView];
    [self.contentView addSubview:self.seeLabel];
    [self.contentView addSubview:self.titleLabel];
    
    return self;
}

- (void)layoutSubviews {
//    self.titleLabel.frame = CGRectMake(10, 10, 100, 15);
//    [self.seeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.titleLabel.mas_top);
//            make.bottom.equalTo(self.titleLabel.mas_bottom);
//            make.right.equalTo(self.contentView.mas_right).offset(-15);
//            make.width.equalTo(@50);
//    }];
    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10).offset(0);
            make.height.equalTo(@225);
            make.width.equalTo(@383);
        make.left.equalTo(@10);
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell1" forIndexPath:indexPath];
//    NSString *t1 = [NSString stringWithFormat:@"%ld.jpg", (long)indexPath.row];
//    cell.bigImageView.image = [UIImage imageNamed:t1];

    cell.smallImageView.image = [UIImage imageNamed:self.homeModel.setFirstTableViewCellSmallPicArray[indexPath.item]];
    cell.subtitleLabel.text = self.homeModel.firstTableViewCellSubTitleArray[indexPath.item];
    
    cell.bigImageView.image = [UIImage imageNamed:self.homeModel.firstTableViewCellJpgArray[indexPath.item]];
    cell.titleLabel.text = self.homeModel.firstTableViewCellArray[indexPath.item];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
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
    NSString *t = self.homeModel.firstTableViewCellVideoArray[indexPath.item];
    NSURL *videoURL = [NSURL URLWithString:t];
    _urlDic = [[NSDictionary alloc] init];
    _urlDic = @{@"key": videoURL};
    // 使用AVPlayer播放视频
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playVideo" object:nil userInfo:_urlDic];
}
@end
