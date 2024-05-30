//
//  ViewController.m
//  wjc
//
//  Created by chenglin on 2024/5/29.
//

//#import "ViewController.h"
//
//@interface ViewController ()
//
//@property (nonatomic,strong) UIToolbar *toolbar;
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
//
//
//    // 设置导航栏风格颜色
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    // 设置导航栏为不透明
//    self.navigationController.navigationBar.translucent = NO;
//    // 设置导航栏的背景颜色
//    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
//    appearance.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
//    // 设置导航栏的标题颜色
//    self.title = @"导航栏";
//
//    //工具栏按钮创建
//    self.navigationController.toolbarHidden = NO;
//    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleDone target:nil action:nil];
//
//    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
//
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *image = [UIImage imageNamed:@"1.jpg"];
//    [btn setImage:image forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, 30, 30); // 调整按钮的frame大小以适应图片
//    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithCustomView:btn];
//
//
////    UIBarButtonItem *btn4 = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
//    NSArray *arr = @[btn1, btn2, btn3];
//
//    self.toolbarItems = arr;
//}
//
//@end
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.translucent = NO;
    
    //创建三个工具栏按钮
    UIBarButtonItem* btn01 = [[UIBarButtonItem alloc] initWithTitle:@"按钮" style:UIBarButtonItemStyleDone target:nil action:nil];
    UIBarButtonItem* btn02 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    UIButton* btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnImage setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
//    btnImage.frame = CGRectMake(0, 0, 60, 60);
    UIBarButtonItem* btn03 = [[UIBarButtonItem alloc] initWithCustomView:btnImage];
    //如果想改变按钮之间的距离可以使用如下两个按钮
    //固定宽度占位按钮
    UIBarButtonItem* btnF01 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    btnF01.width = 50;
    //自动计算宽度按钮
    UIBarButtonItem* btnF02 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //创建按钮数组
    NSArray* arrayBtn = [NSArray arrayWithObjects:btn01, btnF01, btn02, btnF02, btn03, nil];
    self.toolbarItems = arrayBtn;
    


}



@end
