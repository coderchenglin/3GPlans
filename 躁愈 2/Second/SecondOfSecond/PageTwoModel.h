//
//  PageTwoModel.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageTwoModel : NSObject
- (NSMutableArray *)setEmoArray;
@property (nonatomic, strong) NSMutableArray *emoArray;
- (NSMutableArray *)setBigTimeArray;
@property (nonatomic, strong) NSMutableArray *bigTimeArray;
- (NSMutableArray *)setSmallTimeArray;
@property (nonatomic, strong) NSMutableArray *smallTimeArray;
- (NSMutableArray *)setEmoPngArray;
@property (nonatomic, strong) NSMutableArray *emoPngArray;
- (NSString *)getCurrentDateWithCustomFormat;
- (NSString *)getCurrentTimeWithCustomFormat;

#pragma mark newEmoCard
- (NSMutableArray *)setEmojyNameArray;
@property (nonatomic, strong) NSMutableArray *emojyNameArray;
- (NSMutableArray *)setEmojyImageArray;
@property (nonatomic, strong) NSMutableArray *emojyImageArray;
- (NSMutableArray *)setSelectedButtonsNamesArray;
@property (nonatomic, strong) NSMutableArray *selectedButtonsNamesArray;
- (NSMutableArray *)setSelectedButtonsImagesArray;
@property (nonatomic, strong) NSMutableArray *selectedButtonsImagesArray;
- (NSMutableArray *)setEmoTextArray;
@property (nonatomic, strong) NSMutableArray *EmoTextArray;
- (NSMutableArray *)setMoodTimeArray;
@property (nonatomic, strong) NSMutableArray *moodTimeArray;

@end

NS_ASSUME_NONNULL_END
