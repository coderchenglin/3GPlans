//
//  PublishViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/2/12.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.publishView = [[PublishView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.publishView];
    [self.publishView viewInit];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressButton:) name:@"publishButton" object:nil];
    self.publishView.image = self.image;
    [self.publishView testPhoto];
    
    // Do any additional setup after loading the view.
}

- (void)pressButton:(NSNotification *)sender {
    UIButton *button = sender.userInfo[@"button"];
    if (button.tag == 0) {
        if (self.flag == 2) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } else if (button.tag == 1) {  //发表
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if (button.tag == 2) {  //添加图片
        //创建sheet提示框，提示选择相机还是相册
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //相机选项
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //选择相机时，设置UIImagePickerController对象相关属性
            self.publishView.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.publishView.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            self.publishView.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            //跳转到UIImagePickerController控制器弹出相机
            [self presentViewController:self.publishView.imagePicker animated:YES completion:nil];
        }];
        //相册选项
        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //选择相册时，设置UIImagePickerController对象相关属性
            self.publishView.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //跳转到UIImagePickerController控制器弹出相册
            [self presentViewController:self.publishView.imagePicker animated:YES completion:nil];
        }];
        
        //取消按钮
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //添加各个按钮事件
        [alert addAction:camera];
        [alert addAction:photo];
        [alert addAction:cancel];
        //弹出sheet提示框
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"publishButton" object:nil];
}

@end

//使用了系统相机和相册的 API，通过 AVFoundation 和 AssetsLibrary 框架实现了图片的选择。
