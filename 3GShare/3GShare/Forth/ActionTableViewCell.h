//
//  ActionTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/9.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ActionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UILabel *actionLabel;

@end

NS_ASSUME_NONNULL_END
