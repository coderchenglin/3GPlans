//
//  ColoringSchemeView.h
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColoringSchemeView : UIView {
//    NSInteger _tableViewCellIndex;
}

- (void)viewInit;
- (void)updateViewWithDic:(NSArray *)colorModel;
- (void)updateViewWithRGBArray: (NSArray *)rgbArray;
- (void)updateCollectionViewWithRGBArray: (NSArray *)rgbArray;
- (void)updateCollectionViewWithRGBArray: (NSArray *)rgbArray andIndex: (NSInteger)tableViewCellIndex;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) NSDictionary *transDictionaryModal;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, copy) NSArray<NSString *> *R;
@property (nonatomic, copy) NSArray<NSString *> *G;
@property (nonatomic, copy) NSArray<NSString *> *B;
@property (nonatomic, copy) NSArray<NSString *> *A;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, strong) NSMutableArray *nameArray;
//@property (nonatomic, assign)NSInteger tableViewCellIndex;

@end

NS_ASSUME_NONNULL_END
