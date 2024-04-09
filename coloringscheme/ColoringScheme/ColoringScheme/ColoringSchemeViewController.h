//
//  ColoringSchemeViewController.h
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColoringSchemeViewController : UIViewController

@property (nonatomic, strong) ColorModel *getJSONModel;
@property (nonatomic, strong) NSDictionary *dictionaryModel;
@property (nonatomic, strong) NSArray *arrayModel;
@property (nonatomic, assign) float Id;
@property (nonatomic, assign) float R;
@property (nonatomic, assign) float G;
@property (nonatomic, assign) float B;
@property (nonatomic, assign) float A;
@property (nonatomic, assign) NSString *Name;
@property (nonatomic, strong) NSMutableArray *nameArray;


@end

NS_ASSUME_NONNULL_END
