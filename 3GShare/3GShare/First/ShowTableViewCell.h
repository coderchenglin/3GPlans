//
//  ShowTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *describeLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UILabel *tipsLable;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *lookButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) NSString *good;
@property (nonatomic, strong) NSString *look;
@property (nonatomic, strong) NSString *share;
@property (nonatomic, assign) int lookNumber;
@property (nonatomic, assign) int shareNumber;


@end

NS_ASSUME_NONNULL_END
