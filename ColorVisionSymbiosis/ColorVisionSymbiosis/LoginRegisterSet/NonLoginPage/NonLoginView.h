//
//  NonLoginView.h
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NonLoginView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView* collectionView;
@property (nonatomic, strong)NSArray* colorArray;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UIButton* loginButton;
@property (nonatomic, strong)UIButton* registerButton;
@property (nonatomic, strong)UIButton* loginByCodeButton;

@end

NS_ASSUME_NONNULL_END
