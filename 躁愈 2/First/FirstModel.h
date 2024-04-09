//
//  FirstModel.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstModel : NSObject
@property NSDate *currentDate;
@property NSDateFormatter *dateFormatter;

- (NSString *)getMonth;
@property NSDictionary *monthMap;
@property NSString *currentMonth;
@property NSString *month;

- (NSString *)getDate;
@property NSString *date;

- (NSString *)getClockTip;
@property NSDictionary *hourMap;
@property NSString *hour;
@property NSString *tip;

- (NSString *)getYearMonthDate;
@property NSString *YearMonthDate;

- (NSString *)pastDate:(int)numbersOfLoad;
- (NSString *)pastDateForJson:(int)numbersOfLoad;

- (NSMutableArray *)setFirstTableViewCellArray;
@property (nonatomic, strong) NSMutableArray *firstTableViewCellArray;

- (NSMutableArray *)setFirstTableViewCellJpgArray;
@property (nonatomic, strong) NSMutableArray *firstTableViewCellJpgArray;

- (NSMutableArray *)setFirstTableViewCellVideoArray;
@property (nonatomic, strong) NSMutableArray *firstTableViewCellVideoArray;

- (NSMutableArray *)setFirstTableViewCellSubTitleArray;
@property (nonatomic, strong) NSMutableArray *firstTableViewCellSubTitleArray;

- (NSMutableArray *)setFirstTableViewCellSmallPicArray;
@property (nonatomic, strong) NSMutableArray *firstTableViewCellSmallPicArray;

- (NSMutableArray *)setSecondTableViewCellArray;
@property (nonatomic, strong) NSMutableArray *secondTableViewCellArray;

- (NSMutableArray *)setSecondTableViewCellJpgArray;
@property (nonatomic, strong) NSMutableArray *secondTableViewCellJpgArray;

- (NSMutableArray *)setSecondTableViewCellVideoArray;
@property (nonatomic, strong) NSMutableArray *secondTableViewCellVideoArray;

@end

NS_ASSUME_NONNULL_END
