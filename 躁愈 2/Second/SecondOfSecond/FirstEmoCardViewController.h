//
//  ViewController.h
//  情绪卡片
//
//  Created by 夏楠 on 2024/3/28.
//

#import <UIKit/UIKit.h>

@interface FirstEmoCardViewController : UIViewController
- (void)moodButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) UITextView *noteTextView;
@property (copy, nonatomic) NSArray *moodTitles;
@property (copy, nonatomic) NSArray *moodImages;

@end

