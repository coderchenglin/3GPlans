//
//  NetworkJSONModel.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

//创建一个JSONModel类
//
//@protocol StoriesModel
//
//@end
//
//@protocol Top_StoriesModel
//
//@end
//
//#import "JSONModel.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface StoriesModel : JSONModel
//
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *url;
//@property (nonatomic, strong) NSArray *images;
//@property (nonatomic, copy) NSString *hint;
//@property (nonatomic, copy) NSString *id;
//
//@end
//
//
//@interface Top_StoriesModel : JSONModel
//
//@property (nonatomic, copy) NSString *hint;
//@property (nonatomic, copy) NSString *url;
//@property (nonatomic, strong) NSString *image;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *id;
//
//@end
//
//
//@interface NetworkJSONModel : JSONModel
//
//@property (nonatomic, copy) NSString *date;
//@property (nonatomic, copy) NSArray<StoriesModel> *stories;
//@property (nonatomic, copy) NSArray<Top_StoriesModel> *top_stories;
//
//@end
//
//
//
//NS_ASSUME_NONNULL_END


@protocol StoriesModel
@end

@protocol Top_StoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *id;
@end

@interface Top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@end

@interface NetworkJSONModel : JSONModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<StoriesModel> *stories;
@property (nonatomic, copy) NSArray<Top_StoriesModel> *top_stories;

@end

NS_ASSUME_NONNULL_END
