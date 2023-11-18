//
//  AddViewController.h
//  weather_forecast
//
//  Created by chenglin on 2023/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegte <NSObject>

- (void)pressContent:(NSMutableArray *)array;

@end

@interface AddViewController : UIViewController

@property NSMutableArray *array;
@property id<AddViewControllerDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
