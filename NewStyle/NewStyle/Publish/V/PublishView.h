//
//  PublishView.h
//  NewStyle
//
//  Created by chenglin on 2024/2/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishView : UIView
- (void)viewInit;
- (void)testPhoto;
@property (nonatomic, strong) UIImagePickerController *imagePicker; //从相册调相片
@property (nonatomic, strong) UIImage *image;
@end

NS_ASSUME_NONNULL_END
