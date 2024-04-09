//
//  MedicineBoxModel.m
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import "MedicineBoxModel.h"

@implementation MedicineBoxModel

- (void)initModel  {
    self.sets_count = 1 ;
    self.medicine_array = [[NSMutableArray alloc] init] ;
    [self.medicine_array addObject:@(2)] ;
    [self.medicine_array addObject:@(3)] ;
    [self.medicine_array addObject:@(4)] ;
    [self.medicine_array addObject:@(5)] ;
    [self.medicine_array addObject:@(6)] ;
    [self.medicine_array addObject:@(7)] ;
    [self.medicine_array addObject:@(8)] ;
    [self.medicine_array addObject:@(9)] ;
    
    self.medicine_name_array = [[NSMutableArray alloc] init] ;
    [self.medicine_name_array addObject:@"急救药品"] ;
    [self.medicine_name_array addObject:@"儿童用药"] ;
    [self.medicine_name_array addObject:@"感冒药"] ;
    [self.medicine_name_array addObject:@"处方药"] ;
    [self.medicine_name_array addObject:@"非处方药"] ;
    [self.medicine_name_array addObject:@"口服药"] ;
    [self.medicine_name_array addObject:@"日常药品"] ;
    [self.medicine_name_array addObject:@"日常药品"] ;
    [self.medicine_name_array addObject:@"日常药品"] ;
}

@end
