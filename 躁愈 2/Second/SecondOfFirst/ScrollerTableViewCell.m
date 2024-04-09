//
//  ScrollerTableViewCell.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/6.
//

#import "ScrollerTableViewCell.h"
#import "ScrollerCollectionViewCell.h"
@implementation ScrollerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 水平滚动
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 225); // 设置单个项目的大小
    layout.minimumLineSpacing = 0; // 移除单元格之间的空间

    self.customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225) collectionViewLayout:layout];
    self.customCollectionView.pagingEnabled = YES; // 开启分页
    self.customCollectionView.showsHorizontalScrollIndicator = NO; // 不显示水平滚动条
    self.customCollectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.customCollectionView];
    [self.customCollectionView registerClass:[ScrollerCollectionViewCell class] forCellWithReuseIdentifier:@"scrollerCollectionCell"];

    self.customCollectionView.dataSource = self;
    self.customCollectionView.delegate = self;
    
    _scrollerImageArray = [[NSArray alloc] init];
    self.scrollerImageArray = @[@"scrollerImage1.png", @"scrollerImage2.png", @"scrollerImage3.png", @"scrollerImage4.png", @"scrollerImage5.png"];
    
    _scrollerImageNameArray = [[NSArray alloc] init];
    self.scrollerImageNameArray = @[@"亲密关系", @"应对压力", @"舒缓悲伤", @"平复愤怒", @"沮丧"];
    
#pragma mark 让collectionView一开始就显示第二个cell
    NSIndexPath *secondItemIndexPath = [NSIndexPath indexPathForItem:1 inSection:0]; // 第二个 item 的 IndexPath
    [self.customCollectionView scrollToItemAtIndexPath:secondItemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    CGFloat pageControlY = CGRectGetMaxY(self.customCollectionView.frame) - 20;
    self.pageControl.frame = CGRectMake(130, pageControlY, CGRectGetWidth(self.contentView.frame), 0);
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _scrollerImageArray.count + 2; // imagesArray 是包含你轮播图图片的数组
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScrollerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollerCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSString *imageName;
    if (indexPath.item == 0) {
            imageName = _scrollerImageArray.lastObject; // 第一个 cell 显示最后一张图片
        cell.titleLabel.text = _scrollerImageNameArray[4];
        } else if (indexPath.item == 6) {
            imageName = _scrollerImageArray.firstObject; // 最后一个 cell 显示第一张图片
            cell.titleLabel.text = _scrollerImageNameArray[0];
        } else {
            imageName = _scrollerImageArray[indexPath.item - 1]; // 其他情况正常显示图片
            cell.titleLabel.text = _scrollerImageNameArray[indexPath.row - 1];
        }
    cell.bigImageView.image = [UIImage imageNamed:imageName];
    cell.titleLabel.font = [UIFont systemFontOfSize:26];
//    NSLog(@"%@", _t[indexPath.row]);
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当前滚动到的x位置
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = CGRectGetWidth(scrollView.frame);
    CGFloat contentWidth = scrollView.contentSize.width;
    
    // 滚动到最后一张视图之后，将滚动位置重置到第二张图片
    if (contentOffsetX >= contentWidth - screenWidth) {
        [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    }
    
    else if (contentOffsetX <= 0 ) {
        [scrollView setContentOffset:CGPointMake(5 * screenWidth, 0) animated:NO];
        //        self.pageControl.currentPage = 5;
        return;
    }
}

- (void)scrollToNextPage {
    NSInteger itemsCount = [self.customCollectionView numberOfItemsInSection:0];
    if (itemsCount <= 1) return; // 如果只有一个项目，不滚动

    // 获取当前显示的indexPath
    NSIndexPath *currentIndexPath = [[self.customCollectionView indexPathsForVisibleItems] lastObject];
    
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    
    if (nextItem == itemsCount) {
        // 如果是最后一个item，滚动到第二个item（index 1）
        nextItem = 1;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        [self.customCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else {
        [self.customCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

@end
