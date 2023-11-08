//
//  ContentViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mutableArray = [[NSMutableArray alloc] init];
    [_mutableArray addObject:_good];
    [_mutableArray addObject:_share];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.contentSize = CGSizeMake(width, height * 2 - 200);
    _scrollView.frame = CGRectMake(0, 100, width, height); //100是falseView的高度
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(15, 40, 50, 50);
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [_falseView addSubview:_backButton];
    
    UIImage *touImage = [UIImage imageNamed:@"works_img.png"];
    UIImageView *touImageView = [[UIImageView alloc] initWithImage:touImage];
    touImageView.frame = CGRectMake(10, 10, 75, 75);
    [_scrollView addSubview:touImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(100, 10, 70, 30);
    title.text = @"假日";
    title.font = [UIFont systemFontOfSize:24];
    [_scrollView addSubview:title];
    
    UILabel *describe = [[UILabel alloc] init];
    describe.text = @"share小白";
    describe.frame = CGRectMake(100, 50, 100, 20);
    describe.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:describe];
    
    _shareNumber = [_share integerValue];
    _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *goodImageName = [[NSString alloc] initWithFormat:@"button_good.png"];
    [_goodButton setImage:[UIImage imageNamed:goodImageName] forState:UIControlStateNormal];
    NSString *lookImageName = [[NSString alloc] initWithFormat:@"button_look.png"];
    [_lookButton setImage:[UIImage imageNamed:lookImageName] forState:UIControlStateNormal];
    NSString *shareImageName = [[NSString alloc] initWithFormat:@"button_share.png"];
    [_shareButton setImage:[UIImage imageNamed:shareImageName] forState:UIControlStateNormal];
    
    [_goodButton setTitle:_good forState:UIControlStateNormal];
    [_goodButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_lookButton setTitle:_look forState:UIControlStateNormal];
    [_lookButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_shareButton setTitle:_share forState:UIControlStateNormal];
    [_shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [_goodButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton addTarget:self action:@selector(pressShare:) forControlEvents:UIControlEventTouchUpInside];
    
    _goodButton.frame = CGRectMake(width - 195, 30, 60, 40);
    _lookButton.frame = CGRectMake(width - 135, 30, 60, 40);
    _shareButton.frame = CGRectMake(width - 75, 30, 60, 40);
    
    [_goodButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_goodButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [_lookButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_lookButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [_shareButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -50, 0, 0)];
    [_shareButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    
    [_scrollView addSubview:_goodButton];
    [_scrollView addSubview:_lookButton];
    [_scrollView addSubview:_shareButton];
    
    UILabel *cont = [[UILabel alloc] init];
    cont.text = @"多希望列车能把我带到有你的城市。";
    cont.frame = CGRectMake(10, 100, 300, 20);
    [_scrollView addSubview:cont];
    
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"works_img%d.png", i + 1];
        UIImage *aImage = [UIImage imageNamed:imageName];
        UIImageView *aImageView = [[UIImageView alloc] initWithImage:aImage];
        aImageView.frame = CGRectMake(15, 130 + 210 * i, width-30, 200);
        [_scrollView addSubview:aImageView];
    }
    
    for (int i = 0; i < 2; i++) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"works_img%d.png", i + 4];
        UIImage *aImage = [UIImage imageNamed:imageName];
        UIImageView *aImageView = [[UIImageView alloc] initWithImage:aImage];
        aImageView.frame = CGRectMake(74, 760 + 400 * i, width - 2*74, 370);
        [_scrollView addSubview:aImageView];
    }
    
}

- (void)pressGood:(UIButton*)button {
    if ([button.titleLabel.text isEqualToString:@"957"]) {
        [_goodButton setTitle:@"958" forState:UIControlStateNormal];
        [_mutableArray replaceObjectAtIndex:0 withObject:@"958"];
    } else {
        [_goodButton setTitle:@"957" forState:UIControlStateNormal];
        [_mutableArray replaceObjectAtIndex:0 withObject:@"957"];
    }
}

- (void)pressShare:(UIButton*)button {
    _shareNumber++;
    _share = [[NSString alloc] initWithFormat:@"%ld", (long)_shareNumber];
    [_shareButton setTitle:_share forState:UIControlStateNormal];
    [_mutableArray replaceObjectAtIndex:1 withObject:_share];
}

- (void)pressBack:(UIButton*)button {
    [_delegate transmissionNumber:_mutableArray];
    [self dismissViewControllerAnimated:YES completion:nil];
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
