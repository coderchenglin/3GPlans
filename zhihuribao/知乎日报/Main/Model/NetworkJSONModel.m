//
//  NetworkJSONModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/18.
//

#import "NetworkJSONModel.h"

@implementation StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation Top_StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation NetworkJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
