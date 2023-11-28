//
//  NetworkJSONModel.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
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

