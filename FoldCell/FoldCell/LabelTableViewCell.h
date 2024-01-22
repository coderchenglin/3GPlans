//
//  LabelTableViewCell.h
//  FoldCell
//
//  Created by chenglin on 2023/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelTableViewCell : UITableViewCell

//@property (nonatomic, assign) BOOL expanded;
//@property (nonatomic, strong) NSArray *contentArray;
//
//- (void)setupCellWithContent:(NSString *)content;

@property (nonatomic, strong) UILabel *showLabel;

@end

NS_ASSUME_NONNULL_END
