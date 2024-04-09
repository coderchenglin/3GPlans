//
//  ColorModel.h
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import "JSONModel.h"

@protocol RGBAModel

@end

NS_ASSUME_NONNULL_BEGIN

//@interface RGBAModel : JSONModel
//
//@property (nonatomic, copy) NSString *Name;
//@property (nonatomic, copy) NSArray<NSString *> *R;
//@property (nonatomic, copy) NSArray<NSString *> *G;
//@property (nonatomic, copy) NSArray<NSString *> *B;
//@property (nonatomic, copy) NSArray<NSString *> *A;
//
//@end

@interface ColorModel : JSONModel

//@property (nonatomic, copy) NSArray<RGBAModel> *data;
@property (nonatomic, copy) NSArray* data;
//@property (nonatomic, copy) NSString* message;



@end

//@interface ColorModel : JSONModel
//
//@property (nonatomic, copy) NSString *Name;
//@property (nonatomic, copy) NSArray<ColorModell> *data;
////@property (nonatomic, copy) NSString *data;
//
//@end

NS_ASSUME_NONNULL_END
