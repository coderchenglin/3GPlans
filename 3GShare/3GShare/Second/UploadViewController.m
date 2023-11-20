//
//  UploadViewController.m
//  3GShare
//
//  Created by chenglin on 2023/11/8.
//

#import "UploadViewController.h"



@interface UploadViewController ()

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _goodColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    _color = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    _falseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 100)];
    [self.view addSubview:_falseView];
    UIImage *falseImage = [UIImage imageNamed:@"background_main.png"];
    UIImageView *falseImageView = [[UIImageView alloc] initWithImage:falseImage];
    falseImageView.frame = CGRectMake(0, 0, width, 100);
    [_falseView addSubview:falseImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"上传";
    title.frame = CGRectMake((width-150) / 2, 30, 150, 70);
    title.font = [UIFont systemFontOfSize:28];
    title.textColor = [UIColor whiteColor];
    [_falseView addSubview:title];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"back_img.png"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(20, 40, 50, 50);
    [_backButton addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    [self allinit];
    
    //一个全局的flag，初始值为NO标识折叠Cell开始处于关闭状态
    _openSelect = NO;
    
    _strArr = [[NSMutableArray alloc] init];
    [_strArr addObject:@"原创作品"];
    [_strArr addObject:@"设计资料"];
    [_strArr addObject:@"设计师观点"];
    [_strArr addObject:@"设计教程"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(220, 210, 100, 25)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册自定义cell
    [_tableView registerClass:[SelectTableViewCell class] forCellReuseIdentifier:@"fold"];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_button];
    _button.frame = CGRectMake(320, 210, 25, 25);
    [_button setImage:[UIImage imageNamed:@"fold.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(pressUnFold:) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = _color;
    
}

//创建（折叠）cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"fold" forIndexPath:indexPath];
    cell.backgroundColor = _color;
    cell.textLabel.text = _strArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //如果_openSelect标记为NO，即未打开，行数为1
    if (_openSelect == NO) {
        return 1;
    } else {
    //如果标记为YES，则行数为4
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //记录点击的元素
    _str = [NSMutableString stringWithString:_strArr[indexPath.row]];
    //将该元素提到第一个，insertObject：atIndex：函数自动后移其他元素
    [_strArr insertObject:_str atIndex:0];
    //因为加入了一个元素，选中元素本来存在的地方就后移一个，删除该元素
    [_strArr removeObjectAtIndex:indexPath.row + 1];
    //收缩tableview
    _openSelect = NO;
    //将tableview的大小改为一格的大小
    _tableView.frame = CGRectMake(220, 210, 100, 25);
    //button图标变为合上的图标
    [_button setImage:[UIImage imageNamed:@"close1.png"] forState:UIControlStateNormal];
    //刷新tableview
    [_tableView reloadData];
    
}

- (void)pressUnFold:(UIButton*)button {
    if (_openSelect == NO) {
        _tableView.frame = CGRectMake(220, 210, 100, 100);
        _openSelect = YES;
        [button setImage:[UIImage imageNamed:@"unFold.png"] forState:UIControlStateNormal];
    } else {
        _tableView.frame = CGRectMake(220, 210, 100, 25);
        _openSelect = NO;
        [button setImage:[UIImage imageNamed:@"fold.png"] forState:UIControlStateNormal];
    }
    
    //tmd记得要刷新数据啊!!!!!!改了我半个小时没发现
    [_tableView reloadData]; //重新加载table view的行（rows）和节（sections）
}

- (void)pressBack:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}






- (void)allinit {
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.backgroundColor = [UIColor grayColor];
    [_photoButton setTitle:@"选择图片" forState:UIControlStateNormal];
    _photoButton.frame = CGRectMake(10, 150, 200, 125);
    [_photoButton addTarget:self action:@selector(photoWall:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_photoButton];
    
    _titleText = [[UITextField alloc] init];
    _titleText.frame = CGRectMake(0, 400, width, 50);
    _titleText.delegate = self;
    _titleText.keyboardType = UIKeyboardTypeDefault;
    _titleText.borderStyle = UITextBorderStyleLine;
    _titleText.placeholder = @"作品名称";
    _titleText.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_titleText];
    
    _describeText = [[UITextField alloc] init];
    _describeText.frame = CGRectMake(0, 460, width, 200);
    _describeText.delegate = self;
    _describeText.keyboardType = UIKeyboardTypeDefault;
    _describeText.borderStyle = UITextBorderStyleLine;
    _describeText.placeholder = @"请添加作品说明/文章内容......";
//这是用于控制 UIControl（如按钮、文本框等）中内容的垂直对齐方式，默认是center对齐
    _describeText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _describeText.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_describeText];
    
    _releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseButton.backgroundColor = _goodColor;
    [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
    _releaseButton.frame = CGRectMake(12, 670, 400, 50);
    [_releaseButton addTarget:self action:@selector(pressRelease:) forControlEvents:UIControlEventTouchUpInside];
    _releaseButton.titleLabel.font = [UIFont systemFontOfSize:26];
    _releaseButton.layer.masksToBounds = YES;
    _releaseButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_releaseButton];
    
    UIButton *autoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [autoButton setTitle:@"禁止下载" forState:UIControlStateNormal];
    autoButton.frame = CGRectMake(20, 750, 120, 40);
    [autoButton addTarget:self action:@selector(noDownload:) forControlEvents:UIControlEventTouchUpInside];
    autoButton.titleLabel.tintColor = [UIColor blueColor];
    autoButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:autoButton];
    autoButton.tag = 201;
    
    NSArray *oneArray = [[NSArray alloc] initWithObjects:@"平面设计", @"网页设计", @"UI/icon", @"插画/手绘", @"虚拟与设计", @"影视", @"摄影", @"其他", nil];
    
    int m = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *oneButton  = [UIButton buttonWithType:UIButtonTypeSystem];
            oneButton.frame = CGRectMake(20 + 85*j, 300 + 45*i, 70, 20);
            oneButton.backgroundColor = [UIColor whiteColor];
            [oneButton setTitle:oneArray[m] forState:UIControlStateNormal];
            oneButton.titleLabel.font = [UIFont systemFontOfSize:18];
            [oneButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:oneButton];
            oneButton.tintColor = [UIColor blackColor];
            oneButton.layer.masksToBounds = YES;
            oneButton.layer.cornerRadius = 10.0;
            oneButton.tag = 101 + m;
            m++;
        }
    }
    
    UIImage *dingwei = [UIImage imageNamed:@"dingwei.png"];
    UIImageView *dingweiView = [[UIImageView alloc] initWithImage:dingwei];
    dingweiView.frame = CGRectMake(220, 170, 32, 32);
    [self.view addSubview:dingweiView];
    
    UILabel *wei = [[UILabel alloc] init];
    wei.text = @"陕西省，西安市";
    wei.frame = CGRectMake(260, 170, 95, 32);
    wei.backgroundColor = _goodColor;
    wei.font = [UIFont systemFontOfSize:12];
    wei.layer.masksToBounds = YES;
    wei.layer.cornerRadius = 10.0;
    wei.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wei];
}


- (void)photoWall:(UIButton*)button {
    PhotoWallViewController* photoWall = [[PhotoWallViewController alloc] init];
    
    photoWall.delegate = self;
    
    //用这个PhotoWallViewController来初始化导航控制器
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:photoWall];
    
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)pressRelease:(UIButton*)button {
    UIAlertController* tips = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已成功发布" preferredStyle:UIAlertControllerStyleAlert];
    [tips addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil]; //点击“确定”后的操作：让当前提示框消失
    }]];
    [self presentViewController:tips animated:YES completion:nil]; //弹出tips提示框
}

- (void)noDownload:(UIButton*)button {
    if (button.tag == 201) {
        UIImage *image = [UIImage imageNamed:@"download.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.tag = 1;
        button.tag = 202;
        imageView.frame = CGRectMake(5, 12.5, 15, 15);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;
        [button addSubview:imageView];
        button.layer.borderWidth = 5;
    } else {
        for (UIImageView *view in button.subviews) {
            if (view.tag == 1) {
                [view removeFromSuperview];
            }
        }
//        [button.subviews[0] removeFromSuperview];//button的第一个子视图往往是它自己
        //所以这里如果要正确实现，我们应该删掉的是下表为1的子视图
        
        button.tag = 201;
    }
}

- (void)pressButton:(UIButton*)button {
    if (button.tag > 100) {
        button.backgroundColor = _goodColor;
        button.tag -=10;
        button.tintColor = [UIColor whiteColor];
    } else {
        button.backgroundColor = [UIColor whiteColor];
        button.tag += 10;
        button.tintColor = [UIColor blackColor];
    }
}

//PhotoWallViewController的<PhotoWallDelegate>协议函数
- (void)changePhoto:(NSMutableArray *)imageArray {
    //全局的UILabel，进来就判断其tag值，为1就清除
    if (_quantity.tag == 1) {
        [_quantity removeFromSuperview];
    }

    //改头像
    UIButton* button = imageArray[0];
    NSString* imageName = [[NSString alloc] initWithFormat:@"upload%ld.png", button.tag - 1];
    NSInteger sum = imageArray.count;
    [_photoButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    //加个数
    NSString* number = [[NSString alloc] initWithFormat:@"%ld", sum];
    _quantity = [[UILabel alloc] init];
    _quantity.text = number;
    _quantity.textColor = [UIColor redColor];
    _quantity.tag = 1;
    _quantity.frame = CGRectMake(190, 3, 18, 18);
    [_photoButton addSubview:_quantity];
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
