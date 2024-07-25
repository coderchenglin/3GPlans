//
//  CollectView.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/30.
//

#import <UIKit/UIKit.h>
#import "FreeStyleTableViewCell.h"
#import "SDWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FreeStyleTableViewCell *showCell; //新闻栏自定义cell
@property (nonatomic, strong) UITableView *showTableView; //tableView
@property (nonatomic, strong) UIButton *backButton;//返回按钮
@property (nonatomic, assign) NSInteger judgeThings; //代表有无收藏内容
@property (nonatomic, strong) UILabel *tipsLabel; //副标题
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UIView *topView;//顶部视图

@property (nonatomic, strong) NSMutableArray *allTransDataArray;  //存储传过来的数据

@end

NS_ASSUME_NONNULL_END
