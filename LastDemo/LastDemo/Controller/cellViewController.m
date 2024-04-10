//
//  cellViewController.m
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import "cellViewController.h"
#import "Masonry.h"
//extern UIColor *colorOfBack;
@interface cellViewController ()

@end

@implementation cellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self navigationAdd];
    [self imageviewAdd];
    [self contentAdd];
}


- (void) navigationAdd {
    
    UINavigationBarAppearance* appearance = [UINavigationBarAppearance new];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = [UIColor grayColor];
    appearance.shadowColor = [UIColor clearColor];
    
    self.navigationItem.standardAppearance = appearance;
    self.navigationItem.scrollEdgeAppearance = self.navigationItem.standardAppearance;
    
    
    //设置一个自定义的视图添加到导航栏上。
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 395, 44)];
    view1.backgroundColor = [UIColor grayColor];
    view1.center = self.navigationController.navigationBar.center;
    
    //创建一个标题
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:25.0];
    self.labeltheme.font = font;
    self.labeltheme.frame = CGRectMake(80, 0, 150, 35);
    [view1 addSubview:self.labeltheme];
    
    
    self.navigationItem.titleView = view1;
}

- (void) imageviewAdd {
    CGSize photosize = self.image.size;
    NSLog(@"photo width: %f, height: %f", photosize.width, photosize.height);
    CGFloat height = (photosize.height/photosize.width)*293;
    NSLog(@"height = %lf", height);
    
    self.imageview = [[UIImageView alloc] initWithImage:self.image];
//    self.imageview.frame = CGRectMake(50, 98, 293, height);
    
    [self.view addSubview:self.imageview];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view); // 图片视图水平居中于父视图
        make.top.equalTo (@125);
        make.width.mas_equalTo(@293); // 图片视图宽度约束
        make.height.mas_equalTo(height); // 图片视图高度约束
    }];
}

- (void) contentAdd {
    UIFont *font = [UIFont systemFontOfSize:20];
    self.labelcontent.font = font;
//    self.labelcontent.frame = CGRectMake(20, 450, 353, 150);
    self.labelcontent.numberOfLines = 0;
    [self.view addSubview:self.labelcontent];
    
    [self.labelcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view); // 标签水平居中于父视图
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.width.equalTo(@353);
        make.height.equalTo(@150);
        make.top.equalTo(self.imageview.mas_bottom).offset(50);
    }];
    
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
