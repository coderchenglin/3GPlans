//
//  Manager.m
//  ColoringScheme
//
//  Created by chenglin on 2024/3/23.
//

#import "Manager.h"

@implementation Manager

static id manager = nil;

+ (instancetype)sharedManager {
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[Manager alloc] init];
        });
    }
    return manager;
}

- (void)requestColoringScheme:(NSString *)token success:(ColorModelBlock)success failure:(ErrorBlock)failure {
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.135:8081/attach/Favorite"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"192.168.0.135:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            NSLog(@"data: %@", data);
            ColorModel *colorModel = [[ColorModel alloc] initWithData:data error:nil];
//            NSLog(@"colorModel: %@", colorModel);
            success(colorModel);
//            NSLog(@"%@,%d",data,__LINE__);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

@end
