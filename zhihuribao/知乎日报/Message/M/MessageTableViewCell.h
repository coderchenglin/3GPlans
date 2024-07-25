//
//  MessageTableViewCell.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/3.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "TopLeftLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView; //头像视图
@property (nonatomic, strong) UILabel *nameLabel;  //用户姓名Label
@property (nonatomic, strong) UILabel *showLabel;  //评论内容Label
@property (nonatomic, strong) UILabel *replyLabel; //回复内容Label
@property (nonatomic, strong) UILabel *lineLabel;  //顶部横线Label
@property (nonatomic, strong) UIButton *openButton; //展开按钮
@property (nonatomic, strong) UILabel *timeLabel;  //时间Label

@end

NS_ASSUME_NONNULL_END
