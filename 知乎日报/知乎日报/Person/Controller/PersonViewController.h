//
//  PersonViewController.h
//  知乎日报
//
//  Created by chenglin on 2023/12/1.
//

#import <UIKit/UIKit.h>
#import "PersonView.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface PersonViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *allTransDataArray;
@property (nonatomic, strong) NSString *fileName;

@end

NS_ASSUME_NONNULL_END
