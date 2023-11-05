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
        [_pageControl addTarget:self action:@selector(pressPage) forControlEvents:UIControlEventValueChanged];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll:) userInfo:self repeats:YES];
    }
    return self;
}

- (void)layoutSubviews {
    _scrollView.frame = CGRectMake(0, 0, width, 250);
    _scrollView.contentSize = CGSizeMake(width * 6, 250);
    _pageControl.frame = CGRectMake(70, 200, 300, 50);
    if (_scrollView.tag == 301) {
        [_scrollView setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>]
    }
    
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
