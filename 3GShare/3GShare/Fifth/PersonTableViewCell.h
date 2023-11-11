//
//  PersonTableViewCell.h
//  3GShare
//
//  Created by chenglin on 2023/11/10.
//

#import <UIKit/UIKit.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface PersonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *personImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *lookButton;
@property (nonatomic, strong) UIButton *cengButton;


@end

NS_ASSUME_NONNULL_END
