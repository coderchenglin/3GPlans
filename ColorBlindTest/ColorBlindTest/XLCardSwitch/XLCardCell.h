//
//  XLCardCell.h
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import <UIKit/UIKit.h>
#import "XLCardModel.h"
#import "XLCardCell.h"
#import "DemoViewController.h"



@class XLCardCell;

NS_ASSUME_NONNULL_BEGIN

@protocol XLCardCellDelegate <NSObject>

//选项点击代理，用于获取是哪个cell上的按钮
- (NSIndexPath *)buttonTappedInCell:(UICollectionViewCell *)cell;

- (void)cardCell:(XLCardCell *)cell didSelectOption:(NSString *)option atIndex:(NSInteger)index;

- (void)cardCellDidSelectAllOptions:(XLCardCell *)cell isAll:(BOOL)allQuestionAnswered;

- (void)cardCellDidTapSubmitButton:(XLCardCell *)cell withData:(NSString *)data;

@end


@interface XLCardCell : UICollectionViewCell

- (void)cardCell:(XLCardCell *)cell didSelectOption:(NSString *)option atIndex:(NSInteger)index;

@property (nonatomic, weak) id<XLCardCellDelegate> delegate;

- (void)updateButtonSelectionAtCellIndex:(NSInteger)cellIndex optionIndex:(NSInteger)optionIndex withOption:(NSString *)option;

//@property (nonatomic, strong) NSMutableArray<NSString *> *optionArray;

@property (nonatomic, strong) UIImageView *testImageView;

@property (nonatomic, strong) UIButton *testButton1;

@property (nonatomic, strong) UIButton *testButton2;

@property (nonatomic, strong) UIButton *testButton3;

@property (nonatomic, strong) UIButton *testButton4;

@property (nonatomic, strong) XLCardModel *model;

@end

NS_ASSUME_NONNULL_END
