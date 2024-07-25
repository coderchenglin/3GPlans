//
//  NetworkModel.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/18.
//

#import "NetworkModel.h"

//先定义一个全局static变量
static NetworkModel *network = nil;

@implementation NetworkModel
//单例方法 - 创建一个初始化后的网络模型类
+ (instancetype)shareNetworkModel {
    if (!network) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            network = [[NetworkModel alloc] init]; //初始化
        });
    }
    return network;
}

//网络请求方法，参数是两个块
- (void)NetworkModelData:(NetworkBlock)networkDataBlock andError:(ErrorBlock)errorBlock {
    //创建一个URL
    NSString *networkJson = @"https://news-at.zhihu.com/api/4/news/latest";
    networkJson = [networkJson stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *networkURL = [NSURL URLWithString:networkJson];
    //创建一个网络请求， 此方法通过传入一个 NSURL 对象创建一个简单的GET请求。
    NSURLRequest *networkRequest = [NSURLRequest requestWithURL:networkURL];
    //创建网络管理
    NSURLSession *networkSession = [NSURLSession sharedSession];
    //创建网络任务
    NSURLSessionDataTask *networkDataTask = [networkSession dataTaskWithRequest:networkRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //这是一个网络请求成功后回调的闭包
        

        if (error == nil) {
            NetworkJSONModel *allData = [[NetworkJSONModel alloc] initWithData:data error:nil]; //JSONModel的使用
            networkDataBlock(allData); //用传进来的块，处理这个数据。就是调用放决定如何处理，相当于这里把请求下来的数据allDate传递给调用方来
        } else {
            errorBlock(error);
        }
    }];
    //开启任务
    [networkDataTask resume];
}

@end
