//
//  PageTwoModel.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/20.
//

#import "PageTwoModel.h"

@implementation PageTwoModel
- (NSMutableArray *)setEmoArray {
    self.emoArray = [[NSMutableArray alloc] init];
    self.emoArray = [NSMutableArray arrayWithObjects:@"悲伤", @"生气", @"平静", nil];
    return _emoArray;
}
- (NSMutableArray *)setEmoPngArray {
    self.emoPngArray = [[NSMutableArray alloc] init];
    self.emoPngArray = [NSMutableArray arrayWithObjects:@"beishang.png", @"shengqi.png", @"pingjing.png", nil];
    return _emoPngArray;
}
- (NSMutableArray *)setBigTimeArray {
    self.bigTimeArray = [[NSMutableArray alloc] init];
    self.bigTimeArray = [NSMutableArray arrayWithObjects:@"2024.3.20", @"2024.3.13", @"2024.3.10", nil];
    return _bigTimeArray;
}- (NSMutableArray *)setSmallTimeArray {
    self.smallTimeArray = [[NSMutableArray alloc] init];
    self.smallTimeArray = [NSMutableArray arrayWithObjects:@"9:25", @"10:18", @"03:43", nil];
    return _smallTimeArray;
}
- (NSString *)getCurrentDateWithCustomFormat {
    // 获取当前日期
    NSDate *currentDate = [NSDate date];
    // 创建日期格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置自定义日期格式
    [formatter setDateFormat:@"yyyy.M.d"];
    // 将日期转换为字符串
    NSString *formattedDateString = [formatter stringFromDate:currentDate];
    return formattedDateString;
}
- (NSString *)getCurrentTimeWithCustomFormat {
    // 获取当前时间
    NSDate *currentTime = [NSDate date];
    // 创建时间格式化器
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    [timeFormatter setDateFormat:@"MM-dd HH:mm"];
    // 将时间转换成字符串
    NSString *timeString = [timeFormatter stringFromDate:currentTime];
    return timeString;
}

#pragma mark newEmoCard
- (NSMutableArray *)setEmojyNameArray {
    self.emojyNameArray = [[NSMutableArray alloc] init];
    self.emojyNameArray = [NSMutableArray arrayWithObjects:@"一般", @"还行", @"不爽", nil];
    return _emojyNameArray;
}

//    _moodImages = @[@"kuangxi.png", @"haixing.png", @"yiban.png", @"bushuang.png", @"chaolan.png"];
- (NSMutableArray *)setEmojyImageArray {
    self.emojyImageArray = [[NSMutableArray alloc] init];
    self.emojyImageArray = [NSMutableArray arrayWithObjects:@"yiban.png", @"haixing.png", @"bushuang.png", nil];
    return _emojyImageArray;
}

- (NSMutableArray *)setSelectedButtonsNamesArray {
    self.selectedButtonsNamesArray = [[NSMutableArray alloc] init];
    NSMutableArray *first = @[@"玩游戏"];
    NSMutableArray *second = @[@"电影"];
    NSMutableArray *third = @[@"阅读"];
    self.selectedButtonsNamesArray = [NSMutableArray arrayWithObjects:first, second, third, nil];
    return _selectedButtonsNamesArray;
}

- (NSMutableArray *)setSelectedButtonsImagesArray {
    self.selectedButtonsImagesArray = [[NSMutableArray alloc] init];
    NSMutableArray *first = @[@"youxi2.png"];
    NSMutableArray *second = @[@"dianying2.png"];
    NSMutableArray *third = @[@"yuedu2.png"];
    self.selectedButtonsImagesArray = [NSMutableArray arrayWithObjects:first, second, third, nil];
    return _selectedButtonsImagesArray;
}

- (NSMutableArray *)setEmoTextArray {
    self.EmoTextArray = [[NSMutableArray alloc] init];
    self.EmoTextArray = [NSMutableArray arrayWithObjects:@"今天心情一般", @"今天心情还行", @"今天心情不爽", nil];
    return _EmoTextArray;
}

- (NSMutableArray *)setMoodTimeArray {
    self.moodTimeArray = [[NSMutableArray alloc] init];
    self.moodTimeArray = [NSMutableArray arrayWithObjects:@"03-20 13:46", @"03-21 15:32", @"03-25 16:15", nil];
    return _moodTimeArray;
}



@end
