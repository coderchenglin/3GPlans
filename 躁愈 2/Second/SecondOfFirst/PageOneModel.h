//
//  PageOneModel.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageOneModel : NSObject
- (NSMutableArray *)setSecondOfFirstTableViewCellArray;
@property (nonatomic, strong) NSMutableArray *secondOfFirstTableViewCellArray;

- (NSMutableArray *)setSecondOfFirstTableViewCellUrlArray;
@property (nonatomic, strong) NSMutableArray *secondOfFirstTableViewCellUrlArray;

- (NSMutableArray *)setSecondOfSecondTableViewCellArray;
@property (nonatomic, strong) NSMutableArray *secondOfSecondTableViewCellArray;

- (NSMutableArray *)setSecondOfSecondTableViewCellPicArray;
@property (nonatomic, strong) NSMutableArray *secondOfSecondTableViewCellPicArray;

- (NSMutableArray *)setSecondOfThirdTableViewCellArray;
@property (nonatomic, strong) NSMutableArray *secondOfThirdTableViewCellArray;

- (NSMutableArray *)setSecondOfThirdTableViewCellPicArray;
@property (nonatomic, strong) NSMutableArray *secondOfThirdTableViewCellPicArray;
@end

NS_ASSUME_NONNULL_END
