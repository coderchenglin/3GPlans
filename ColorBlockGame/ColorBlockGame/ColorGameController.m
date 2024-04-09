//
//  ColorGameController.m
//  ColorBlockGame
//
//  Created by chenglin on 2024/2/18.
//

#import "ColorGameController.h"

@interface ColorGameController ()

@end

@implementation ColorGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorGameModel = [[ColorGameModel alloc] init];
    self.blocks = [[NSMutableArray alloc] init];
    
    self.colorGameView = [[ColorGameView alloc] initWithFrame: self.view.bounds];
    self.colorGameView.collectionView.delegate = self;
    self.colorGameView.collectionView.dataSource = self;
    [self.view addSubview: self.colorGameView];
    
    [self resetGame];
    [self generateColorBlocks];
    
//    [self setTimer];
    
}

- (void)setTimer {
    self.currentTime = 10.0;
    self.colorGameView.progressView.progress = self.currentTime;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(updateProgress) userInfo: nil repeats: YES];
}

- (void)updateProgress {
    self.currentTime -= 0.01;
    [self.colorGameView.progressView setProgress: self.currentTime / 10.0 animated: YES];
    
    NSLog(@"%f", self.currentTime);
    if (self.currentTime <= 0.0) {
        NSLog(@"dwad");
        [self.gameTimer invalidate];
        self.gameTimer = nil;
        [self resetGame];
        [self generateColorBlocks];
        [self updateUI];
    }
}



#pragma mark 色块

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%ld", [self.blocks count]);
    return [self.blocks count];
//    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath: indexPath];
    ColorBlockModel* block = self.blocks[indexPath.row];
    cell.backgroundColor = block.color;
//    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld %ld", indexPath.item, indexPath.row);
    ColorBlockModel* selectedBlock = self.blocks[indexPath.item];
    if (selectedBlock.isDifferent) {
        [self.gameTimer invalidate];
        self.gameTimer = nil;
        [self setTimer];
        self.colorGameModel.currentScore++;
        if (self.colorGameModel.currentScore % 1 == 0) {
            self.colorGameModel.level++;
        }
        [self generateColorBlocks];
    } else {
        self.colorGameModel.health--;
        if (!self.colorGameModel.health) {
            [self resetGame];
            [self generateColorBlocks];
        }
    }
    
    [self updateUI];
}

#pragma mark 啊啥的

- (void)resetGame {
    self.colorGameModel.currentScore = 0;
    self.colorGameModel.health = 5;
    self.colorGameModel.level = 3;
    [self.gameTimer invalidate]; //停止计时器
    self.gameTimer = nil;
    [self setTimer];
    [self updateUI];
}

- (void)updateUI {
    self.colorGameView.scoreLabel.text = [NSString stringWithFormat: @"分数：%ld", self.colorGameModel.currentScore];
    self.colorGameView.healthLabel.text = [NSString stringWithFormat: @"血量：%ld", self.colorGameModel.health];
    
    [self updateGridLayout]; //更新网格布局
    [self.colorGameView.collectionView reloadData];
}

//更新数据源数组
- (void)generateColorBlocks {
    [self.blocks removeAllObjects];
    
    NSInteger numberOfBlocks = self.colorGameModel.level * self.colorGameModel.level; //总个数
    NSInteger randomIndex = arc4random_uniform((uint32_t)numberOfBlocks); //生成一个[0，numberOfBlocks）之间的随机整数
    
    NSInteger R = (arc4random() % 256);
    NSInteger G = (arc4random() % 256);
    NSInteger B = (arc4random() % 256);
    UIColor* randomColor = [UIColor colorWithRed: R / 255.0 green: G / 255.0 blue: B / 255.0 alpha: 1.0];
    
    UIColor* differentColor = [self slightlyDifferentFrom: randomColor];
    
    for (NSInteger i = 0; i < numberOfBlocks; ++i) {
        ColorBlockModel* block = [[ColorBlockModel alloc] init];
        if (i == randomIndex) {
            block.color = differentColor;
            block.isDifferent = YES;
        } else {
            block.color = randomColor;
            block.isDifferent = NO;
        }
        
        [self.blocks addObject: block];
    }
}

//略有不同
- (UIColor *)slightlyDifferentFrom: (UIColor *)color {
    //HSB A 这四个参数是通过引用（&）传递的，所以方法执行后，它们会被赋予normalColor对应的值。如果颜色成功转换为HSBA表示，方法会返回YES，代码块内的逻辑就会执行
    CGFloat hue, saturation, brightness, alpha; //色调、饱和度、亮度、透明度;
    if ([color getHue: &hue saturation: &saturation brightness: &brightness alpha: &alpha]) {
        CGFloat brightnessDelta = 0.10; //亮度增量
        brightness += (brightness > 0.5) ? -brightnessDelta : brightnessDelta;
        
        return [UIColor colorWithHue: hue saturation: saturation brightness: brightness alpha: alpha];
    }
    
    return color;
}

//更新网格视图
- (void)updateGridLayout {
    CGFloat totalWidth = self.colorGameView.collectionView.bounds.size.width;
    CGFloat spacing = ((UICollectionViewFlowLayout *)self.colorGameView.collectionView.collectionViewLayout).minimumInteritemSpacing;
    CGFloat sectionInsetLeft = ((UICollectionViewFlowLayout *)self.colorGameView.collectionView.collectionViewLayout).sectionInset.left; //获取每个section的左边距
    CGFloat sectionInsetRight = ((UICollectionViewFlowLayout *)self.colorGameView.collectionView.collectionViewLayout).sectionInset.right; //获取每个section的右边距
    
    NSInteger itemsPerRow = self.colorGameModel.level; // 根据n的值确定每行的item数量
    
    CGFloat totalSpacing = (itemsPerRow - 1) * spacing; // 总共的间距
    CGFloat totalInset = sectionInsetLeft + sectionInsetRight; // 总内边距
    CGFloat availableWidth = totalWidth - totalSpacing - totalInset; // 用于item的总可用宽度
    
    CGFloat itemWidth = availableWidth / itemsPerRow; // 计算item的宽度（和高度一样）
    ((UICollectionViewFlowLayout *)self.colorGameView.collectionView.collectionViewLayout).itemSize = CGSizeMake(itemWidth, itemWidth); // 设置item大小
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
