//
//  ChaosViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ChaosViewController : UIViewController
@property (nonatomic, strong) NSString *uRL;
@property (strong, nonatomic) WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
