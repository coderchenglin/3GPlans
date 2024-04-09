//
//  ColorGameView.m
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import "ColorGameView.h"

@implementation ColorGameView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setUI];
        [self resetGame];
    }
    return self;
}

- (void)setUI {
    //色块
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 7;  //最小行间距
    flowLayout.minimumInteritemSpacing = 7; //最小列间距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width / 1.5, [UIScreen mainScreen].bounds.size.height / 2) collectionViewLayout: flowLayout];
    [self addSubview: self.collectionView];
    [self.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: @"cell"];
    
    self.scoreLabel = [[UILabel alloc] initWithFrame: CGRectMake(100, 600, [UIScreen mainScreen].bounds.size.width / 2, 50)];
    self.scoreLabel.textColor = [UIColor whiteColor];
    [self addSubview: self.scoreLabel];
    
    self.healthLabel = [[UILabel alloc] initWithFrame: CGRectMake(100, 700, [UIScreen mainScreen].bounds.size.width / 2, 50)];
    self.healthLabel.textColor = [UIColor whiteColor];
    [self addSubview: self.healthLabel];
    
    self.progressView = [[UIProgressView alloc] initWithFrame: CGRectMake(100, 800, [UIScreen mainScreen].bounds.size.width / 1.5, 100)];
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
//    self.progressView.progressViewStyle = UIProgressViewStyleBar;
//    [self.progressView setProgress: 1.0 animated: YES];
    self.progressView.progress = 1.0;
    self.progressView.tintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor whiteColor];
    [self addSubview: self.progressView];
}

- (void)resetGame {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
