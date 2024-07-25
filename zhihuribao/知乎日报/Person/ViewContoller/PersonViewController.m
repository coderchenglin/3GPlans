//
//  PersonViewController.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/10/19.
//

#import "PersonViewController.h"
#import "CollectViewController.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface PersonViewController ()

@property (nonatomic, strong) PersonView *mainView;
@property (nonatomic, strong) CollectViewController *collectView;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addUI];
}

//使用动画的方式隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)addUI {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCollectView:) name:@"CollectView" object:nil];
    
    self.mainView = [[PersonView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    
    [self.mainView.backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.headButton addTarget:self action:@selector(changHead:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.mainView];
}

- (void)showCollectView:(NSNotification *)sender {
    self.collectView = [[CollectViewController alloc] init];
    self.collectView.allTransDataArray = self.allTransDataArray; //将allTransDataArray，收藏信息传过去
    self.collectView.fileName = self.fileName;//将数据库文件名传过去
    [self.navigationController pushViewController:self.collectView animated:YES];
}

- (void)changHead:(UIButton *)button {
    NSLog(@"头像");
}

- (void)backView:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
