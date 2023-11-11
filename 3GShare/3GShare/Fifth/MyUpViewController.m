//
//  MyUpViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/11.
//

#import "MyUpViewController.h"

@interface MyUpViewController ()

@end

@implementation MyUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景板标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"我上传的";
    title.frame = CGRectMake((width - 150)/2, 30, 150, 70);//设置frame剧中
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter; //设置文本居中
    [super.falseView addSubview:title];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(20, 40, 50, 50);
    [self.backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];

    
    NSArray *segmentItems = @[@"上传时间", @"推荐最多", @"分享最多"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    self.segmentedControl.frame = CGRectMake(0, 100, width, 40);
    
    [self.segmentedControl addTarget:self action:@selector(pressSegmented:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}


////这里可以重写父类的函数，当然也可以不重写
//- (void)pressSegmented:(UISegmentedControl *)segmentedControl {
//    [super pressSegmented:segmentedControl];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
