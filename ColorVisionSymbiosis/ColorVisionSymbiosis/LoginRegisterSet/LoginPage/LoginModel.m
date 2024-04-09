//
//  LoginModel.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "LoginModel.h"

@implementation LoginModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation CodeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation LoginByCodeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
