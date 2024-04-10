//
//  labelViewController.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/10.
//

#import "labelViewController.h"

@interface labelViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation labelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    //添加标题Label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, self.view.bounds.size.width - 40, 60)];
    self.titleLabel.text = self.articleTitle;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    //设置自动调节字体大小以适应Label的宽度
    self.titleLabel.adjustsFontSizeToFitWidth = YES; //允许字体自动调节大小以适应宽度
    self.titleLabel.minimumScaleFactor = 0.5; //设置最小缩放比例
    
    [self.scrollView addSubview:self.titleLabel];
    
    
    //添加内容Label
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 600)];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [UIFont systemFontOfSize:18.0];
    self.contentLabel.text = self.articleContent;
    
    //创建NSMUtableParagraphStyle 对象，设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    
    //创建NSAttributedString，并应用paragraphStyle
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:18.0],
        NSForegroundColorAttributeName: [UIColor blackColor],
        NSParagraphStyleAttributeName: paragraphStyle
    };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.contentLabel.text attributes:attributes];
    
    self.contentLabel.attributedText = attributedString;
    
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
    CGSize labelSize = [self.contentLabel sizeThatFits:CGSizeMake(self.contentLabel.frame.size.width, CGFLOAT_MAX)];
    CGRect labelFrame = self.contentLabel.frame;
    labelFrame.size.height = labelSize.height;
    self.contentLabel.frame = labelFrame;
    
    
//    self.contentLabel.text = self.articleContent;
//    self.contentLabel.font = [UIFont systemFontOfSize:18.0];
//    self.contentLabel.textAlignment = NSTextAlignmentLeft;
//    self.contentLabel.numberOfLines = 0; //设置多行显示
    [self.scrollView addSubview:self.contentLabel];
    
    CGFloat contentHeight = CGRectGetMaxY(self.contentLabel.frame) + 80;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, contentHeight);
    
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
