//
//  DemoViewController.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import <UIKit/UIKit.h>
#import "XLCardModel.h"
#import "PopupViewController.h"

extern NSMutableArray * _Nullable optionArray;

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *transDataArray;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *OptionA;

@property (nonatomic, strong) NSString *OptionB;

@property (nonatomic, strong) NSString *OptionC;

@property (nonatomic, strong) NSString *OptionD;

@property (nonatomic, strong) XLCardModel *model;


//@property (nonatomic, assign) BOOL pagingEnabled;

@end

NS_ASSUME_NONNULL_END
