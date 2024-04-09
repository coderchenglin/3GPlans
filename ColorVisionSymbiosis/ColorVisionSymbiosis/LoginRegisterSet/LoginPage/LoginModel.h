//
//  LoginModel.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

@interface CodeModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

@interface LoginByCodeModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

NS_ASSUME_NONNULL_END
