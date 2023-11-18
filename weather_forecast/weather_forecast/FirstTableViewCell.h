//
//  FirstTableViewCell.h
//  weather_forecast
//
//  Created by chenglin on 2023/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell

- (void)give:(NSIndexPath *)indexPath Arr1:(NSMutableArray *)nameArr;

@property UILabel *nowLabel;
@property UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
