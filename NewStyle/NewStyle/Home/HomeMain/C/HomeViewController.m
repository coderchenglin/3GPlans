//
//  HomeViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "HomeViewController.h"

#import "HomeView.h"

@interface HomeViewController () <ImagePickerDelegate, PhotoFixDelegate>
@property (nonatomic, strong) HomeView *homeView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.homeView = [[HomeView alloc] initWithFrame:self.view.frame];
    self.navigationController.navigationBar.hidden = YES;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.title = @"主页";
    //没有被选中
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    //被选中
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 10)];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];//用于调整图标的插图，上左下右的偏移量
    tabBarItem.image = [[UIImage imageNamed:@"zhuye.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = tabBarItem;
    [self.view addSubview:self.homeView];
    [self.homeView viewInit];
    self.homeView.imageDelegate = self;
    self.homeView.photoFixDelegate = self;
    
}

- (void)presentAlert {
    //创建sheet提示框，提示选择相机还是相册
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择相机时，设置UIImagePickerController对象相关属性
        self.homeView.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.homeView.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        self.homeView.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:self.homeView.imagePicker animated:YES completion:nil];
    }];
    
    //相册选项
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择相册时，设置UIImagePickerController对象相关属性
        self.homeView.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:self.homeView.imagePicker animated:YES completion:nil];
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






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
