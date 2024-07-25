//
//  ShortModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import "ShortModel.h"

static ShortModel *shortData = nil;

@implementation ShortModel

+ (instancetype)shareShortModel {
    if (!shortData) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shortData = [[ShortModel alloc] init];
        });
    }
    return shortData;
}

- (void)NetworkGetShortData:(GetShortModelBlock)shortModelBlock andError:(ErrorBlock)errorBlock {
    NSString *json = [[NSString alloc] initWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", self.shortID];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *netWorkDataURL = [NSURL URLWithString:json];
    NSURLRequest *netWorkDataRequest = [NSURLRequest requestWithURL:netWorkDataURL];
    NSURLSession *netWorkDataSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *netWorkDataTask = [netWorkDataSession dataTaskWithRequest:netWorkDataRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            ShortJSONModel *allShortData = [[ShortJSONModel alloc]initWithData:data error:nil];
            shortModelBlock(allShortData);
        } else {
            errorBlock(error);
        }
    }];
    [netWorkDataTask resume];
}

@end
