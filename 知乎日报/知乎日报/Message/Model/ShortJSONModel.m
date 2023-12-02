//
//  ShortJSONModel.m
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import "ShortJSONModel.h"


@implementation ShortReplyToModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ShortCommentsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ShortJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
