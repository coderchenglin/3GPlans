//
//  SecondViewController.h
//  storyBoard_practice
//
//  Created by chenglin on 2024/8/14.
//


#import <UIKit/UIKit.h>

typedef void (^PassValueBlock)(NSString * _Nullable string);

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController

@property (nonatomic, copy) PassValueBlock block;

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (void)passValueWithBlock:(PassValueBlock)block;

@end

NS_ASSUME_NONNULL_END
