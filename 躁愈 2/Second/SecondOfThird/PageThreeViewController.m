//
//  PageThreeViewController.m
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import "PageThreeViewController.h"
#import "PageThreeView.h"
#import "PageThreeModel.h"
#import "ARPetViewController.h"
#import "ARPetCollectionViewCell.h"
#import "User.h"
#import "ARPet.h"
@interface PageThreeViewController ()

@end

@implementation PageThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageThreeModel = [[PageThreeModel alloc] init];
    [self.pageThreeModel setARPetArray];
    [self.pageThreeModel setARPetModelArray];
    [self.pageThreeModel setARPetPngArray];
    [self.pageThreeModel setPetsPointsArray];
    
    self.pageThreeView = [[PageThreeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 763)];
    self.pageThreeView.customCollectionView.delegate = self;
    self.pageThreeView.customCollectionView.dataSource = self;
    [self.view addSubview:_pageThreeView];

    [self.pageThreeView.customCollectionView registerClass:[ARPetCollectionViewCell class] forCellWithReuseIdentifier:@"aRPetCollectionViewCell"];
    [self checkAndUnlockPets];

#pragma mark KVOController
    self.kvoController = [FBKVOController controllerWithObserver:self];
    
    // 假设self.user是你想要观察的对象
    [self.kvoController observe:[User shareUser]
                       keyPath:@"points"
                       options:NSKeyValueObservingOptionNew
                         block:^(id observer, id object, NSDictionary<NSString *,id> *change) {
                             // 这里处理属性变化，例如检查并解锁宠物
                             NSInteger newPoints = [change[NSKeyValueChangeNewKey] integerValue];
        NSLog(@"111");
        NSLog(@"%ld", (long)newPoints);
        [self checkAndUnlockPets];
                         }];
}

#pragma mark 检测AR宠物是否解锁
- (void)checkAndUnlockPets {
    for (ARPet *pet in self.pageThreeModel.petsPointsArray) { // 假设`petsArray`包含所有宠物实例
        if (!pet.isUnlocked && [User shareUser].points >= pet.unlockPoints) {
            pet.isUnlocked = YES;
            // 这里可以发送通知或调用方法来更新UI
            [self.pageThreeView.customCollectionView reloadData];
        }
    }
}

//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


//返回每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ARPetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aRPetCollectionViewCell" forIndexPath:indexPath];
    
    ARPet *pet = self.pageThreeModel.petsPointsArray[indexPath.row];
    
    cell.bigImageView.image = [UIImage imageNamed:self.pageThreeModel.aRPetPngArray[indexPath.row]];
    cell.titleLabel.text = self.pageThreeModel.aRPetArray[indexPath.row];
    cell.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (pet.isUnlocked) {
        cell.bigImageView.alpha = 1.0;
        cell.lockImageView.hidden = YES;
    } else {
        cell.bigImageView.alpha = 0.5; // 半透明表示未解锁
        cell.lockImageView.hidden = NO; // 显示一个锁定图标
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ARPet *selectedPet = self.pageThreeModel.petsPointsArray[indexPath.row];
    if (!selectedPet.isUnlocked) {
        // 弹出提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Locked" message:@"您的积分不足" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        self.aRPetViewController = [[ARPetViewController alloc] init];
        self.aRPetViewController.aRPetName = self.pageThreeModel.aRPetModelArray[indexPath.row];
        [self presentViewController:_aRPetViewController animated:YES completion:nil];    }
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
