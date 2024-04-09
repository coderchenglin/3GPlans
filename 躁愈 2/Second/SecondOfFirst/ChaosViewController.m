//
//  ChaosViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import "ChaosViewController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface ChaosViewController ()

@end

@implementation ChaosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化WKWebView
    self.webView = [[WKWebView alloc] init];
    //    _webView.frame = CGRectMake(0, 200, Width, Height * 0.5);
    [self.view addSubview:self.webView];
    
    // 加载网址 
    NSURL *url = [NSURL URLWithString:_uRL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.webView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.webView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
