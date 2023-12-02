//
//  MessageViewController.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <UIKit/UIKit.h>
#import "MessageView.h"
#import "MessageTableViewCell.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : UIViewController

@property (nonatomic, strong) MessageView *messageView;

@property (nonatomic, strong) NSDictionary *shortDictionary;
@property (nonatomic, strong) NSDictionary *longDictionary;
@property (nonatomic, strong) NSMutableArray *longHeightArray;
@property (nonatomic, strong) NSMutableArray *shortHeightArray;
@property (nonatomic, strong) NSMutableArray *longReplyHeightArray;
@property (nonatomic, strong) NSMutableArray *shortReplyHeightArray;
@property (nonatomic, strong) NSMutableDictionary *longHeightDictionary;
@property (nonatomic, strong) NSMutableDictionary *shortHeightDictionary;

@end

NS_ASSUME_NONNULL_END
