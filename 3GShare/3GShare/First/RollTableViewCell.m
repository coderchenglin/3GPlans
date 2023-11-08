//
//  RollTableViewCell.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "RollTableViewCell.h"

@implementation RollTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([self.reuseIdentifier isEqualToString:@"roll"]) {
        _scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scrollView];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.tag = 301;
        
        NSString* imageName = [NSString stringWithFormat:@"main_img4.png"];
        UIImage* image= [UIImage imageNamed:imageName];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, width, 250);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15.0;
        [_scrollView addSubview:imageView];
        
        for (int i = 1; i < 5; i++) {
            NSString* imageName = [NSString stringWithFormat:@"main_img%d", i];
            UIImage* image = [UIImage imageNamed:imageName];
            UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(width * i, 0, width, 250);
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 15;
            [_scrollView addSubview:imageView];
        }
        imageName = [NSString stringWithFormat:@"main_img1.png"];
        image = [UIImage imageNamed:imageName];
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(width * 5, 0, width, 250);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15;
        [_scrollView addSubview:imageView];
        
        //设置_pageControl
        //UIPageControl 继承与UIControl ，
//        UIControl主要作用：
//        处理用户交互：UIControl 能够检测用户对应用界面的各种交互行为，比如触摸、点击、拖动等。
//        发出事件：当用户执行某些操作时，比如点击按钮，UIControl 对象会产生相应的事件，并将其传递给相关的目标（target）对象。

        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self.contentView addSubview:_pageControl];
        [_pageControl addTarget:self action:@selector(pessPage) forControlEvents:UIControlEventValueChanged];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:self repeats:YES];
    }
    return self;
}

- (void)layoutSubviews {
    _scrollView.frame = CGRectMake(0, 0, width, 250);
    _scrollView.contentSize = CGSizeMake(width * 6, 250);
    _pageControl.frame = CGRectMake(70, 200, 300, 50);
    //初始化到第二个图的位置（也就是第一张图），随后改变tag值，保证只会初始化一次
    if (_scrollView.tag == 301) {
        [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        _scrollView.tag = 302;
    }
}

- (void)pessPage {
//    if (_pageControl.currentPage == 0) {
//        [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
//    } else if (_pageControl.currentPage == 1) {
//        [_scrollView setContentOffset:CGPointMake(width * 2, 0) animated:NO];
//    } else if (_pageControl.currentPage == 2) {
//        [_scrollView setContentOffset:CGPointMake(width * 3, 0) animated:NO];
//    } else if (_pageControl.currentPage == 3) {
//        [_scrollView setContentOffset:CGPointMake(width * 4, 0) animated:NO];
//    }


}

//- (void)autoScroll:(NSTimer*)autoTimer {
//    if (_scrollView.contentOffset.x == width * 4) {
//        [_scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
//    } else {
//        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + width, 0) animated:YES];
//    }
//}

- (void)autoScroll:(NSTimer*)autoTimer {
//    if (_scrollView.contentOffset.x > width * 4) {
//        _scrollView.contentOffset = CGPointMake(width, 0);
//        _pageControl.currentPage = 0;
//        [_scrollView setContentOffset:CGPointMake(width * 2, 0) animated:YES];
////        _scrollView.contentOffset = CGPointMake(width * 1, 0);
//    } else {
//        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + width, 0) animated:YES];
//    }
    if (_scrollView.contentOffset.x > width * 4) {
        [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        [_scrollView setContentOffset:CGPointMake(width * 2, 0) animated:YES];
    } else if (_scrollView.contentOffset.x < width) {
        [_scrollView setContentOffset:CGPointMake(width * 4, 0)];
    }
    
    else {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + width, 0) animated:YES];
    }
    
    _pageControl.currentPage = (_scrollView.contentOffset.x) / width - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 201) {
        [_timer invalidate];
        _timer = nil;
    }
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    if (scrollView.tag == 201) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:self repeats:YES];
//    }
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 201) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:self repeats:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x > width * 5) {
        [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (_scrollView.contentOffset.x < width) {
        [_scrollView setContentOffset:CGPointMake(width * 5, 0)];
    }
    
    if(_scrollView.contentOffset.x == 0) {
        _pageControl.currentPage = 3;
    } else if(_scrollView.contentOffset.x == 5 * width) {
        //NSLog(@"%d", _scrollView.contentOffset.x == 5 * width);
        //NSLog(@"%ld", (long)_pageControl.currentPage);
        _pageControl.currentPage = 0;
        //NSLog(@"%ld", (long)_pageControl.currentPage);
    } else {
        _pageControl.currentPage = _scrollView.contentOffset.x / width;
    }
    
    _pageControl.currentPage = (_scrollView.contentOffset.x) / width - 1;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
