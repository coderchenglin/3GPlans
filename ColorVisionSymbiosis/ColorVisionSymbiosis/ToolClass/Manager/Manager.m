//
//  Manager.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "Manager.h"
#import "OverallActivityIndicator.h"

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

//@"phone=18291734442&password=122333Az*" 如何在请求体里面输入&符号，URL编码
- (void)requestLoginInfoWithPhone:(NSString *)phone andPassword:(NSString *)password success:(LoginModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/loginByPassword"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&password=%@", phone, password] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            LoginModel* loginModel = [[LoginModel alloc] initWithData: data error: nil];
            success(loginModel);
//            NSLog(@"%@ %@", dict[@"message"], dict[@"data"][@"phone"]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestRegisterInfoWithPhone:(NSString *)phone Password:(NSString *)password andConfirmPassword:(NSString *)confirmPassword success:(RegisterModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/createUser"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&password=%@&repassword=%@", phone, password, confirmPassword] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            RegisterModel* registerModel = [[RegisterModel alloc] initWithData: data error: nil];
            success(registerModel);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestCodeInfoWithPhone:(NSString *)phone success:(CodeModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/sendCode"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@", phone] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            CodeModel* codeModel = [[CodeModel alloc] initWithData: data error: nil];
            success(codeModel);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestLoginByCodeInfoWithPhone:(NSString *)phone andCode:(NSString *)code success:(LoginByCodeBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/loginByCode"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&code=%@", phone, code] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            LoginByCodeModel* loginByCodeModel = [[LoginByCodeModel alloc] initWithData: data error: nil];
            success(loginByCodeModel);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

@end
