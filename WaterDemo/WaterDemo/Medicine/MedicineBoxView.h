//
//  MedicineBoxView.h
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import <UIKit/UIKit.h>
#import "MyFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface MedicineBoxView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField* searchtextfield ;//搜索栏
@property (nonatomic, strong) UICollectionView* MedicineBox_collectionView ;
@property (nonatomic, strong) MyFlowLayout* layout ;
@property (nonatomic, strong) UIButton* addbox_btn ;//药箱添加按钮

- (void)initView ;
@end

NS_ASSUME_NONNULL_END
