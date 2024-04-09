//
//  PhotoBrowseView.m
//  NewStyle
//
//  Created by chenglin on 2024/2/8.
//

#import "PhotoBrowseView.h"
#import "Masonry.h"

@interface PhotoBrowseView ()
@property (nonatomic, strong) UIImageView *mainImageView;
@end

@implementation PhotoBrowseView

- (void)viewInit {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.mainImageView];
    [self addMasonry];
}

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.image = self.shareImage;
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;//当内容（在这里指的是 _mainImageView 中的图像）的宽高比例与视图的宽高比例不同时，保持内容比例，将内容缩放以适应视图，同时确保内容完全显示在视图内。
    }
    return _mainImageView;
}

- (void)addMasonry {
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-200);
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
