//
//  MessageViewController.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import <UIKit/UIKit.h>
#import "MessageView.h"
#import "MessageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MessageView *messageView;

@property (nonatomic, strong) NSDictionary *longDictionary;    //保存网络请求下来长评论和长回复的内容的字典
@property (nonatomic, strong) NSDictionary *shortDictionary;   //保存网络请求下来短评论和短回复的内容的字典
@property (nonatomic, strong) NSMutableArray *longHeightArray;  //长评论高度数组
@property (nonatomic, strong) NSMutableArray *shortHeightArray; //短评论高度数组
@property (nonatomic, strong) NSMutableArray *longReplyHeightArray;  //长回复高度数组
@property (nonatomic, strong) NSMutableArray *shorReplytHeightArray; //短评论高度数组
@property (nonatomic, strong) NSMutableDictionary *longHeightDictionary;  //长评论和长回复高度的字典，保存两个数组
@property (nonatomic, strong) NSMutableDictionary *shortHeightDictionary; //短评论和短回复高度的字典，保存两个数组

@end

NS_ASSUME_NONNULL_END
