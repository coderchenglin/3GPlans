//
//  LoginView.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "LoginView.h"
#import "Masonry.h"
#import "CircleButtonModel.h"
#import "CircleButton.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 16

#define XSV(_x_)  ((_x_) * ([[UIScreen mainScreen] bounds].size.width * 1.0 / 375.0))
static const CGFloat kLargeButtonWidth = 114;
static const CGFloat kBigButtonWidth = 94;
static const CGFloat kMidButtonWidth = 84;
static const CGFloat kSmallButtonWidth = 66;
static const CGFloat kLitButtonWidth = 56;
static const int kMaxLevel = 3;

@interface LoginView () {
    CGFloat radiusArray[4];     //圆形轨道半径数组
    CGSize  buttonSizeArray[5]; //圆形按钮宽度取值数组
}

/*! @brief button数组 */
@property(nonatomic, strong) NSArray *buttonsArray;
/*! @brief 圆心中点 */
@property(nonatomic, assign) CGPoint center;
/*! @brief 最大的层级 */
@property(nonatomic, assign) int maxLevel;
/*! @brief 当前的层级 */
@property(nonatomic, assign) int currentLevel;

@end

@implementation LoginView

@synthesize  center = _center;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    //漂浮球
    self.backgroundColor = [UIColor colorWithRed: 33 / 255.0 green: 33 / 255.0 blue: 33 / 255.0 alpha: 1.0];
    self.circleView = [[UIView alloc] initWithFrame: CGRectMake(0, MINIGAP, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 3.5)];
    self.circleView.backgroundColor = [UIColor clearColor];
    [self addSubview: self.circleView];
    [self initDatas];
    [self initCircleButtons];
    
    //背景
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = Screen_WIDTH / 8;
    [self addSubview: self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self).multipliedBy(2);
        make.top.mas_equalTo(self.circleView.mas_bottom).mas_offset(MINIGAP / 1.5);
    }];
    
    //title
    self.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"loginLabel.png"]];
    [self.whiteView addSubview: self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH / 1.75, MINIGAP * 2.25));
        make.top.mas_equalTo(self.whiteView).mas_offset(MINIGAP * 1.25);
        make.centerX.mas_equalTo(self);
    }];
    
    //手机框
    self.phoneField = [[UITextField alloc] init];
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneField.layer.shadowOpacity = 0.2; //透明度
    self.phoneField.layer.cornerRadius = 7.0;
    self.phoneField.layer.shadowOffset = CGSizeMake(0, 0);
    [self addSubview: self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.76, MINIGAP * 2.2));
        make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset(MINIGAP * 2.5);
        make.centerX.mas_equalTo(self);
    }];
    self.phoneField.delegate = self;
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField.clearButtonMode = UITextFieldViewModeAlways; //这个属性通常用于 UITextField 类（文本输入框）中，用于控制清除按钮的显示模式。
    
//    self.phoneField.autocorrectionType = UITextAutocorrectionTypeNo;
//    UIView *spacerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, 10)];
//    [textfield setLeftViewMode: UITextFieldViewModeAlways];
//    [textfield setLeftView: spacerView];
//    self.phoneField.contextMenuInteractionEnabled = NO;
    
    //密码框
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.layer.shadowOpacity = 0.2; //透明度
    self.passwordField.layer.cornerRadius = 7.0;
    self.passwordField.layer.shadowOffset = CGSizeMake(0, 0);
    [self addSubview: self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.76, MINIGAP * 2.2));
        make.top.mas_equalTo(self.phoneField.mas_bottom).mas_offset(MINIGAP * 2);
        make.left.mas_equalTo(self.phoneField);
    }];
    self.passwordField.delegate = self;
    self.passwordField.secureTextEntry = YES; //是否以安全输入的方式显示
    self.passwordField.returnKeyType = UIReturnKeyDone; //用于表示输入完成
    self.passwordField.clearButtonMode = UITextFieldViewModeAlways;
//    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordField.tag = 201;
    
    //确认登录
    self.loginButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.loginButton.backgroundColor = [UIColor blackColor];
    [self.loginButton setTitle: @"确认登录" forState: UIControlStateNormal];
    [self.loginButton setTintColor: [UIColor whiteColor]];
    self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize: 23];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 7.0;
    [self addSubview: self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.76, MINIGAP * 2.2));
        make.top.mas_equalTo(self.passwordField.mas_bottom).mas_offset(MINIGAP * 1.5);
        make.centerX.mas_equalTo(self);
    }];
    [self.loginButton addTarget: self action: @selector(confirmLogin) forControlEvents: UIControlEventTouchUpInside];
    
    //手机号
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.text = @"手机号";
    self.phoneLabel.textColor = [UIColor blackColor];
    self.phoneLabel.font = [UIFont boldSystemFontOfSize: 17];
    [self addSubview: self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.phoneField.mas_top).mas_offset(-MINIGAP / 3);
        make.left.mas_equalTo(self.phoneField);
    }];
    
    //密码
    self.passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.text = @"密 码";
    self.passwordLabel.textColor = [UIColor blackColor];
    self.passwordLabel.font = [UIFont boldSystemFontOfSize: 17];
    [self addSubview: self.passwordLabel];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.passwordField.mas_top).mas_offset(-MINIGAP / 3);
        make.left.mas_equalTo(self.phoneField);
    }];
    
    //验证码登录
    self.loginByCodeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.loginByCodeButton setTitle: @"验证码登录" forState: UIControlStateNormal];
    self.loginByCodeButton.tag = 101;
    [self.loginByCodeButton setTitleColor: [UIColor colorWithRed: 106 / 255.0 green: 183 / 255.0 blue: 250 / 255.0 alpha: 1.0] forState: UIControlStateNormal];
    self.loginByCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize: 13];
    [self addSubview:self.loginByCodeButton];
    [self.loginByCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(MINIGAP / 3);
        make.left.mas_equalTo(self.loginButton);
    }];
    [self.loginByCodeButton addTarget: self action: @selector(pressLoginByCode:) forControlEvents: UIControlEventTouchUpInside];
    
    //发送验证码按钮
    self.getCodeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.getCodeButton setTitle: @"获取验证码" forState: UIControlStateNormal];
    [self.getCodeButton setTintColor: [UIColor blackColor]];
    self.getCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    self.getCodeButton.backgroundColor = [UIColor colorWithRed: 218 / 255.0 green: 218 / 255.0 blue: 218 / 255.0 alpha: 1.0];
    self.getCodeButton.layer.cornerRadius = 7.0;
    [self.whiteView addSubview: self.getCodeButton];
    
}

#pragma mark 登录方式

//确认登录
- (void)confirmLogin {
    if (self.passwordField.tag == 201) {
        NSDictionary* loginInfo = @{@"phone" : self.phoneField.text, @"password" : self.passwordField.text};
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ConfirmLogin" object: nil userInfo: loginInfo];
    } else if (self.passwordField.tag == 202) {
        NSDictionary* loginInfo = @{@"phone" : self.phoneField.text, @"code" : self.passwordField.text};
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ConfirmLoginByCode" object: nil userInfo: loginInfo];
    }
}

//通知切换样式
- (void)pressLoginByCode: (UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"WayOfLogin" object: button userInfo: nil];
}

//密码登录样式
- (void)WayOfLoginingByPassword {
    self.passwordLabel.text = @"密 码";
    
    self.passwordField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordField.text = @"";
    self.passwordField.tag = 201;
    [self.passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.76, MINIGAP * 2.2));
    }];
    
    [self.getCodeButton setHidden: YES];
}

//验证码登录样式
- (void)WayOfLoginingByCode {
    self.passwordLabel.text = @"验证码";
    
    self.passwordField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordField.text = @"";
    self.passwordField.tag = 202;
    self.passwordField.secureTextEntry = NO;
    [self.passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.46, MINIGAP * 2.2));
    }];
    
    //验证码按钮
    self.getCodeButton.hidden = NO;
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordField.mas_right).mas_offset(MINIGAP / 3);
        make.right.mas_equalTo(self.phoneField);
        make.height.and.centerY.mas_equalTo(self.passwordField);
    }];
    [self.getCodeButton addTarget: self action: @selector(getCodeAndStartCountdown) forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark 发送验证码

- (void)getCodeAndStartCountdown {
    NSDictionary* phoneByCodeInfo = @{@"phoneByCode" : self.phoneField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName: @"GetCodeAndStartCountdown" object: nil userInfo: phoneByCodeInfo];
}

#pragma mark 输入框逻辑

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

//限制输入长度
//当用户在文本框中输入或删除文本时，系统会调用这个方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString: @"\n"]) return YES;
    
    NSString* toBeString = [textField.text stringByReplacingCharactersInRange: range withString: string];
    if (textField == self.phoneField) {
        //手机号最多16位
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex: 11];
            return NO;
        }
    } else if (textField == self.passwordField) {
        if (textField.tag == 201) {
            //密码不能超过16
            if ([toBeString length] > 16) {
                textField.text = [toBeString substringToIndex: 16];
                return NO;
            }
        } else if (textField.tag == 202) {
            //验证码最多6位
            if ([toBeString length] > 6) {
                textField.text = [toBeString substringToIndex: 6];
                return NO;
            }
        }
    }
    return YES;
}

//防止键盘遮挡
//当文本输入框开始编辑时被调用。
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //iphone键盘高度为216，ipad键盘高度为352
    int offSet = 216.0 + 64;
    [UIView animateWithDuration: 0.5 animations:^{
        self.frame = CGRectMake(0.0f, -offSet, self.frame.size.width, self.frame.size.height);
    }];
    
    textField.layer.borderColor = [UIColor colorWithRed: 106 / 255.0 green: 183 / 255.0 blue: 250 / 255.0 alpha: 1.0].CGColor;
    textField.layer.borderWidth = 2.0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration: 0.5 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
    textField.layer.borderWidth = 0.0;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
////    if (action == @selector(paste:)) return NO;
////    if (action == @selector(select:)) return NO;
////    if (action == @selector(selectAll:)) return NO;
////
////    return [super canPerformAction: action withSender: sender];
//    return NO;
//}





#pragma mark 漂浮球

- (void)initDatas{
    //最大的层数
    self.maxLevel = kMaxLevel;
    //1.根据self.view初始化圆心中点
    self.center = CGPointMake(CGRectGetWidth(self.circleView.frame) * 0.5, CGRectGetHeight(self.circleView.frame) * 0.5);
    //2.初始化圆形按钮半径数组
    CGFloat width[5] = {XSV(kLargeButtonWidth), XSV(kBigButtonWidth), XSV(kMidButtonWidth), XSV(kSmallButtonWidth), XSV(kLitButtonWidth)};
    for (int i = 0 ; i < 5; i++) {
        buttonSizeArray[i] = CGSizeMake(width[i], width[i]);
    }
    //3.初始化圆形轨道圆形半径数组
    radiusArray[0] = 15;
    radiusArray[1] = XSV(kBigButtonWidth);
    radiusArray[2] = XSV(kSmallButtonWidth) * 2 - 5;
    radiusArray[3] = XSV(kSmallButtonWidth) * 3;
}

- (void)initCircleButtons {
    [self addButtonsToArray:[self createButtons]];
}

- (NSArray *)createButtons{
    //一屏球的个数限定最小为7，最大为9, 随机一个数
    NSInteger num = [self getRandomNumber:7 to:9];
    CGPoint center = self.center;
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:num];
    NSMutableArray *circles = [NSMutableArray arrayWithCapacity:num];
    //用来记录第一个球是大球还是中球
    int maxIndex = 0;
    int maxCount[3] = {1, 3, 3};
    int currentCount[3] = {0, 0, 0};
    for (NSInteger j = 0; j < num; j++) {
        //1.处理球的颜色
        CircleButtonModel *circleButtonModel = [CircleButtonModel new];
        [circles addObject:circleButtonModel];
        //1.1随机一个颜色
        int R = (arc4random() % 256);
        int G = (arc4random() % 256);
        int B = (arc4random() % 256);
        UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        circleButtonModel.color = color;
        //2.处理球的大小
        //2.1第一个默认大球，第二个默认中球，之后随机大小
        if (0 == j) {
            circleButtonModel.size = buttonSizeArray[1];
        }else if(1 == j){
            circleButtonModel.size = buttonSizeArray[2];
        }else{
            int sizeIndex = [self getRandomNumber:2 to:4];
            circleButtonModel.size = buttonSizeArray[sizeIndex];
        }
        //2.处理球的位置
        //2.1随机球圆心在圆弧上的一个偏移量
        int offset = [self getRandomNumber:-10 to:10];
        //2.2随机一个角度偏移量
        int angleOffset = [self getRandomNumber:-10 to:10];
        //        offset = 0;
        //            CGPoint newCenter = CGPointMake(center.x - offset, center.y - offset);
        CGPoint newCenter = center;
        if (0 == maxIndex) {
            int angle = [self getRandomNumber:0 to:360];
            circleButtonModel.angle = angle;
            circleButtonModel.center = [self calcCircleCoordinateWithCenter:newCenter andWithAngle:angle andWithRadius:(radiusArray[maxIndex] + offset)];
        }else if(1 == maxIndex){
            if (0 == currentCount[maxIndex]) {
                int angle = [self getRandomNumber:0 to:360];
                circleButtonModel.angle = angle;
                circleButtonModel.center = [self calcCircleCoordinateWithCenter:newCenter andWithAngle:angle andWithRadius:(radiusArray[maxIndex] + offset)];
            }else{
                CircleButtonModel *preCircleButtonModel = circles[j - 1];
                int angle = 360 / maxCount[maxIndex] + angleOffset + preCircleButtonModel.angle;
                angle = angle > 360 ? (angle - 360) : angle;
                circleButtonModel.angle = angle;
                circleButtonModel.center = [self calcCircleCoordinateWithCenter:newCenter andWithAngle:angle andWithRadius:(radiusArray[maxIndex] + offset)];
            }
        }else{
            if (0 == currentCount[maxIndex]) {
                int index = (int)(j - maxCount[maxIndex -1]);
                CircleButtonModel *preCircleButtonModel = circles[index];
                int angle = [self getRandomNumber:60 to:90] + preCircleButtonModel.angle;
                angle = angle > 360 ? (angle - 360) : angle;
                circleButtonModel.angle = angle;
                circleButtonModel.center = [self calcCircleCoordinateWithCenter:newCenter andWithAngle:angle andWithRadius:(radiusArray[maxIndex] + offset)];
            }else{
                CircleButtonModel *preCircleButtonModel = circles[j - 1];
                int angle = 360 / maxCount[maxIndex] + angleOffset + preCircleButtonModel.angle;
                angle = angle > 360 ? (angle - 360) : angle;
                circleButtonModel.angle = angle;
                circleButtonModel.center = [self calcCircleCoordinateWithCenter:newCenter andWithAngle:angle andWithRadius:(radiusArray[maxIndex] + offset)];
            }
        }
        int currentNum  = currentCount[maxIndex] + 1;
        if (currentNum >= maxCount[maxIndex]) {
            maxIndex++;
        }else{
            currentCount[maxIndex] = currentNum;
        }
        //4.创建按钮
        CGRect frame = CGRectZero;
        frame.size = circleButtonModel.size;
        CircleButton *button = [[CircleButton alloc] initWithFrame:frame];
        button.backgroundColor = circleButtonModel.color;
        button.center = circleButtonModel.center;
        button.buttonModel = circleButtonModel;
        [buttons addObject:button];
    }
    return [buttons copy];
}

- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

//计算圆圈上点在IOS系统中的坐标
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius {
    CGFloat x2 = ceilf(radius*cosf(angle*M_PI/180));
    CGFloat y2 = ceilf(radius*sinf(angle*M_PI/180));
    return CGPointMake(center.x+x2, center.y-y2);
}


//动画
- (void)animationScaleOnceWithView:(UIView *)view {
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
        }];
    }];
}

/**
 添加上下漂浮动画
 @param view 要加动画的View
 */
- (void)animationUpDownWithView:(UIView *)view delay:(CGFloat) delayTime {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    uint32_t typeInt = arc4random() % 100;
    CGFloat distanceFloat = 0.0;
    //随机0 - 3之前的一个随机数
    while (distanceFloat == 0) {
        distanceFloat = (3 + (int)(arc4random() % (9 - 7 + 1))) * 100.0 / 101.0;
    }
    //随机上或者下
    if (typeInt % 2 == 0) {
        toPoint = CGPointMake(position.x, position.y - distanceFloat);
    } else {
        toPoint = CGPointMake(position.x, position.y + distanceFloat);
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.beginTime = CACurrentMediaTime() + delayTime; //delayTime作为参数传进来
    animation.removedOnCompletion = NO; //用于指定动画完成后是否从图层上移除。
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //先加速后减速时间函数，动画开始和结束时速度较慢，中间过程加速。
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    //随机动画的总时长1.2 + x / 31
    CGFloat durationFloat = 0.0;
    while (durationFloat == 0.0) {
        durationFloat = 1.2 + (int)(arc4random() % (100 - 70 + 1)) / 31.0;
    }
    [animation setDuration:durationFloat]; //动画持续时间
    //[animation setRepeatCount:MAXFLOAT];
    [animation setRepeatCount:HUGE_VALF];//重复次数为正无穷大
    
    [viewLayer addAnimation:animation forKey:@"upAndDown"];
}

- (void)addButtonsToArray:(NSArray *) buttons{
    NSMutableArray *arrayM;
    if (self.buttonsArray.count > 0) {
        arrayM = [NSMutableArray arrayWithArray:self.buttonsArray];
    }else{
        arrayM = [NSMutableArray arrayWithCapacity:self.maxLevel];
    }
    if (buttons.count > 0) {
        CGFloat delayTime = self.currentLevel == 0 ? 0 : 1.0;
        for (CircleButton *button in buttons) {
            [self.circleView addSubview:button];
            [self animationUpDownWithView:button delay:delayTime];
        }
        [arrayM addObject:buttons];
    }
    self.buttonsArray = [arrayM copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
