//
//  ScrollerTableViewCell.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollerTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView *customCollectionView;
@property (nonatomic, copy) NSArray *scrollerImageArray;
@property (nonatomic, copy) NSArray *scrollerImageNameArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
