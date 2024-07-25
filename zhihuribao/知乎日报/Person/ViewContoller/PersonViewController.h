//
//  PersonViewController.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import <UIKit/UIKit.h>
#import "PersonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *allTransDataArray;
@property (nonatomic, copy) NSString *fileName;  //数据库路径

@end

NS_ASSUME_NONNULL_END
