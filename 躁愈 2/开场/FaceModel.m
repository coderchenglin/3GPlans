//
//  TestModel.m
//  EmotionalAnalysis
//
//  Created by 夏楠 on 2024/1/27.
//

#import "FaceModel.h"

@implementation FaceModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation ResultModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation ResponseModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation EmotionModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

