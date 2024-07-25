//
//  LongJSONModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
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
