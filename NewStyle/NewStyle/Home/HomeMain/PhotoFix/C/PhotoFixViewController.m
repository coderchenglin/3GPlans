//
//  PhotoFixViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/2/7.
//

#import "PhotoFixViewController.h"
#import "PhotoFixView.h"
#import "Manager.h"
#import "PublishViewController.h"

@interface PhotoFixViewController () <ButtonDelegate>
@property (nonatomic, strong) PhotoFixView *photoFixView;
@property (nonatomic, strong) UIAlertController *saveAlertController;
@end

@implementation PhotoFixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.photoFixView = [[PhotoFixView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.photoFixView];
    self.navigationController.navigationBar.hidden = YES;
    self.photoFixView.numberOfFix = self.numberOfFix;
    self.photoFixView.oldImage = self.oldImage;
    [self.photoFixView viewInit];
    self.photoFixView.buttondelegate = self;
    if (self.numberOfFix == 0) {
        [self firstNetworkRequest];
    } else if (self.numberOfFix == 1) {
        [self secondNetworkRequest];
    } else if (self.numberOfFix == 2) {
        [self thirdNetworkRequest];
    } else if (self.numberOfFix == 3) {
        [self fourNetworkRequest];
    } else if (self.numberOfFix == 4) {
        [self fiveNetworkRequest];
    } else if (self.numberOfFix == 5) {
        [self sixNetworkRequest];
    } else if (self.numberOfFix == 6) {
        [self sevenNetworkRequest];
    }
}

- (void)getButton:(UIButton *)button {
    if (button.tag == 666) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (button.tag == 0) {
        UIImageWriteToSavedPhotosAlbum(self.photoFixView.mainImageView.image, nil, nil, nil);
        self.saveAlertController = [UIAlertController alertControllerWithTitle:nil message:@"已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.saveAlertController animated:YES completion:nil];
        NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:myTimer forMode:NSRunLoopCommonModes];
    } else if (button.tag == 1) {
        PublishViewController *publishViewController = [[PublishViewController alloc] init];
        publishViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        publishViewController.image = self.photoFixView.mainImageView.image;
        publishViewController.flag = 2;
        [self presentViewController:publishViewController animated:YES completion:nil];
    }
}

//保存图片弹窗消失
- (void)timeOut {
    [self.saveAlertController dismissViewControllerAnimated:YES completion:nil];
}

//网络请求函数
//- (void)firstNetworkRequest {
//    [[Manager sharedManage] firstNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
//        //网络请求成功后执行：
//        [self.photoFixView requestBack];  //按钮显示，小菊花消失
//        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
//    } error:^(NSError * _Nonnull error) {
//        //网路请求失败后执行：
//        [self errorRequest];  //请求失败
//    } image:self.oldImage];
//}


//网络请求函数
- (void)firstNetworkRequest {
    [[Manager sharedManage] firstNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}

- (void)secondNetworkRequest {
    [[Manager sharedManage] secondNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];
        NSData *imageData = [[NSData alloc]initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}

- (void)thirdNetworkRequest {
    [[Manager sharedManage] thirdNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}

- (void)fourNetworkRequest {
    [[Manager sharedManage] fourNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}
- (void)fiveNetworkRequest {
    [[Manager sharedManage] fiveNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}
- (void)sixNetworkRequest {
    [[Manager sharedManage] sixNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}
- (void)sevenNetworkRequest {
    [[Manager sharedManage] sevenNetWorkWithImage:^(PhotoFixModel * _Nonnull mainModel) {
        [self.photoFixView requestBack];   //按钮显示，小菊花消失
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[mainModel toDictionary][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.photoFixView.mainImageView.image = [UIImage imageWithData:imageData];
    } error:^(NSError * _Nonnull error) {
        [self errorRequest];
    } image:self.oldImage];
}


//请求失败
- (void)errorRequest {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"通知" message:@"网络连接失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [errorAlertController addAction:alertAction];
    [self presentViewController:errorAlertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
