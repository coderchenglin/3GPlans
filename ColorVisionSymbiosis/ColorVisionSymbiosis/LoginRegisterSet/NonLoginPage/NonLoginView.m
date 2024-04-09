//
//  NonLoginView.m
//  ColorVisionSymbiosis
//
//  Created by chenglin on 2024/2/18.
//

#import "NonLoginView.h"
#import "CircleLayout.h"
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 16

@implementation NonLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self colorArrayInit];
        [self setUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)colorArrayInit {
    UIColor* color1 = [UIColor colorWithRed: 66 / 255.0 green: 49 / 255.0 blue: 252 / 255.0 alpha: 1.0];
    UIColor* color2 = [UIColor colorWithRed: 235 / 255.0 green: 53 / 255.0 blue: 24 / 255.0 alpha: 1.0];
    UIColor* color3 = [UIColor colorWithRed: 130 / 255.0 green: 90 / 255.0 blue: 50 / 255.0 alpha: 1.0];
    UIColor* color4 = [UIColor colorWithRed: 252 / 255.0 green: 187 / 255.0 blue: 19 / 255.0 alpha: 1.0];
    UIColor* color5 = [UIColor blackColor];
    UIColor* color6 = [UIColor colorWithRed: 99 / 255.0 green: 29 / 255.0 blue: 199 / 255.0 alpha: 1.0];
    UIColor* color7 = [UIColor colorWithRed: 0.0 green: 162 / 255.0 blue: 1.0 alpha: 1.0];
    UIColor* color8 = [UIColor colorWithRed: 32 / 255.0 green: 155 / 255.0 blue: 72 / 255.0 alpha: 1.0];
    UIColor* color9 = [UIColor colorWithRed: 244 / 255.0 green: 124 / 255.0 blue: 25 / 255.0 alpha: 1.0];
    self.colorArray = @[color1, color2, color3, color4, color5, color6, color7, color8, color9];
    
}

- (void)setUI {
    self.backgroundColor = [UIColor colorWithRed: 33 / 255.0 green: 33 / 255.0 blue: 33 / 255.0 alpha: 1.0];
    
    //CollectionView
//    CircleLayout* circleLayout = [[CircleLayout alloc] init];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MINIGAP;
    flowLayout.minimumInteritemSpacing = MINIGAP;
    flowLayout.itemSize = CGSizeMake(Screen_WIDTH * 0.21 - MINIGAP * 2 / 3, Screen_WIDTH * 0.21 - MINIGAP * 2 / 3);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, 25, 25) collectionViewLayout: flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: @"CircleCell"];
    [self addSubview: self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.63, Screen_WIDTH * 0.63));
        make.centerY.mas_offset(-MINIGAP * 5);
        make.centerX.mas_equalTo(self);
    }];
    
    //色视共生
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize: 30 weight: UIFontWeightBold];
    self.titleLabel.text = @"色视共生";
    [self addSubview: self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH / 3, MINIGAP * 1.5));
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(MINIGAP * 2);
        make.centerX.mas_equalTo(self);

    }];
    self.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"seshiLabel.png"]];
    [self addSubview: self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH, MINIGAP * 3.9));
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(MINIGAP / 2);
        make.centerX.mas_equalTo(self);
    }];
    
    //LoginButton
    self.loginButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.loginButton.backgroundColor = [UIColor whiteColor];
    [self.loginButton setTitle: @"登录" forState: UIControlStateNormal];
    [self.loginButton setTintColor: [UIColor blackColor]];
    self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize: 23];
    self.loginButton.backgroundColor = [UIColor whiteColor];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 7.0;
    self.loginButton.layer.borderWidth = 0;
    [self addSubview: self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.66, MINIGAP * 2));
        make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset(MINIGAP * 3);
        make.centerX.mas_equalTo(self);
    }];
    [self.loginButton addTarget:self action:@selector(pressLogin) forControlEvents: UIControlEventTouchUpInside];
    
    //RegisterButton
    self.registerButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.registerButton setTitle: @"注册" forState: UIControlStateNormal];
    [self.registerButton setTintColor: [UIColor whiteColor]];
    self.registerButton.titleLabel.font = [UIFont boldSystemFontOfSize: 23];
    self.registerButton.backgroundColor = [UIColor clearColor];
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 7.0;
    self.registerButton.layer.borderWidth = 2.0;
    self.registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview: self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_WIDTH * 0.66, MINIGAP * 2));
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(MINIGAP);
        make.centerX.mas_equalTo(self);
    }];
    [self.registerButton addTarget: self action: @selector(pressRegister) forControlEvents: UIControlEventTouchUpInside];

    //验证码登录
    self.loginByCodeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.loginByCodeButton setTitle: @"验证码登录" forState: UIControlStateNormal];
    [self.loginByCodeButton setTitleColor: [UIColor colorWithRed: 106 / 255.0 green: 183 / 255.0 blue: 250 / 255.0 alpha: 1.0] forState: UIControlStateNormal];
    self.loginByCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize: 13];
    [self addSubview: self.loginByCodeButton];
    [self.loginByCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerButton.mas_bottom).mas_offset(MINIGAP / 3);
        make.left.mas_equalTo(self.collectionView);
    }];
    [self.loginByCodeButton addTarget: self action: @selector(pressLoginByCode) forControlEvents: UIControlEventTouchUpInside];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* circleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CircleCell" forIndexPath: indexPath];
    
    if (indexPath.item == 4) {
        UIImageView* eyeIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"eye.png"]];
        NSInteger along = Screen_WIDTH * 0.21 - MINIGAP * 2 / 3;
        eyeIcon.frame = CGRectMake(along / 6, along / 6, Screen_WIDTH * 0.14 - MINIGAP * 4 / 9, Screen_WIDTH * 0.14 - MINIGAP * 4 / 9);
        [circleCell.contentView addSubview: eyeIcon];
    }
    
    circleCell.layer.masksToBounds = YES;
    circleCell.layer.borderWidth = 2.0;
    circleCell.layer.borderColor = [UIColor blackColor].CGColor;
    circleCell.backgroundColor = self.colorArray[indexPath.item];
    
    return circleCell;
}

- (void)pressLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"Login" object: nil];
}

- (void)pressRegister {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"Register" object: nil];
}

- (void)pressLoginByCode {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"LoginByCode" object: nil];
}

@end
