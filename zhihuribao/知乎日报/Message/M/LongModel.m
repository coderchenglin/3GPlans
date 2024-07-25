//
//  LongModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import "LongModel.h"

static LongModel *longData = nil;

@implementation LongModel

+ (instancetype)shareLongModel {
    if (!longData) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            longData = [[LongModel alloc] init];
        });
    }
    return longData;
}

- (void)NetworkGetLongData:(GetLongModelBlock)longModelBlock andError:(ErrorBlock)errorBlock {
    NSString *json = [[NSString alloc] initWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", self.LongID];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *netWorkDataURL = [NSURL URLWithString:json];
    NSURLRequest *netWorkDataRequest = [NSURLRequest requestWithURL:netWorkDataURL];
    NSURLSession *netWorkDataSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *netWorkDataTask = [netWorkDataSession dataTaskWithRequest:netWorkDataRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            LongJSONModel *allLongData = [[LongJSONModel alloc]initWithData:data error:nil];
            longModelBlock(allLongData);
        } else {
            errorBlock(error);
        }
    }];
    [netWorkDataTask resume];
}

@end
