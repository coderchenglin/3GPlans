//
//  OldNetworkJSONModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/23.
//

@protocol OldStoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OldStoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *id;
@end

@interface OldNetworkJSONModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<OldStoriesModel> *stories;
@end

NS_ASSUME_NONNULL_END
