//
//  Manager.m
//  ColorBlindTest
//
//  Created by chenglin on 2024/3/25.
//

#import "Manager.h"
#import "ColorTestModel.h"

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


- (void)requestColorBlindTest: (NSString *)token success:(TestModelBlock)success failure:(ErrorBlock)failure {
    
    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/test/method1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            NSLog(@"data: %@", data);
            ColorTestModel *colorTestModel = [[ColorTestModel alloc] initWithData:data error:nil];
//            NSLog(@"colorModel: %@", colorModel);
            success(colorTestModel);
//            NSLog(@"%@,%d",data,__LINE__);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)postColorBlindOptionArray: (NSString *)token success:(OptionModelBlock)success failure:(ErrorBlock)failure didSelectOption:(NSArray *)optionArray {
    
    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/test/JudgeMethod1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
//    request.HTTPBody = [[NSString stringWithFormat:@"options=%@", optionArray] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *optionString = [optionArray componentsJoinedByString:@""];
    NSString *temString = [NSString stringWithFormat:@"options=%@", optionString];
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[temString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    NSLog(@"optionString = %@", optionString);
    NSLog(@"temString = %@", temString);
    NSLog(@"postData = %@", postData);
    
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    
    
//    NSDictionary *params = @{@"option": option};
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Request successful");
            OptionModel *optionModel = [[OptionModel alloc] initWithData:data error:nil];
            NSLog(@"optionModel: %@", optionModel);
            success(optionModel);
        }
    }];

    
    [task resume];
}




@end
