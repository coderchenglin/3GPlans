//
//  NewViewController.m
//  game
//
//  Created by chenglin on 2024/4/25.
//

#import "NewViewController.h"

@interface NewViewController ()

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 153.7, 393, 544.6)];
    self.backgroundView.image = [UIImage imageNamed:@"background2.jpg"];
    [self.view addSubview:self.backgroundView];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    NSLog(@"屏幕宽度：%.0f", screenWidth);   //393
    NSLog(@"屏幕高度：%.0f", screenHeight);  //852
    
    double delayInSeconds = 0.5;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        // 在延迟后执行的代码块
        NSLog(@"延迟0.5秒后执行的代码");
        // 这里可以添加需要延迟执行的任务
        self.currentIndex = 0;
        self.messageBox = [[UIImageView alloc] initWithFrame:CGRectMake(160, 170, 200, 300)];
        self.messageBox.image = [UIImage imageNamed:@"message.jpg"];
        [self.view addSubview:self.messageBox];
    });
    
    delayInSeconds = 1;
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        // 在延迟后执行的代码块
        NSLog(@"延迟0.5秒后执行的代码");
        // 这里可以添加需要延迟执行的任务
        self.currentIndex = 0;
//        self.messageBox = [[UIImageView alloc] initWithFrame:CGRectMake(160, 170, 200, 300)];
//        self.messageBox.image = [UIImage imageNamed:@"message.jpg"];
//        [self.view addSubview:self.messageBox];
        NSString *string1 = @"晋商文化：在中国明清以来的近代经济发展史上，驰骋欧亚的晋商举世瞩目，山西特别是以太谷、祁县、榆次、平遥等为代表的太原盆地商人前辈，举商贸之大业，经营范围包罗万象，夺金融之先声，钱庄票号汇通天下，在神州大地上留下了灿烂的商业文化。";
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setLabel:) userInfo:string1 repeats:YES];
        //        [self setLabel:string1];
    });
    
    // 设置下一步按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.nextButton.frame = self.view.bounds;
//    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 100, 40, 80, 40);
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 160, 480, 40 * 2.738, 40);
//    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextButton setImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
    self.nextButton.hidden = YES;
    
    [self.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
//    self.currentIndex = 0;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    
}



- (void)nextButtonTapped:(UIButton *)button {
    
    self.nextButton.hidden = YES;
//    self.currentIndex = 0;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    self.currentIndex = 0;

    if (self.num == 0) {
        self.num++;
        NSString *string2 = @"晋商是中国较早的商人，其历史可远溯到春秋战国时期。明清两代是晋商的鼎盛时期，晋商成为中国十大商帮之首。在中国商界称雄达500年之久。晋商之家族不同于一般官绅家族，它是具有商业烙印特征的中国传统文化家族。";
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setLabel:) userInfo:string2 repeats:YES];
//        [self setLabel:string2];
    } else if (self.num == 1) {
        self.num++;
        NSString *string3 = @"晋商中的一位重要代表人物王现曾经说过：“夫商与士，异术而同心。故善商者，处财货之场，而修高洁之行，是故虽利而不污；善士者，引先王之经，而绝货利之径，是故必名而有成。故利以义制，名以清修，恪守其业，天之鉴也。”";
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setLabel:) userInfo:string3 repeats:YES];
//        [self setLabel:string2];
    } else if (self.num == 2) {
        self.num++;
        NSString *string4 = @"这段话出自一个距今已有400多年的山西商人口中，着实令人惊叹。这番论述不仅点明了经商的不二法则，也道出了为官与为人的基本遵循。在王现等晋商看来，不论在什么时候、在什么情况下，只要按照这一法则为人处世、入仕经商，必定会做出一番不平凡的事业。";
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setLabel:) userInfo:string4 repeats:YES];
//        [self setLabel:string3];
    } else if (self.num == 3) {
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setLabel:(NSTimer *)timer {
    [self.label1 removeFromSuperview];
    

    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(170, 180, 180, 280)];
    self.label1.numberOfLines = 0;
    self.label1.font = [UIFont systemFontOfSize:16.0];
    self.label1.layer.cornerRadius = 10.0;
    self.label1.layer.masksToBounds = YES;
    
    self.label1.text = timer.userInfo;
    
    if (self.currentIndex < self.label1.text.length - 1) {
        NSString *subText = [self.label1.text substringToIndex:self.currentIndex + 2];
        self.label1.text = subText;
        self.currentIndex+=2;
    } else {
        [self.timer invalidate];
        self.nextButton.hidden = NO;
    }

    [self.view addSubview:self.label1];
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
