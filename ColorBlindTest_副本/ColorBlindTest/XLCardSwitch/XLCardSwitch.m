//
//  XLCardSwitch.m
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/24.
//

#import "XLCardSwitch.h"
#import "XLCardSwitchFlowLayout.h"
#import "XLCardCell.h"
#import "DemoViewController.h"
#import "Manager.h"

@interface XLCardSwitch ()

//@property (nonatomic, assign) CGFloat dragStartX;
//
//@property (nonatomic, assign) CGFloat dragEndX;
//
//@property (nonatomic, assign) CGFloat dragAtIndex;

@end


@implementation XLCardSwitch

//- (instancetype)init {
//    if (self = [super init]) {
//        [self buildUI];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addCollectionView];
//    [self initSubmitButton];
}

//添加collectionView
- (void)addCollectionView {
    //避免UINavigation对UIScrollView产生的偏移问题
    [self addSubview:[UIView new]];
    XLCardSwitchFlowLayout *flowLayout = [[XLCardSwitchFlowLayout alloc] init];
    __weak typeof(self)weakSelf = self;
    flowLayout.centerBlock = ^(NSIndexPath *indexPath) {
        [weakSelf updateSelectedIndex:indexPath];
    };
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[XLCardCell class] forCellWithReuseIdentifier:@"XLCardCell"];
    self.collectionView.userInteractionEnabled = true;
    
    [self addSubview:self.collectionView];
}

//更新选中的index
- (void)updateSelectedIndex:(NSIndexPath *)indexPath {
    if (indexPath.row != _selectedIndex) {
        _selectedIndex = indexPath.row;
        [self performScrollDelegateMethod];  //滚动方法
    }
}

//初始化点击按钮
//- (void)initSubmitButton {
//    if (!self.submitButton) {
//        self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
//        [self.submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [self.collectionView addSubview:_submitButton];
//        self.submitButton.frame = CGRectMake(100, 600, 190, 50);
//        self.submitButton.hidden = YES; //先隐藏
//    }
//}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

//重写数据源数组的Models写方法，写入时，自动reloadData
- (void)setModels:(NSArray<XLCardModel *> *)models {
    _models = models;
    [self.collectionView reloadData];
}

//配置cell居中
- (void)fixCellToCenter {
    if (_selectedIndex != [self dragAtIndex]) {
        [self scrollToCenterAnimated:true];
        return;
    }
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.f;
    if (self.dragStartX - self.dragEndX >= dragMiniDistance) {
        _selectedIndex -=1; //向右
    } else if(self.dragEndX - self.dragStartX >= dragMiniDistance) {
        _selectedIndex +=1; //向左
    }
    
    NSInteger maxIndex = [self.collectionView numberOfItemsInSection:0] -1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    [self scrollToCenterAnimated:true];
}

//滚动到中间
- (void)scrollToCenterAnimated:(BOOL)animated {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

////手指拖动开始
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (!_pagingEnabled) {return;}
//    self.dragStartX = scrollView.contentOffset.x;
//    self.dragAtIndex = _selectedIndex;
//}
//
////手指拖动结束
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!_pagingEnabled) {return;}
//    self.dragEndX = scrollView.contentOffset.x;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self fixCellToCenter];
//    });
//}
//
////点击方法
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    _selectedIndex = indexPath.row;
//    [self scrollToCenterAnimated:YES];
//    [self performClickDelegateMethod];
//}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 2;
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    static NSString *cellId = @"XLCardCell";
//    XLCardCell *card = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//
//    card.testImageView =
//    //card.model = self.models[indexPath.row];
//    return card;
//}

//重写selectedIndex的写方法
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self switchToIndex:selectedIndex animated:false];
}

- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated {
    _selectedIndex = index;
    [self scrollToCenterAnimated:animated];
}


#pragma mark 点击和滚动方法
- (void)performClickDelegateMethod {
    if ([_delegate respondsToSelector:@selector(cardSwitchDidClickAtIndex:)]) {
        [_delegate cardSwitchDidClickAtIndex:_selectedIndex];
    }
}

- (void)performScrollDelegateMethod {
    if ([_delegate respondsToSelector:@selector(cardSwitchDidScrollToIndex:)]) {
        [_delegate cardSwitchDidScrollToIndex:_selectedIndex];
    }
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
