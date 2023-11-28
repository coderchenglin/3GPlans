//
//  OldNetworkJSONModel.h
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OldStoriesModel

@end

@interface OldStoriesModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *id;

@end

@interface OldNetworkJSONModel : JSONModel

@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSArray<OldStoriesModel> *stories;
@end

NS_ASSUME_NONNULL_END
