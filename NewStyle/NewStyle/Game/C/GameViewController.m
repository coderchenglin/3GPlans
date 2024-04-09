//
//  GameViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "GameViewController.h"
#import "GameView.h"
#import "PhotoBrowseViewController.h"

@interface GameViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) GameView *gameView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;//从相册调图片

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //底部工具栏
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.title = @"照片墙";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//?
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];//?
    
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 10)];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];
    tabBarItem.image = [[UIImage imageNamed:@"tupian666.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"tupian6662.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = tabBarItem;
    
    self.gameView = [[GameView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.gameView];
    [self.gameView viewInit];
    
    self.navigationItem.titleView = self.gameView.titleLabel;
    [self imagePickerInit]; //调相册初始化
//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressPicker) name:@"presentPicker" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressPhotoBig:) name:@"photoBig" object:nil];

    //右上角的删除图标 垃圾桶标识
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(pressDelete)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
}

- (void)pressDelete {
    if (self.gameView.flagOfPhoto == 1) {
        if (self.gameView.flagOfDelete == 0) {
            self.gameView.flagOfDelete = 1;
        } else {
            self.gameView.flagOfDelete = 0;
        }
        [self.gameView.collectionView reloadData];
    }
}

- (void)pressPicker {
    //选择相册时，设置UIImagePickerController对象相关属性
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //跳转到UIImagePickerController控制器弹出相册
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

//调相册初始化
- (void)imagePickerInit {
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    self.imagePicker.delegate = self;
    
    self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
}

//图片放大
- (void)pressPhotoBig:(NSNotification *)sender {
    int numberOfArray = [sender.userInfo[@"item"] intValue];
    PhotoBrowseViewController *photoBrowseViewController = [[PhotoBrowseViewController alloc] init];//创建图片浏览视图控制器
    photoBrowseViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//这是一种视图控制器切换时的过渡效果，具体效果是渐变消失和渐变出现
    photoBrowseViewController.shareImage = self.gameView.photoArray[numberOfArray - 1];
    [self presentViewController:photoBrowseViewController animated:YES completion:nil];
}


// !! 获取相册得到的图片
// 不仅加入photoArray，还要加入DataBase
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage *newImage = [[UIImage alloc] init];
    newImage = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!newImage) {
        newImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    [self.gameView.photoArray addObject:newImage];
    [self.gameView insertPhotoDataBase:newImage];  //这里涉及到持久化技术了
    [self.gameView.collectionView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"presentPicker" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"photoBig" object:nil];
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
