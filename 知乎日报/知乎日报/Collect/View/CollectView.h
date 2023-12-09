//
//  CollectView.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <UIKit/UIKit.h>
#import "FreeStyleTableViewCell.h"
#import "SDWebImage.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface CollectView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FreeStyleTableViewCell *showCell;
@property (nonatomic, strong) UITableView *showTableView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) NSInteger judgeThings;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) NSMutableArray *allTransDataArray;

@end

NS_ASSUME_NONNULL_END
