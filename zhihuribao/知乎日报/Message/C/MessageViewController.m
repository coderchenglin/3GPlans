//
//  MessageViewController.m
//  知乎日报
//
//  Created by 张佳乔 on 2021/11/2.
//

#import "MessageViewController.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

//使用动画的方式隐藏导航栏 *
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//
- (void)createUI {
    
    self.longHeightArray = [[NSMutableArray alloc] init];  //长评论高度数组
    self.shortHeightArray = [[NSMutableArray alloc] init]; //短评论高度数组
    self.longReplyHeightArray = [[NSMutableArray alloc] init]; //长回复高度数组
    self.shorReplytHeightArray = [[NSMutableArray alloc] init];//短回复高度数组
    
    for (int i = 0; i < [self.longDictionary[@"comments"] count]; i++) {
        //评论的内容
        UILabel *label = [[UILabel alloc] init];
        label.text = self.longDictionary[@"comments"][i][@"content"];
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0;
        CGSize size = [label sizeThatFits:CGSizeMake(myWidth / 1.3, CGFLOAT_MAX)]; // 此方法是 UIView 类的一个常见方法，用于返回视图在指定大小内的最佳大小。CGFLOAT_MAX表示浮点数最大正整数值
        //这句代码就是给定了评论的宽度，让他自动计算出所需高度，并返回CGSize
        
        //回复的内容
        UILabel *labelReply = [[UILabel alloc] init];
        CGSize sizeReply = CGSizeZero; //讲size初始化为0
        if ([self.longDictionary[@"comments"][i] objectForKey:@"reply_to"]) { //如果该评论有回复
            NSString *replyAll = [[NSString alloc] initWithFormat:@"//%@：%@", self.longDictionary[@"comments"][i][@"reply_to"][@"author"], self.longDictionary[@"comments"][i][@"reply_to"][@"content"]]; //格式化回复的内容
            labelReply.text = replyAll;
            labelReply.font = [UIFont systemFontOfSize:15];
            labelReply.numberOfLines = 0;
            sizeReply = [labelReply sizeThatFits:CGSizeMake(myWidth / 1.3, CGFLOAT_MAX)]; //这里算出该回复在给定宽度的情况下，自己算出所需要的高度，并返回一个CGSize
        }
        //保存长评论的高度 和 长回复的高度
        NSString *replyHeight = [[NSString alloc] initWithFormat:@"%lf", sizeReply.height];
        [self.longReplyHeightArray addObject:replyHeight];
        NSString *height = [[NSString alloc] initWithFormat:@"%lf", size.height];
        [self.longHeightArray addObject:height];
    }
    
    //算出并保存下每一个短评论和短回复的高度
    for (int i = 0; i < [self.shortDictionary[@"comments"] count]; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.shortDictionary[@"comments"][i][@"content"];
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0;
        CGSize size = [label sizeThatFits:CGSizeMake(myWidth / 1.3, CGFLOAT_MAX)];
        UILabel *labelReply = [[UILabel alloc] init];
        CGSize sizeReply = CGSizeZero;
        if ([self.shortDictionary[@"comments"][i] objectForKey:@"reply_to"]) {
            NSString *replyAll = [[NSString alloc] initWithFormat:@"//%@：%@", self.shortDictionary[@"comments"][i][@"reply_to"][@"author"], self.shortDictionary[@"comments"][i][@"reply_to"][@"content"]];
            labelReply.text = replyAll;
            labelReply.font = [UIFont systemFontOfSize:15];
            labelReply.numberOfLines = 0;
            sizeReply = [labelReply sizeThatFits:CGSizeMake(myWidth / 1.3, CGFLOAT_MAX)];
        }
        NSString *replyHeight = [[NSString alloc] initWithFormat:@"%lf", sizeReply.height];
        [self.shorReplytHeightArray addObject:replyHeight];
        NSString *height = [[NSString alloc] initWithFormat:@"%lf", size.height];
        [self.shortHeightArray addObject:height];
    }
    
    self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    
    //将长评论和长回复的高度数组，存储为字典形式放进longHeightDictionary中
    //结构：一个字典，里面包含两个键值对，一个是 评论高度和评论高度数组，一个是回复高度和回复高度数组
    self.longHeightDictionary = [[NSMutableDictionary alloc] init];
    [self.longHeightDictionary setObject:self.longHeightArray forKey:@"Height"];
    [self.longHeightDictionary setObject:self.longReplyHeightArray forKey:@"Reply"];
    //和上面一个，保存短的
    self.shortHeightDictionary = [[NSMutableDictionary alloc] init];
    [self.shortHeightDictionary setObject:self.shortHeightArray forKey:@"Height"];
    [self.shortHeightDictionary setObject:self.shorReplytHeightArray forKey:@"Reply"];
    
    //发送通知给MessageView，同时传值，一个保存长评论高度和长回复高度两个数组的字典
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransLongHeightDictionary" object:nil userInfo:self.longHeightDictionary];
    //短的
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransShortHeightDictionary" object:nil userInfo:self.shortHeightDictionary];
    
    //发送通知给MessageView，同时传值，网路请求下来的长评论和长回复的内容的字典
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransLongDictionary" object:nil userInfo:self.longDictionary];
    //短的
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransShortDictionary" object:nil userInfo:self.shortDictionary];
    //返回按钮
    [self.messageView.backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageView];
}


//评论界面的返回按钮 *
- (void)pressBack:(UIButton*)button {
    [self.navigationController popViewControllerAnimated:YES];
}
//
//- (CGFloat)calculatedHeight:(UILabel *)label {
//    //有源码在 有需求自行微调即可
//    NSInteger n = 6;//最多显示的行数
//    CGSize labelSize = {0, 0};
//
//    labelSize = [self calculatedTextHeightFromTextString:label.text width:label.frame.size.width fontSize:label.font.pointSize];
//
//    //return label.font.lineHeight;
//    //NSLog(@"%f",label.font.pointSize);//获取 label的字体大小
//    //NSLog(@"%f",label.font.lineHeight);//获取label的在不同字体下的时候所需要的行高
//    //NSLog(@"%f",labelSize.height);//label计算行高
//    CGFloat rate = label.font.lineHeight; //每一行需要的高度
//
//    CGRect frame= label.frame;
//    if (labelSize.height > rate * n) {
//        frame.size.height = rate * n;
//    } else {
//        frame.size.height = labelSize.height;
//    }
//    label.frame = frame;
//    return label.font.lineHeight;
//}
//
////计算 label需要的宽度和高度方法
//- (CGSize)calculatedTextHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
//    //计算 label需要的宽度和高度
//    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//
//    CGSize nowTextSize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]}];
//
//    return CGSizeMake(nowTextSize.width, rect.size.height);
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
