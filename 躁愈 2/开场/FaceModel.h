//
//  TestModel.h
//  EmotionalAnalysis
//
//  Created by 夏楠 on 2024/1/27.
//

#import "JSONModel.h"
@protocol FaceModel
@end
@protocol ResponseModel
@end
@protocol ResultModel
@end
@protocol EmotionModel
@end
NS_ASSUME_NONNULL_BEGIN

@interface EmotionModel : JSONModel
@property (nonatomic, strong) NSString* type;
@property (nonatomic, assign) CGFloat probability;
@end

@interface FaceModel : JSONModel
@property (nonatomic, strong) EmotionModel* emotion;
@end

@interface ResultModel : JSONModel
@property (nonatomic, assign) NSInteger face_num;
@property (nonatomic, strong) NSArray<FaceModel>*face_list;
@end

@interface ResponseModel : JSONModel
@property (nonatomic, assign) NSInteger error_code;
@property (nonatomic, strong) NSString* error_msg;
@property (nonatomic, assign) NSInteger log_id;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) NSInteger cached;
@property (nonatomic, strong) ResultModel* result;
@end

NS_ASSUME_NONNULL_END
