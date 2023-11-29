//
//  NetworkModel.m
//  知乎日报
//
//  Created by chenglin on 2023/11/25.
//

#import "NetworkModel.h"

static NetworkModel *network = nil;

@implementation NetworkModel

+ (instancetype)shareNetworkModel {
    
    if (!network) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            network = [[NetworkModel alloc] init];
        });
    }
    return network;
}

- (void)NetworkModelData:(NetworkBlock)networkDataBlock andError:(ErrorBlock)errorBlock {
    
    NSString *networkJson = @"https://news-at.zhihu.com/api/4/news/latest";
    
    networkJson = [networkJson stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *networkURL = [NSURL URLWithString:networkJson];
    NSURLRequest *networkRequest = [NSURLRequest requestWithURL:networkURL];
    NSURLSession *networkSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *networkDataTask = [networkSession dataTaskWithRequest:networkRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NetworkJSONModel *allData = [[NetworkJSONModel alloc] initWithData:data error:nil];
            networkDataBlock(allData); //这个allData就是传给这个块作为参数，block传值也就是将这个allData传给他的调用者
        } else {
            errorBlock(error);
        }
    }];
    
    [networkDataTask resume];
}





@end
