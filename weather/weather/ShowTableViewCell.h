//
//  ShowTableViewCell.h
//  weather
//
//  Created by chenglin on 2023/11/19.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ShowTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *bigLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *maxLabel;
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxNameLabel;
@property (nonatomic, strong) UILabel *minNameLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
