//
//  LongJSONModel.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

@protocol LongCommentsModel
@end

@protocol LongReplyToModel
@end


#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LongReplyToModel : JSONModel   // 被回复的评论
@property (nonatomic, copy) NSString *comment; //评论
@property (nonatomic, copy) NSString *author;  //作者
@end

@interface LongCommentsModel : JSONModel
@property (nonatomic, copy) NSString *author;   //作者
@property (nonatomic, copy) NSString *content;  //评论
@property (nonatomic, copy) NSString *avatar;   //头像
@property (nonatomic, copy) NSString *time;     //时间
@property (nonatomic, copy) LongReplyToModel *relpy_to; //被回复的评论

@end

@interface LongJSONModel : JSONModel
@property (nonatomic, strong) NSArray<LongCommentsModel>* comments;
@end

NS_ASSUME_NONNULL_END
