//
//  FirstView.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FirstView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property UILabel *Date;
@property UILabel *Month;
@property (nonatomic, strong)UIImage *Line;
@property (nonatomic, strong)UIImageView *LineView;
@property (nonatomic, strong)UILabel *Tip;
@property (nonatomic, strong)UIButton *btn_head;


@property (nonatomic, strong) NSMutableArray* pastArray;
@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* pastTimeArray;

- (void)addCollectionView;
- (void)addTableView;
@property(nonatomic, strong)UITableView *tableView;
@property (strong ,nonatomic) UIColor *backColor;
@end

NS_ASSUME_NONNULL_END
