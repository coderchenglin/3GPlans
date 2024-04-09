//
//  ColoringSchemeViewController.m
//  ColoringScheme
//
//  Created by chenglin on 2024/3/22.
//

#import "ColoringSchemeViewController.h"
#import "ColoringSchemeView.h"
#import "ColorModel.h"
#import "Manager.h"
#import "MyCollectionViewCell.h"

@interface ColoringSchemeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ColoringSchemeView *coloringSchemeView;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) UILabel *cellLabel;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, assign) NSInteger tag;

@end

@implementation ColoringSchemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.coloringSchemeView = [[ColoringSchemeView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.coloringSchemeView];
    
    self.coloringSchemeView.leftTableView.delegate = self;
    self.coloringSchemeView.leftTableView.dataSource = self;
    self.coloringSchemeView.collectionView.delegate = self;
    self.coloringSchemeView.collectionView.dataSource = self;
    
    self.tag = 0;
    
    //[self.coloringSchemeView viewInit];
    
    [self getColorModel];
}

- (void)getColorModel {
    
    [[Manager sharedManager] requestColoringScheme:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb0lkIjoyLCJleHAiOjE3MTE0MDkzMTQsImlhdCI6MTcxMTM2NjExNCwiaXNzIjoi5bCP6LW1Iiwic3ViIjoiY29sb3IifQ.4SDHTS2xATY8Fz4Xzyx8sGjXSbjf6Uh66iwQ-pwuilo" success:^(ColorModel * _Nonnull colorModel) {
        
        //这里有个理解，Model本身，一定是一个字典，只是，你拿到什么数据，取决于你Model中定义了哪些属性，所以先转为字典
        self.dictionaryModel = [colorModel toDictionary];
//        NSLog(@"%@,%d",colorModel,__LINE__);
        //然后这个字典里只有数组data
        self.arrayModel = self.dictionaryModel[@"data"];
        self.colorArray = self.arrayModel[0][@"color"];
//        NSLog(@"%d",[self.arrayModel count]);
//        self.colorArray = self.arrayModel;
//        NSArray *colorArray = self.arrayModel[0][@"color"];
//        NSLog(@"%@",colorArray[1][@"B"]);
//        NSLog(@"%f", [colorArray[0][@"Id"] intValue]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.coloringSchemeView.collectionView reloadData];
            [self.coloringSchemeView.leftTableView reloadData];
        });
        
    } failure:^(NSError * _Nonnull error) {
        if (error)
            NSLog(@"网络连接失败");
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSArray *test = self.colorArray;
    if ([test isKindOfClass:[NSArray class]]){
        return [self.colorArray count];
    } else {
        return 0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];


    self.Id = [self.colorArray[indexPath.item][@"Id"] floatValue];
    self.R = [self.colorArray[indexPath.item][@"R"] floatValue];
    self.G = [self.colorArray[indexPath.item][@"G"] floatValue];
    self.B = [self.colorArray[indexPath.item][@"B"] floatValue];
    self.A = [self.colorArray[indexPath.item][@"A"] floatValue];

    cell.backgroundColor = [UIColor colorWithRed:(self.R / 255.0f) green:(self.G / 255.0f) blue:(self.B / 255.0f) alpha:self.A];
    self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height * 2 / 3, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height * 1 / 3)];
    self.cellLabel.textAlignment = NSTextAlignmentLeft;
    self.cellLabel.backgroundColor = [UIColor whiteColor];

    self.cellLabel.text = [NSString stringWithFormat:@"%1.f %1.f %1.f %1.f",self.R,self.G,self.B,self.A];
    [cell.contentView addSubview:self.cellLabel];


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.colorArray = self.arrayModel[indexPath.row][@"color"];
    self.tag = indexPath.row;
    NSLog(@"%@", self.colorArray);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coloringSchemeView.collectionView reloadData];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.arrayModel count];
//    NSLog(@"%lu",(unsigned long)[self.arrayModel count]);
    return [self.arrayModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"方案%ld",(long)indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.nameArray[indexPath.row]];
    
    return cell;
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
