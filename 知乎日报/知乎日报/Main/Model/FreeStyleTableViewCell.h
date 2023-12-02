//
//  FreeStyleTableViewCell.h
//  知乎日报
//
//  Created by chenglin on 2023/11/28.
//
//
//#import <UIKit/UIKit.h>
//#import "Masonry.h"
//
//#define myWidth [UIScreen mainScreen].bounds.size.width
//#define myHeight [UIScreen mainScreen].bounds.size.height
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface FreeStyleTableViewCell : UITableViewCell
//
//@property (nonatomic, strong) UIImageView *showImageView;
//@property (nonatomic, strong) UILabel *mainLabel;
//@property (nonatomic, strong) UILabel *subLabel;
//
//@end
//
//NS_ASSUME_NONNULL_END


#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface FreeStyleTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *subLabel;

@end

NS_ASSUME_NONNULL_END
