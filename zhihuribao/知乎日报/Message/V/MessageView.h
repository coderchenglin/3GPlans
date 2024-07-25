//
//  MessageView.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MessageTableViewCell.h"
#import "SDWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageView : UIView<UITableViewDelegate, UITableViewDataSource>
//顶部视图的返回按钮，标题，横线
@property (nonatomic, strong) UIView *topView;    //顶部视图
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UITableView *messageTableView; //tableView
@property (nonatomic, strong) MessageTableViewCell *messageCell; //自定义cell
@property (nonatomic, strong) UIButton *openButton; //展开按钮

@property (nonatomic, strong) NSMutableArray *longDataArray;   //存储长评论和长回复（如果有的话）的所有内容
@property (nonatomic, strong) NSMutableArray *shortDataArray;  //存储短评论和短回复（如果有的话）的所有内容
@property (nonatomic, strong) NSMutableArray *tempArray;  //临时数组
@property (nonatomic, assign) NSInteger longNumber;  //存储有几条长评论
@property (nonatomic, assign) NSInteger shortNumber; //存储有几条短评论
@property (nonatomic, copy) NSString *allMessageNumber;  //存储总共有几条评论（长+短）
@property (nonatomic, strong) NSMutableArray *longHeightArray;   //存储长评论高度数组
@property (nonatomic, strong) NSMutableArray *shortHeightArray;  //存储短评论高度数组
@property (nonatomic, strong) NSMutableArray *longReplyHeightArray;  //存储长回复高度数组
@property (nonatomic, strong) NSMutableArray *shorReplytHeightArray; //存储短回复高度数组
@property (nonatomic, strong) NSMutableArray *longOpenFlagArray;   //存储长回复是否打开的标志状态
@property (nonatomic, strong) NSMutableArray *shortOpenFlagArray;  //存储短回复是否打开的标志状态

//时间戳转时间
- (NSString *)getTimeFromTimestamp:(NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
