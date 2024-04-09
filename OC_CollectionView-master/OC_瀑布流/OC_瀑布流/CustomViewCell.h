//
//  CustomViewCell.h
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"
@interface CustomViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel     *moneyL;
@property (strong, nonatomic) UIImageView *imgV;
@property (strong, nonatomic) TestModel   *model;
@end
