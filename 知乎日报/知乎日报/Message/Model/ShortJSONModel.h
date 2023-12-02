//
//  ShortJSONModel.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

@protocol ShortCommentsModel
@end

@protocol ShortReplyToModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShortReplyToModel : JSONModel       //被回复的评论
@property (nonatomic, copy) NSString *content; //评论
@property (nonatomic, copy) NSString *author;  //作者
@end

@interface ShortCommentsModel : JSONModel
@property (nonatomic, copy) NSString *author;  //作者
@property (nonatomic, copy) NSString *content; //评论
@property (nonatomic, copy) NSString *avatar;  //头像
@property (nonatomic, copy) NSString *time;    //时间
@property (nonatomic, copy) ShortReplyToModel *reply_to;//被回复的评论
@end

@interface ShortJSONModel : JSONModel
@property (nonatomic, strong) NSArray<ShortCommentsModel> *comments;
@end

NS_ASSUME_NONNULL_END
