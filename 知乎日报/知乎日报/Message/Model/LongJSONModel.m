//
//  LongJSONModel.m
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import "LongJSONModel.h"

@implementation LongReplyToModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation LongCommentsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation LongJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
