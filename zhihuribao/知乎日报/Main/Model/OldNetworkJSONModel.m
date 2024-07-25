//
//  OldNetworkJSONModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/23.
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
