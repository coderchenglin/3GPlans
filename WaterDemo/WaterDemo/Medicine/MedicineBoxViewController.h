//
//  MedicineBoxViewController.h
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import <UIKit/UIKit.h>
#import "MedicineBoxView.h"
#import "MedicineBoxModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MedicineBoxViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) MedicineBoxView* mView ;
@property (nonatomic, strong) MedicineBoxModel* mModel ;


@end

NS_ASSUME_NONNULL_END
