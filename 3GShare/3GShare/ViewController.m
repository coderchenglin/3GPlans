//
//  ViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/4.
//

#import "ViewController.h"
#import "LandViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"1 开机界面.jpg"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:imageview];
    
    _timerView = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(overtimer:) userInfo:@"chenglin" repeats:YES];
    
}

- (void)overtimer:(NSTimer*)timer {
    [_timerView invalidate];
    
    LandViewController *landView = [[LandViewController alloc] init];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    landView.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:landView animated:YES completion:nil];
    

}




@end
