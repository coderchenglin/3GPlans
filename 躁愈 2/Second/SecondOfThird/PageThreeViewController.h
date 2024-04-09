//
//  PageThreeViewController.h
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import <UIKit/UIKit.h>
@class PageThreeView;
@class PageThreeModel;
@class ARPetViewController;
#import "KVOController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageThreeViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) PageThreeView *pageThreeView;
@property (nonatomic, strong) PageThreeModel *pageThreeModel;
@property (nonatomic, strong) ARPetViewController *aRPetViewController;
@property (strong, nonatomic) FBKVOController *kvoController;
@end

NS_ASSUME_NONNULL_END
