//
//  NetworkJSONModel.h
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/18.
//

//嵌套Model必须实现像这样的协议
@protocol StoriesModel
@end

@protocol Top_StoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
//Model属性名和服务器返回数据字段一致
//嵌套使用必须一层层来
//这是里层
@interface StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *id;
@end
//里层
@interface Top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@end
//外层
@interface NetworkJSONModel : JSONModel
//我们主要也就是使用这个单例类对象，这个对象有3个属性，
//1.日期
//2.存放所有下面内容的二维数组 - 一维数组是存放单个新闻里的title，rul等内容
//3.存放顶部滚动视图内容的二维数组

@property (nonatomic, copy) NSString *date; //日期
@property (nonatomic, copy) NSArray<StoriesModel> *stories;
@property (nonatomic, copy) NSArray<Top_StoriesModel> *top_stories;

@end

NS_ASSUME_NONNULL_END


//{"date":"20231211",
//    "stories":[{"image_hue":"0x2f7489",
//        "title":"飞鱼为什么要飞出海面？",
//        "url":"https:\/\/daily.zhihu.com\/story\/9768036",
//        "hint":"苏澄宇 · 1 分钟阅读",
//        "ga_prefix":"121107",
//        "images":["https:\/\/pic1.zhimg.com\/v2-d93ccb3328990722d43c893deedb1aae.jpg?source=8673f162"],
//        "type":0,
//        "id":9768036},。。]，
//"top_stories":[{"image_hue":"0x2f7489",
//    "hint":"作者 \/ 苏澄宇",
//    "url":"https:\/\/daily.zhihu.com\/story\/9768036",
//    "image":"https:\/\/picx.zhimg.com\/v2-736a64b2e7fce16388f4028436ecd25a.jpg?source=8673f162",
//    "title":"飞鱼为什么要飞出海面？",
//    "ga_prefix":"121107",
//    "type":0,
//    "id":9768036},
//}


////时间戳转NSDate
//(NSDate)NSDateFromNSString:(NSString)string {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:APIDateFormat];
//    return [formatter dateFromString:string];
//}
////NSDate转时间戳-
//(NSString *)JSONObjectFromNSDate:(NSDate *)date {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:APIDateFormat];
//    return [formatter stringFromDate:date];
//}


