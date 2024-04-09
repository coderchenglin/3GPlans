//
//  MedicineBoxModel.h
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MedicineBoxModel : NSObject
@property (nonatomic, assign) NSInteger sets_count ;//药箱数量
@property (nonatomic, strong) NSMutableArray<NSNumber*> * medicine_array ;//各个药箱中的药品数
@property (nonatomic, strong) NSMutableArray<NSString*> * medicine_name_array ;//药箱名称

- (void)initModel ;
@end

NS_ASSUME_NONNULL_END
