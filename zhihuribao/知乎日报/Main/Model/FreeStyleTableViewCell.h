//
//  FreeStyleTableViewCell.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface FreeStyleTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *showImageView; //图片
@property (nonatomic, strong) UILabel *mainLabel; //子标题
@property (nonatomic, strong) UILabel *subLabel; //副标题

@end

NS_ASSUME_NONNULL_END
