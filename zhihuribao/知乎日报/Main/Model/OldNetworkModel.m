//
//  OldNetworkModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/23.
//

#import "OldNetworkModel.h"

static OldNetworkModel *oldNetwork = nil;

@implementation OldNetworkModel

+ (instancetype)shareOldNetworkModel {
    if (!oldNetwork) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            oldNetwork = [[OldNetworkModel alloc] init];
        });
    }
    
    return oldNetwork;
}


- (void)OldNetworkModelData:(OldNetworkBlock)oldNetworkDataBlock andError:(ErrorOldBlock)errorOldBlock {
    
    NSString *oldNetworkJson = [[NSString alloc] initWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", self.nowDate];
    oldNetworkJson = [oldNetworkJson stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *oldNetworkURL = [NSURL URLWithString:oldNetworkJson];
    NSURLRequest *oldNetworkRequest = [NSURLRequest requestWithURL:oldNetworkURL];
    NSURLSession *oldNetworkSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *oldNetworkDataTask = [oldNetworkSession dataTaskWithRequest:oldNetworkRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            OldNetworkJSONModel *allData = [[OldNetworkJSONModel alloc] initWithData:data error:nil];
            oldNetworkDataBlock(allData);
        } else {
            errorOldBlock(error);
        }
    }];
    [oldNetworkDataTask resume];
}

@end
