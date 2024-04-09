//
//  Manager.m
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import "Manager.h"
#import "AFNetworking.h" //主要用于网络请求方法
#import "UIKit+AFNetworking.h" //里面有移步加载图片的方法

@interface Manager ()

@end
static Manager *manager = nil;
@implementation Manager

+ (instancetype)sharedManage {
    if (manager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[Manager alloc] init];
        });
    }
    return manager;
}

//图片修复
- (void)firstNetWorkWithImage:(PhotoFixBlock)dataBlock error:(ErrorBlock)errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/colourize?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    
    
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/colourize?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];//先将图片压缩为JPEG，再将JPEG二进制编码转换为base64字符组成的字符串
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model); //调用Controller传进来的块
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error); //调用Controller传进来的块
    }];
}

//人像动漫化
- (void)secondNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/selfie_anime?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/selfie_anime?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//图片去雾
- (void)thirdNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/dehaze?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/dehaze?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//增强对比度
- (void)fourNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/contrast_enhance?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/contrast_enhance?access_token=    24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";

    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//图像清晰化
- (void)fiveNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/image_definition_enhance?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/image_definition_enhance?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//黑白图片上色
- (void)sixNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/colourize?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/colourize?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//图片色彩增强
- (void)sevenNetWorkWithImage:(PhotoFixBlock) dataBlock error:(ErrorBlock) errorBlock image:(UIImage *)image {
//    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/color_enhance?access_token=24.6198013a9734d1991ef0d04b93cb66da.2592000.1673878002.282335-28825566";
    NSString *URL = @"https://aip.baidubce.com/rest/2.0/image-process/v1/color_enhance?access_token=24.eba52cf6228b3470a7d49cab05b80787.2592000.1709886514.282335-50071545";
    NSString *base64Str = [UIImageJPEGRepresentation(image, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *header = @{@"Accept":@"application/json", @"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *Body = @{@"image":base64Str, @"option":@"cartoon"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:Body headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PhotoFixModel *model = [[PhotoFixModel alloc] initWithDictionary:responseObject error:nil];
        dataBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}
@end
