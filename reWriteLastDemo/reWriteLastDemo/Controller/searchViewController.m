//
//  searchViewController.m
//  reWriteLastDemo
//
//  Created by chenglin on 2024/4/9.
//

#import "searchViewController.h"
//#import "ViewController1.h"
#import "myCollectionView.h"
//#import "cellViewController.h"
#import "MyLayout.h"
#import "Masonry.h"

#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface searchViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) myCollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* arraytheme;
@property (nonatomic, strong) NSMutableArray* arraycontent;

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    self.arraytheme = [NSMutableArray array];
    self.arraycontent = [NSMutableArray array];
    
    [self request];
    [self collectionAdd];
    
}

- (void)collectionAdd {
    MyLayout* layout = [[MyLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[myCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@(SIZE_HEIGHT - 180));
    }];
}

- (void)request {
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.195:8080/articles"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GRT";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求失败");
            NSLog(@"%@",error);
        } else {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"请求成功");
            NSLog(@"%@", array[0][@"title"]);
            NSLog(@"%@", array[0][@"content"]);
            
            for (int i = 0; i < 10; i++) {
                [self.arraytheme addObject:array[i][@"title"]];
                [self.arraycontent addObject:array[i][@"content"]];
            }
        }
    }];
    
    [dataTask resume];
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
