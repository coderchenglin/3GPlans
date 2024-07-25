//
//  ShortJSONModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
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
