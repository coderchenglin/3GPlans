//
//  searchViewController.m
//  LastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import "searchViewController.h"
#import "ViewController1.h"
#import "myCollectionView.h"
//#import "myCollectionViewCell.h"
#import "MyLayout.h"
#import "cellViewController.h"
#import <MJRefresh/MJRefresh.h>
//#import "shuju.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//extern UIColor *colorOfBack;
//extern UIColor *darkerColorOfBack;

@interface searchViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) myCollectionView* collectionview;
@property (nonatomic, strong) NSMutableArray* arraytheme;
@property (nonatomic, strong) NSMutableArray* arraycontent;
//@property (nonatomic, strong) shuju* shu;
@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.arraytheme = [NSMutableArray array];
    self.arraycontent = [NSMutableArray array];
//    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    self.tabBarController.tabBar.barTintColor = [UIColor blueColor];
//    self.tabBarController.tabBar.translucent = NO;
    self.tabBarItem.badgeColor = [UIColor blueColor];
    
//    [self navigationadd];
    [self request];
    [self collectionadd];
}

- (void) collectionadd {
    MyLayout* layout = [[MyLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    self.collectionview = [[myCollectionView alloc] initWithFrame:CGRectMake(0, 98, 393, self.view.bounds.size.height-180) collectionViewLayout:layout];
    
    self.collectionview = [[myCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collectionview.delegate = self;
    
    [self.view addSubview: _collectionview];
    
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@100);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@(SIZE_HEIGHT - 180));
//        make.bottom.equalTo(self.tabBarController.tabBar.mas_top);
    }];
    
}

//请求数据
- (void) request {
    
    NSURL* url = [NSURL URLWithString:@"http://192.168.0.195:8080/articles"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求失败");
            NSLog(@"%@", error);
        } else {
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"请求成功");
            NSLog(@"%@", array[0][@"title"]);
            NSLog(@"%@", array[0][@"content"]);
            
            for (int i = 0; i < 10; i++) {
                [self.arraytheme addObject:array[i][@"title"]];
                [self.arraycontent addObject:array[i][@"content"]];
            }
            //NSLog(@"%lu", self.arraytheme.count);
        }
    }];
    
    [datatask resume];
}

- (void) navigationadd {
    //设置一个自定义的视图添加到导航栏上。
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 395, 44)];
    view1.backgroundColor = [UIColor grayColor];;
    view1.center = self.navigationController.navigationBar.center;
    
    //创建一个标题
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 44)];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:33.0];
    title.text = @"搜索";
    title.font = font;
    [view1 addSubview:title];
    
    //创建一个视图添加到导航栏上
    UIImageView* imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索.png"]];
    imageview.frame = CGRectMake(320, 8, 30, 30);
    imageview.userInteractionEnabled = YES;
    
    //添加点击事件
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [imageview addGestureRecognizer:tap];
    
    [view1 addSubview:imageview];
    
    self.navigationItem.titleView = view1;
}

- (void)imageTapped:(UITapGestureRecognizer *)gesture {
    
    ViewController1* viewcontroller = [[ViewController1 alloc] init];
//    viewcontroller.hidesBottomBarWhenPushed = YES;
    viewcontroller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewcontroller animated:NO completion:nil];

}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cellViewController* vc = [[cellViewController alloc] init];
    vc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",  indexPath.row%5+1 ]];
    
    vc.labelcontent = [[UILabel alloc] init];
    vc.labelcontent.text = self.arraycontent[indexPath.row%10];
    
    vc.labeltheme = [[UILabel alloc] init];
    vc.labeltheme.text = self.arraytheme[indexPath.row%10];
    
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}





@end
