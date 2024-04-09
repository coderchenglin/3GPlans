//
//  SecondViewController.h
//  情绪卡片
//
//  Created by 夏楠 on 2024/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondEmoCardViewController : UIViewController
@property (strong, nonatomic) UITextField *noteTextView;
@property (strong, nonatomic) NSMutableArray *selectedButtons;
@property (strong, nonatomic) NSMutableArray *selectedButtonsNames;
@property (strong, nonatomic) NSMutableArray *selectedButtonsImages;

@property (copy, nonatomic) NSArray *iconNamesFirst;
@property (copy, nonatomic) NSArray *iconNamesSecond;
@property (copy, nonatomic) NSArray *iconTextNames;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, copy) NSString *emojyName;
@property (nonatomic, copy) NSString *emojyImage;
@property (nonatomic, copy) NSString *moodText;


#pragma mark 需要传给第一个页面与数据库的文字
//@property (copy, nonatomic) NSString *moodTitle;
//@property (copy, nonatomic) NSString *moodImage;

@end

NS_ASSUME_NONNULL_END
