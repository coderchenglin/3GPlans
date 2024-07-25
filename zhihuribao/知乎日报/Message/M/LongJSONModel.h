//
//  LongJSONModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//
@protocol LongCommentsModel
@end

@protocol LongReplyToModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LongReplyToModel : JSONModel   //被回复的评论
@property (nonatomic, copy) NSString *content; //评论
@property (nonatomic, copy) NSString *author; //作者
@end

@interface LongCommentsModel : JSONModel
@property (nonatomic, copy) NSString *author; //作者
@property (nonatomic, copy) NSString *content; //评论
@property (nonatomic, copy) NSString *avatar; //头像
@property (nonatomic, copy) NSString *time; //时间
@property (nonatomic, copy) LongReplyToModel *reply_to; //被回复的评论
@end

@interface LongJSONModel : JSONModel
@property (nonatomic, strong) NSArray<LongCommentsModel> *comments;
@end

NS_ASSUME_NONNULL_END
