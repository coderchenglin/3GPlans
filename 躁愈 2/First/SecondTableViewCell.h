//
//  SecondTableViewCell.h
//  CollectionView1
//
//  Created by 夏楠 on 2024/2/23.
//

#import <UIKit/UIKit.h>
@class FirstModel;
NS_ASSUME_NONNULL_BEGIN

@interface SecondTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *seeLabel;
@property (strong, nonatomic) UICollectionView *customCollectionView;
@property (nonatomic, strong) FirstModel *homeModel;
@property (nonatomic, copy) NSDictionary *urlDic;
@end

NS_ASSUME_NONNULL_END
