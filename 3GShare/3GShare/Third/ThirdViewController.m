//
//  ThirdViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"文章";
    title.frame = CGRectMake(185, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [self.falseView addSubview:title];
    
    NSArray *segmentItems = @[@"精选文章", @"热门推荐", @"全部文章"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    self.segmentedControl.frame = CGRectMake(0, 100, width, 40);
    [self.segmentedControl addTarget:self action:@selector(pressSegmented:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
    

    
}

//- (void)pressBack:(UIButton*)button {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//- (void)pressSegmented:(UISegmentedControl*)segmentedControl {
//
//    [super pressSegmented:segmentedControl];  //调用父类的类方法 ，这个方法需要在父类的.h文件中声明
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
