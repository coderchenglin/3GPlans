//
//  GameViewController.m
//  NewStyle
//
//  Created by chenglin on 2024/1/22.
//

#import "GameViewController.h"
#import "GameView.h"


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
    
//    self.navigationItem.titleView = self.gameView.titleLabel;
//    [self imagePickerInit]; //调相册初始化
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressPicker) name:@"presentPicker" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressPhotoBig:) name:@"photoBig" object:nil];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(pressDelete)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
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
