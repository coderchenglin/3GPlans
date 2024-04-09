//
//  SecondViewController.m
//  情绪卡片
//
//  Created by 夏楠 on 2024/3/29.
//

#import "SecondEmoCardViewController.h"
#import "Masonry.h"
@interface SecondEmoCardViewController ()

@end

@implementation SecondEmoCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedButtons = [[NSMutableArray alloc] init];
    self.selectedButtonsNames = [[NSMutableArray alloc] init];
    self.selectedButtonsImages = [[NSMutableArray alloc] init];

    [self setupTitle];
    
    // 添加中间的活动图标
    [self setupActivityIcons];
    
    [self setupBottomFunctionButtons];
    
    [self setTextView];
    
    [self setBackBtn];
    }

- (void)setBackBtn {
#pragma mark 返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"fanhui_zhihu.png"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@65);
        make.left.equalTo(@20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
}
- (void)pressBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupTitle {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    titleLabel.text = @"你这一阵子都在忙什么？";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
}

- (void)setupActivityIcons {
    // 定义每行的图标数量和间距
    int iconsPerRow = 4;
    CGFloat iconSize = 60.0;
    CGFloat padding = (self.view.frame.size.width - (iconSize * iconsPerRow)) / (iconsPerRow + 1);
    CGFloat startY = 140.0;
    
    
    _iconNamesFirst = @[@"jiating.png", @"pengyou.png", @"yuehui.png", @"shangzhiduanlian.png", @"yundong.png", @"zaoshui.png", @"chidejiankang.png", @"xiuxi.png", @"dianying.png", @"yuedu.png", @"youxi.png", @"dasao.png"];
    _iconNamesSecond = @[@"jiating2.png", @"pengyou2.png", @"yuehui2.png", @"shangzhiduanlian2.png", @"yundong2.png", @"zaoshui2.png", @"chidejiankang2.png", @"xiuxi2.png", @"dianying2.png", @"yuedu2.png", @"youxi2.png", @"dasao2.png"];
    
    _iconTextNames = @[@"家庭", @"见朋友", @"约会", @"锻炼", @"运动", @"早睡", @"吃得健康", @"休息", @"电影", @"阅读", @"玩游戏", @"打扫"];
    
    for (int i = 0; i < _iconNamesFirst.count; i++) {
        int row = i / iconsPerRow;
        int col = i % iconsPerRow;
        UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeSystem];
        iconButton.frame = CGRectMake(padding + (iconSize + padding) * col, startY + (iconSize + padding) * row, iconSize, iconSize);
        iconButton.layer.masksToBounds = YES;
        iconButton.layer.borderWidth = 2.0;
        iconButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iconButton.tag = i;
        
        UILabel *iconText = [[UILabel alloc] init];
        iconText.text = _iconTextNames[i];
        iconText.frame = CGRectMake(padding + (iconSize + padding) * col, startY + (iconSize + padding) * row + 60, iconSize, 30);
        iconText.font = [UIFont systemFontOfSize:14];
        iconText.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:iconText];
        [iconButton addTarget:self action:@selector(iconButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        
        // 加载图片并设置为始终使用原始颜色渲染
        UIImage *image = [[UIImage imageNamed:_iconNamesSecond[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // 设置按钮的图片内容模式
        iconButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // 添加图片到按钮，并为图片设置边距
        [iconButton setImage:image forState:UIControlStateNormal];
        
        // 计算图片边距
        CGFloat insetAmount = (iconSize - (iconSize * 0.6)) / 2; // 缩小至70%原始尺寸
        iconButton.imageEdgeInsets = UIEdgeInsetsMake(insetAmount, insetAmount, insetAmount, insetAmount);
        
        iconButton.layer.cornerRadius = iconSize / 2;
        iconButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:iconButton];
    }

}

#pragma mark 点按钮变颜色
- (void)iconButtonPressed:(UIButton *)sender {
    // 检查按钮是否已被选中
    if ([self.selectedButtons containsObject:sender]) {
        // 如果已经被选中，则改变为未选中状态
        sender.backgroundColor = [UIColor whiteColor];
        [sender setImage:[[UIImage imageNamed:_iconNamesSecond[sender.tag]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.selectedButtons removeObject:sender];
        [self.selectedButtonsNames removeObject:_iconTextNames[sender.tag]];
        [self.selectedButtonsImages removeObject:_iconNamesSecond[sender.tag]];

    } else {
        // 如果未被选中，则改变为选中状态
        sender.backgroundColor = [UIColor systemGreenColor];
        [sender setImage:[[UIImage imageNamed:_iconNamesFirst[sender.tag]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.selectedButtons addObject:sender];
        [self.selectedButtonsNames addObject:_iconTextNames[sender.tag]];
        [self.selectedButtonsImages addObject:_iconNamesSecond[sender.tag]];
    }
    NSLog(@"%@", self.selectedButtonsNames);
    NSLog(@"%@", self.selectedButtonsImages);

}

- (UIButton *)createBottomButtonWithTitle:(NSString *)title atPosition:(int)position {
    CGFloat buttonWidth = self.view.frame.size.width / 3;
    CGFloat buttonHeight = 50.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonWidth * position, self.view.frame.size.height - buttonHeight - 30, buttonWidth, buttonHeight);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}

- (void)setupBottomFunctionButtons {
    // 创建底部的大按钮
    UIButton *saveButton = [self createFunctionButtonWithTitle:@"保存"];
    saveButton.frame = CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height - 120, 80, 80);
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = saveButton.frame.size.width / 2;
    [saveButton addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
}

- (void)saveBtn {
    // 第三个视图控制器的 .m 文件中
    NSDictionary *userInfo = @{
        @"emojiName": _emojyName,
        @"emojiImage": _emojyImage,
        @"buttonNames": self.selectedButtonsNames,
        @"buttonImages": self.selectedButtonsImages,
        @"moodText": self.noteTextView.text
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ThirdViewControllerDidFinishNotification"
                                                        object:self
                                                      userInfo:userInfo];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", _emojyName);
    NSLog(@"%@", _emojyImage);
    NSLog(@"%@", self.selectedButtonsNames);
    NSLog(@"%@", self.selectedButtonsImages);
}

- (UIButton *)createFunctionButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 2.0;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    return button;
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor darkGrayColor];
    button.layer.cornerRadius = 25;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)setTextView {
    UIButton *quickNoteButton = [self createButtonWithTitle:@"快速笔记" selector:nil];
    quickNoteButton.frame = CGRectMake(20, 410, 100, 50);
    [self.view addSubview:quickNoteButton];
    
    self.noteTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, 470, self.view.frame.size.width - 40, 250)];
    self.noteTextView.backgroundColor = [UIColor whiteColor];
    self.noteTextView.textColor = [UIColor blackColor];
    self.noteTextView.font = [UIFont systemFontOfSize:16];
    self.noteTextView.placeholder = @"请记录一下你的今天";
    _noteTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    // 设置文本视图边框以便更清晰地显示
    self.noteTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.noteTextView.layer.borderWidth = 1.0f;
    self.noteTextView.layer.cornerRadius = 5.0f;
    self.noteTextView.layer.masksToBounds = YES;
    self.noteTextView.layer.cornerRadius = 10;
    
    // 如果需要，可以设置代理来响应键盘事件
    // self.noteTextView.delegate = self;
    
    // 添加文本视图到当前视图控制器的视图中
    [self.view addSubview:self.noteTextView];
}

@end
