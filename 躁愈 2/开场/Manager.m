//
//  Manager.m
//  EmotionalAnalysis
//
//  Created by 夏楠 on 2024/1/27.
//

#import "Manager.h"

static Manager *managerSington = nil;

NSString *accessToken = @"24.031c5acfc683795180294d48c8736eef.2592000.1713540070.282335-48161704";

@implementation Manager

+ (instancetype)shareManager {
    if (!managerSington) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerSington = [[Manager alloc] init];
        });
    }
    return managerSington;
}

- (void)NetWorkGetWithData:(EmotionModelBlock)mainModelBolck andError:(ErrorBlock)errorBlock andImage:(UIImage *)image {
    
//    NSString *base64ImageString = [self convertImageToPostableFormat:image preferredFormat:@"png" quality:0.9];
    NSString *base64ImageString = [self convertImageToPostableFormat2:image];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *urlString = [NSString stringWithFormat:@"https://aip.baidubce.com/rest/2.0/face/v3/detect?access_token=%@", accessToken];
    NSURL *url = [NSURL URLWithString:urlString];

    NSDictionary *parameters = @{
        @"image": base64ImageString,
        @"image_type": @"BASE64",
        @"face_field": @"face_type,emotion"
    };
    
    
    [manager POST:url.absoluteString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ResponseModel *t = [[ResponseModel alloc] initWithDictionary:responseObject error:nil];
        FaceModel *tt = t.result.face_list[0];
        EmotionModel *ttt = tt.emotion;

        mainModelBolck(ttt);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];
    
}

#pragma mark 获取验证码
- (void)NetWorkGetVerifyWithData:(VerifyBlock)mainModelBolck andError:(ErrorBlock)errorBlock andPhoneNumber:(NSString *)phoneNumber {
    NSError *error;
    NSString *t = phoneNumber;
    NSString *post = [NSString stringWithFormat:@"http://192.168.0.195:8080/auth/code/send/%@", t];
    if (error) {
        NSLog(@"Failed to serialize dictionary to JSON: %@", error);
    } else {

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];

        // 设置请求头，这里Content-Type自动设置为application/json
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        // 发起POST请求
        [manager POST:post parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            mainModelBolck(responseObject);
            // 请求成功，更新UI
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%@", responseObject);
//            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败，处理错误
            NSLog(@"Error: %@", error);
        }];
    }
}

#pragma mark 登录验证
- (void)NetWorkGetLoginWithData:(LoginBlock)mainModelBolck andError:(ErrorBlock)errorBlock andPhoneNumber:(NSString *)phoneNumber andVerifyNumber:(NSString *)verifyNumber {
    NSError *error;
    NSString *t1 = phoneNumber;
    NSString *t2 = verifyNumber;
    NSDictionary *parameters = @{@"id": t1, @"code": t2};

    if (error) {
        NSLog(@"Failed to serialize dictionary to JSON: %@", error);
    } else {

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];

        // 设置请求头，这里Content-Type自动设置为application/json
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        // 发起POST请求
        [manager POST:@"http://192.168.0.195:8080/auth/code/verify" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject[@"msg"]);
            mainModelBolck(responseObject[@"msg"]);
            // 请求成功，更新UI
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%@", responseObject);
//                if ([responseObject isEqual: @"ok"]) {
//                    NSLog(@"1");
//                } else {
//                    NSLog(@"2");
//                }
//            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败，处理错误
            NSLog(@"Error: %@", error);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"failToLog" object:nil];
        }];
    }
}

//图片转换格式方法

- (NSString *)convertImageToPostableFormat2:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

@end
