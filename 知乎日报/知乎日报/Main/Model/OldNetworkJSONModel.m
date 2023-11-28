//
//  OldNetworkJSONModel.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import "OldNetworkJSONModel.h"

@implementation OldStoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation OldNetworkJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
