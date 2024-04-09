//
//  ViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/2.
//

#import "ViewController.h"
#import "FifthViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "View.h"
#import "FirstView.h"
#import "LoginViewController.h"
#pragma mark 韩部分
#import "mineViewController.h"
#import "searchViewController.h"
#import "informationViewController.h"

UIColor *colorOfBack;
UIColor *darkerColorOfBack;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *homePath = NSHomeDirectory();
    NSLog(@"Home目录：%@",homePath);
    _beginView = [[View alloc] initWithFrame:self.view.bounds];
    _beginView.scrollView.delegate = self;
//    [_beginView.moreButton addTarget:self action:@selector(createTabToJump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beginView];
    [_beginView.loginBtn addTarget:self action:@selector(firstLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTabToJump) name:@"jumpToHome" object:nil];
    [self getVoice];
    [self getNSUserDefaultToken];
    
}
//
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)firstLoginBtn {
//    LoginViewController *t = [[LoginViewController alloc] init];
//    t.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:t animated:YES completion:nil];
//  
//
    [self createTabToJump];
    
//    [self verifyToken];
}

#pragma mark 获取NSUserDefault中的token
- (NSString *)getNSUserDefaultToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"UserToken"];
    return username;
}

#pragma mark 验证token
- (void)verifyToken {
    // 获取数据库路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"tokenDataBase.sqlite"];
    // 创建数据库实例
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    // 打开数据库
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    NSString *tokenToVerify = [self getNSUserDefaultToken];
    if (tokenToVerify == nil) {
        LoginViewController *t = [[LoginViewController alloc] init];
        t.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:t animated:YES completion:nil];
        return;
    }
    BOOL tokenExists = NO;
    if ([db open]) {
        NSString *querySql = @"SELECT * FROM 't_tokenDataBase' WHERE token = ?";
        FMResultSet *resultSet = [db executeQuery:querySql, tokenToVerify];
        // 如果能够从数据库中取得数据，代表Token存在
        if ([resultSet next]) {
            NSLog(@"Token验证成功");
            tokenExists = YES;
            [self createTabToJump];
        } else {
            NSLog(@"Token验证失败");
            LoginViewController *t = [[LoginViewController alloc] init];
            t.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:t animated:YES completion:nil];
        }
        
        [db close];
    } else {
        NSLog(@"数据库打开失败");
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算当前显示的页面索引
    if (scrollView.tag == 100){
        NSInteger pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;

        // 遍历所有的播放器
        for (int i = 0; i < _beginView.playersArray.count; i++) {
            AVPlayer *player = _beginView.playersArray[i];
            if (i == pageIndex) {
                // 如果是当前页面的视频，播放
                [player seekToTime:kCMTimeZero];
                [player play];
            } else {
                // 如果不是当前页面的视频，暂停
                [player seekToTime:kCMTimeZero];
                [player pause];

            }
        }
    }
}

#pragma mark 让实机播放音频
- (void)getVoice {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"设置音频会话类别时发生错误: %@", error);
    } else {
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        if (error) {
            NSLog(@"激活音频会话时发生错误: %@", error);
        }
    }
}

# pragma mark - 解决播放逻辑问题方法1
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    //必须要子视图
    UIView *view = [_beginView.scrollView viewWithTag:pageIndex];
    UIButton *button = (UIButton *)view;
    button.selected = NO;
}

#pragma mark tabBar
- (void)createTabToJump {
    [_beginView showLoadMoreView];
    for (AVPlayer *player in self.beginView.playersArray) {
        [player pause];
    }
    
    NSInteger pageIndex = _beginView.scrollView.contentOffset.x / _beginView.scrollView.frame.size.width;
    NSString *nowImageName = [NSString stringWithFormat:@"backGround%ld.PNG", pageIndex + 1];
    UIImage *nowImage = [UIImage imageNamed:nowImageName];
    colorOfBack = [self mostColor:nowImage];
    darkerColorOfBack = [self mostDarkerColor:nowImage];
    
    FirstViewController *vcFirst = [[FirstViewController alloc] init];
    vcFirst.backColor = _colorOfBack;
    UIImage *vcFirst_normalImage = [UIImage imageNamed:@"tabIconNo1.png"];
    vcFirst_normalImage = [vcFirst_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *vcFirst_pressImage = [UIImage imageNamed:@"tabIconYes1.png"];
    vcFirst_pressImage = [vcFirst_pressImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *vcFirstIcon = [[UITabBarItem alloc] initWithTitle:@"Home" image:vcFirst_normalImage selectedImage:vcFirst_pressImage];
    vcFirst.tabBarItem = vcFirstIcon;
    UINavigationController *navFirst = [[UINavigationController alloc]initWithRootViewController:vcFirst];
    
    SecondViewController *vcSecond = [[SecondViewController alloc] init];
    vcSecond.backColor = _colorOfBack;
    UIImage *vcSecond_normalImage = [UIImage imageNamed:@"tabIconNo2.png"];
    vcSecond_normalImage = [vcSecond_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *vcSecond_pressImage = [UIImage imageNamed:@"tabIconYes2.png"];
    vcSecond_pressImage = [vcSecond_pressImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *vcSecondIcon = [[UITabBarItem alloc] initWithTitle:@"Community" image:vcSecond_normalImage selectedImage:vcSecond_pressImage];
    vcSecond.tabBarItem = vcSecondIcon;
    UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:vcSecond];
    
    //测试
    UINavigationBarAppearance* appearance = [UINavigationBarAppearance new];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = _colorOfBack;
    appearance.shadowColor = [UIColor clearColor];
    
    
    searchViewController *vcThird = [[searchViewController alloc] init];
    //vcThird.backColor = _colorOfBack;
    UIImage *vcThird_normalImage = [UIImage imageNamed:@"tabIconNo3.png"];
    vcThird_normalImage = [vcThird_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *vcThird_pressImage = [UIImage imageNamed:@"tabIconYes3.png"];
    vcThird_pressImage = [vcThird_pressImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *vcThirdIcon = [[UITabBarItem alloc] initWithTitle:@"Discover" image:vcThird_normalImage selectedImage:vcThird_pressImage];
    vcThird.tabBarItem = vcThirdIcon;
    UINavigationController *navThird = [[UINavigationController alloc]initWithRootViewController:vcThird];
    navThird.navigationBar.standardAppearance = appearance;
    navThird.navigationBar.scrollEdgeAppearance = navThird.navigationBar.standardAppearance;
    
    
    
    informationViewController *vcFourth = [[informationViewController alloc] init];
    //vcFourth.backColor = _colorOfBack;
    UIImage *vcFourth_normalImage = [UIImage imageNamed:@"tabIconNo4.png"];
    vcFourth_normalImage = [vcFourth_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *vcFourth_pressImage = [UIImage imageNamed:@"tabIconYes4.png"];
    vcFourth_pressImage = [vcFourth_pressImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *vcFourthIcon = [[UITabBarItem alloc] initWithTitle:@"Friends" image:vcFourth_normalImage selectedImage:vcFourth_pressImage];
    vcFourth.tabBarItem = vcFourthIcon;
    UINavigationController *navFourth = [[UINavigationController alloc]initWithRootViewController:vcFourth];
    navFourth.navigationBar.standardAppearance = appearance;
    navFourth.navigationBar.scrollEdgeAppearance = navFourth.navigationBar.standardAppearance;
    
    mineViewController *vcFifth = [[mineViewController alloc] init];
    vcFifth.backColor = _colorOfBack;
    UIImage *vcFifth_normalImage = [UIImage imageNamed:@"tabIconNo5.png"];
    vcFifth_normalImage = [vcFifth_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *vcFifth_pressImage = [UIImage imageNamed:@"tabIconYes5.png"];
    vcFifth_pressImage = [vcFifth_pressImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *vcFifthIcon = [[UITabBarItem alloc] initWithTitle:@"Personal" image:vcFifth_normalImage selectedImage:vcFifth_pressImage];
    vcFifth.tabBarItem = vcFifthIcon;
    UINavigationController *navFifth = [[UINavigationController alloc]initWithRootViewController:vcFifth];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[navFirst, vcSecond, navThird, navFourth, navFifth];
    tabBarController.selectedIndex = 0;
    
    
    tabBarController.tabBar.tintColor = [UIColor whiteColor]; // 设置选中的 TabBarItem 颜色
    tabBarController.tabBar.backgroundColor = darkerColorOfBack;
    tabBarController.modalPresentationStyle = 0;
//    [_beginView.player pause];
    [self presentViewController:tabBarController animated:YES completion:nil];
    [_beginView hideLoadMoreView];

}

#pragma mark 获取主色调颜色函数
- (UIColor*)mostColor:(UIImage*)Image{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(Image.size.width / 10, Image.size.height / 10);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width * 4,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, Image.CGImage);
    CGColorSpaceRelease(colorSpace);
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height * 0.5; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            if (red > 240 || green > 240 || blue > 240) {
                
            } else if (alpha <= 0) {
                
            } else {
                NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                [cls addObject:clr];
            }
            
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
}

#pragma mark 获取更深色调
- (UIColor*)mostDarkerColor:(UIImage*)Image{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(Image.size.width / 10, Image.size.height / 10);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width * 4,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, Image.CGImage);
    CGColorSpaceRelease(colorSpace);
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height * 0.5; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            if (red > 240 || green > 240 || blue > 240) {
                
            } else if (alpha <= 0) {
                
            } else {
                NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                [cls addObject:clr];
            }
            
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    float darkFactor = 0.75; // 您可以调整这个值来控制颜色变暗的程度
      int red = [MaxColor[0] intValue] * darkFactor;
      int green = [MaxColor[1] intValue] * darkFactor;
      int blue = [MaxColor[2] intValue] * darkFactor;
      int alpha =  [MaxColor[3] intValue]; // 通常不需要改变透明度

      return [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    
}

@end
