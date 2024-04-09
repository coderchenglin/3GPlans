//
//  MYLabel.h
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/3.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentTop = 0,
    VerticalAlignmentMiddle,
    VerticalAlignmentBotton,
} VerticalAlignment;

NS_ASSUME_NONNULL_BEGIN

@interface MYLabel : UILabel {

@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
