//
//  FirstModel.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/3.
//

#import "FirstModel.h"

@implementation FirstModel
- (NSString *)getMonth {
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];

    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    // 设置日期的格式
    [self.dateFormatter setDateFormat:@"MM"]; // 获取月份
    // 创建一个字典来映射数字月份到中文月份名称
    self.monthMap = @{
        @"01": @"一月",
        @"02": @"二月",
        @"03": @"三月",
        @"04": @"四月",
        @"05": @"五月",
        @"06": @"六月",
        @"07": @"七月",
        @"08": @"八月",
        @"09": @"九月",
        @"10": @"十月",
        @"11": @"十一月",
        @"12": @"十二月"
    };

    // 获取当前的月份
    self.currentMonth = [self.dateFormatter stringFromDate:self.currentDate];

    // 使用字典映射获取中文月份名称
    self.month = self.monthMap[self.currentMonth];
    
    
    return self.month;
}

- (NSString *)getClockTip {
    
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH"]; // 获取日期
    self.hourMap = @{
        @"01": @"早点休息",
        @"02": @"早点休息",
        @"03": @"早点休息",
        @"04": @"早点休息",
        @"05": @"早上好",
        @"06": @"早上好",
        @"07": @"早上好",
        @"08": @"早上好",
        @"09": @"早上好",
        @"10": @"早上好",
        @"11": @"早上好",
        @"12": @"中午好",
        @"13": @"中午好",
        @"14": @"下午好",
        @"15": @"下午好",
        @"16": @"下午好",
        @"17": @"下午好",
        @"18": @"下午好",
        @"19": @"晚上好",
        @"20": @"晚上好",
        @"21": @"晚上好",
        @"22": @"晚上好",
        @"23": @"早点休息",
        @"00": @"早点休息"
    };
    self.hour = [self.dateFormatter stringFromDate:self.currentDate];
    self.tip = self.hourMap[self.hour];

    return self.tip;
}

- (NSString *)getDate {
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];
    
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    [self.dateFormatter setDateFormat:@"dd"];
    self.date = [self.dateFormatter stringFromDate:self.currentDate];
    return self.date;
}

- (NSString *)getYearMonthDate {
    self.currentDate = [NSDate date];
    
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    [self.dateFormatter setDateFormat:@"YYYYMMdd"];
    self.YearMonthDate = [self.dateFormatter stringFromDate:self.currentDate];
    return self.YearMonthDate;
}

- (NSString *)pastDate:(int)numbersOfLoad {
    // 获取当前日期
    NSDate *currentDate = [NSDate date];

    // 创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];

    // 创建一个NSDateComponents对象并设置days属性为负数
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -numbersOfLoad; // 使用传入的numbersOfLoad来计算前N天的日期

    // 使用calendar对象来计算前N天的日期
    NSDate *previousDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];

    // 创建一个日期格式化器以便格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月dd日"; // 日期格式可以根据你的需求进行调整

    // 格式化前N天的日期
    NSString *formattedDate = [dateFormatter stringFromDate:previousDate];

    return formattedDate;
}

- (NSString *)pastDateForJson:(int)numbersOfLoad {
    NSDate *today = [NSDate date]; // 获取今天的日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];

    // 计算前一天的日期
    dateComponents.day = -numbersOfLoad + 1; // 加 1，因为 loadNumber 从 1 开始
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];

    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd"; // 日期格式

    // 格式化日期为字符串
    NSString *formattedDate = [dateFormatter stringFromDate:targetDate];

    return formattedDate;
}

- (NSMutableArray *)setFirstTableViewCellArray {
    self.firstTableViewCellArray = [[NSMutableArray alloc] init];
    self.firstTableViewCellArray = [NSMutableArray arrayWithObjects:@"10min吸引法则冥想meditation🧘‍♀️放下焦虑迷茫，遇见未来的自己", @"【K.Saluna】【疗愈冥想】跟父母和解，接纳自己，提升价值感，链接祖先能", @"【初めての瞑想】寝たままの５分間で心も体もスッキリ!!自己肯定感を高める習慣", @"宅在家冥想好處多！每天1小時持續一週 他身體出現驚人變化－民視新聞", @"快速10 分鐘冥想 光的療癒 冥想引導 照亮你的心靈 與光一起冥想", nil];
    return  _firstTableViewCellArray;
}

- (NSMutableArray *)setFirstTableViewCellJpgArray {
    self.firstTableViewCellJpgArray = [[NSMutableArray alloc] init];
    self.firstTableViewCellJpgArray = [NSMutableArray arrayWithObjects:@"10min吸引法则冥想meditation🧘‍♀️放下焦虑迷茫，遇见未来的自己.jpg", @"【K.Saluna】【疗愈冥想】跟父母和解，接纳自己，提升价值感，链接祖先能.jpg", @"【初めての瞑想】寝たままの５分間で心も体もスッキリ!!自己肯定感を高める習慣.jpg", @"宅在家冥想好處多！每天1小時持續一週 他身體出現驚人變化－民視新聞.jpg", @"快速10 分鐘冥想 光的療癒 冥想引導 照亮你的心靈 與光一起冥想.jpg", nil];
    return _firstTableViewCellJpgArray;
}

- (NSMutableArray *)setFirstTableViewCellVideoArray {
    self.firstTableViewCellVideoArray = [[NSMutableArray alloc] init];
    self.firstTableViewCellVideoArray = [NSMutableArray arrayWithObjects:@"https://rxsss.oss-cn-beijing.aliyuncs.com/video/collection1.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/collection2.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/collection3.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/collection4.mp4", @"https://rxsss.oss-cn-beijing.aliyuncs.com/video/collection5.mp4", nil];
    return _firstTableViewCellVideoArray;
}

- (NSMutableArray *)setFirstTableViewCellSubTitleArray {
    self.firstTableViewCellSubTitleArray = [[NSMutableArray alloc] init];
    self.firstTableViewCellSubTitleArray = [NSMutableArray arrayWithObjects:@"Namaste, I'm your April.", @"K.Saluna，疗愈师、灵媒", @"“もっと自分を好きになる！“をモットーに自宅で楽しくできるフィットネスや", @"民視新聞網", @"Medit Time", nil];
    return _firstTableViewCellSubTitleArray;
}

- (NSMutableArray *)setFirstTableViewCellSmallPicArray {
    self.firstTableViewCellSmallPicArray = [[NSMutableArray alloc] init];
    self.firstTableViewCellSmallPicArray = [NSMutableArray arrayWithObjects:@"Namaste, I'm your April.png", @"K.Saluna，疗愈师、灵媒.png", @"“もっと自分を好きになる！“をモットーに自宅で楽しくできるフィットネスや.png", @"民視新聞網.png", @"Medit Time.png", nil];
    return _firstTableViewCellSmallPicArray;
}

- (NSMutableArray *)setSecondTableViewCellArray {
    self.secondTableViewCellArray = [[NSMutableArray alloc] init];
    self.secondTableViewCellArray = [NSMutableArray arrayWithObjects:@"亚洲冥想", @"冥想音乐收藏", @"音景: 环境声音放松音乐", @"镇静呼吸", @"冥想入門音樂 - 最佳的冥想和瑜伽音樂", nil];
    return _secondTableViewCellArray;
}

- (NSMutableArray *)setSecondTableViewCellJpgArray {
    self.secondTableViewCellJpgArray = [[NSMutableArray alloc] init];
    self.secondTableViewCellJpgArray = [NSMutableArray arrayWithObjects:@"亚洲冥想.png", @"冥想音乐收藏.png", @"音景环境声音放松音乐.png", @"镇静呼吸.png", @"冥想入門音樂 - 最佳的冥想和瑜伽音樂.png", nil];
    return _secondTableViewCellJpgArray;
}

@end
