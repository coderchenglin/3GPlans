//
//  SecondViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import "SecondViewController.h"



@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"搜索";
    title.frame = CGRectMake((width - 150)/2, 30, 150, 70);//设置frame剧中
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter; //设置文本居中
    [_falseView addSubview:title];
    
    _uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uploadButton setImage:[UIImage imageNamed:@"img2.png"] forState:UIControlStateNormal];
    _uploadButton.frame = CGRectMake(width - 50, 50, 40, 40);
    [_falseView addSubview:_uploadButton];
    _uploadButton.layer.masksToBounds = YES;
    _uploadButton.layer.cornerRadius = 5.0;
    [_uploadButton addTarget:self action:@selector(pressUpload:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 120, width, 50)];
    [self.view addSubview:_searchBar];
    _searchBar.placeholder = @"搜索 用户名 作品分类 文章";
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.showsCancelButton = NO;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    
    
    _goodColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    
    UIButton *classification = [UIButton buttonWithType:UIButtonTypeCustom];
    [classification setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [classification setTitle:@"分类" forState:UIControlStateNormal];
    classification.frame = CGRectMake(10, 200, 70, 20);
    [classification setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [classification setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    [self.view addSubview:classification];
    classification.backgroundColor = _goodColor;
    classification.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *recommend = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommend setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [recommend setTitle:@"推荐" forState:UIControlStateNormal];
    //[recommend setTitleColor:[UIColor redColor] forState:UIControlStateNormal]; //设置按钮字体颜色，默认为白色
    recommend.frame = CGRectMake(10, 300, 70, 20);
    [recommend setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [recommend setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    [self.view addSubview:recommend];
    recommend.backgroundColor = _goodColor;
    recommend.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *time = [UIButton buttonWithType:UIButtonTypeCustom];
    [time setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [time setTitle:@"时间" forState:UIControlStateNormal];
    time.frame = CGRectMake(10, 360, 70, 20);
    [time setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [time setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    [self.view addSubview:time];
    time.backgroundColor = _goodColor;
    time.titleLabel.font = [UIFont systemFontOfSize:15];
    
    NSArray *oneArray = [[NSArray alloc] initWithObjects:@"平面设计", @"网页设计", @"UI/icon", @"插画/手绘", @"虚拟与设计", @"影视", @"摄影", @"其他", nil];
    NSArray *twoArray = [[NSArray alloc] initWithObjects:@"人气最高", @"收藏最多", @"评论最多", @"编辑精选", nil];
    NSArray *threeArray = [[NSArray alloc] initWithObjects:@"30分钟前", @"1小时前", @"1月前", @"1年前", nil];

    int m = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
            oneButton.frame = CGRectMake(20 + 85 * j, 230 + 30*i, 70, 20);
            oneButton.backgroundColor = [UIColor whiteColor];
            [oneButton setTitle:oneArray[m] forState:UIControlStateNormal];
            [oneButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:oneButton];
            oneButton.tintColor = [UIColor blackColor];
            oneButton.layer.masksToBounds = YES;
            oneButton.layer.cornerRadius = 10.0;
            oneButton.tag = 101 + m;
            m++;
        }
    }

    for (int i = 0; i < 4; i++) {
        UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        oneButton.frame = CGRectMake(20 + 85 * i, 330, 70, 20);
        oneButton.backgroundColor = [UIColor whiteColor];
        [oneButton setTitle:twoArray[i] forState:UIControlStateNormal];
        [oneButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:oneButton];
        oneButton.tintColor = [UIColor blackColor];
        oneButton.layer.masksToBounds = YES;
        oneButton.layer.cornerRadius = 10;
        oneButton.tag = 101 + i;
    }

    //按钮 ：
    //1.frame 2.backGround 3.title 4.addTarget 5.addSubView
    //6.tintColor 7.layer 8.tag
    for (int i = 0; i < 4; i++) {
        UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        oneButton.frame = CGRectMake(20 + 85 * i, 390, 70, 20);
        oneButton.backgroundColor = [UIColor whiteColor];
        [oneButton setTitle:threeArray[i] forState:UIControlStateNormal];
        [oneButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:oneButton];
        oneButton.tintColor = [UIColor blackColor];
        [oneButton.layer setMasksToBounds:YES];
        [oneButton.layer setCornerRadius:10];
        oneButton.tag = 101 + i;
    }
}

- (void)pressUpload:(UIButton*)button {
    UploadViewController *uploadView = [[UploadViewController alloc] init];
    uploadView.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:uploadView animated:YES completion:nil];
}

- (void)pressButton:(UIButton*)button {
    if (button.tag > 100) {
        button.backgroundColor = _goodColor;
        button.tag -= 100;
        button.tintColor = [UIColor whiteColor];
    } else {
        button.backgroundColor = [UIColor whiteColor];
        button.tag += 100;
        button.tintColor = [UIColor blackColor];
    }
}

//按搜索框搜索键按下时，调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@"大白"]) {
        BigWhiteViewController *bigView = [[BigWhiteViewController alloc] init];
        bigView.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];//这代表一个权透明的黑色
        bigView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:bigView animated:YES completion:nil];
    }
}

//收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
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
