//
//  mineView.m
//  new
//
//  Created by mac on 2024/3/22.
//

#import "mineView.h"
extern UIColor *colorOfBack;
@implementation mineView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    self.backgroundColor = colorOfBack;
    
    self.myImageview = [[UIImageView alloc] init];
    self.myImageview.layer.cornerRadius = 45;
    self.myImageview.layer.masksToBounds = YES;
    self.myImageview.frame = CGRectMake(20, 20, 90, 90);
    self.myImageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"touxiang.jpg"]];
    
    
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"小Bio";
    self.myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:23.0];
    self.myLabel.frame = CGRectMake(120, 20, 120, 25);
    
    
    self.label1 = [[UILabel alloc] init];
    self.label1.frame = CGRectMake(120, 50, 85, 30);
    self.label1.layer.cornerRadius = self.label1.frame.size.height / 2;
    self.label1.layer.masksToBounds = true;
    self.label1.backgroundColor = [UIColor colorWithRed:110/255.0 green:117/255.0 blue:170/255.0 alpha:0.9];
    self.label1.text = @"记录家Lv3";
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"已实名";
    self.label2.frame = CGRectMake(120, 85, 100, 20);
    self.label2.textColor = UIColor.grayColor;
    
    
    [self addSubview: self.myImageview];
    [self addSubview: self.myLabel];
    [self addSubview: self.label1];
    [self addSubview: self.label2];
    
    return self;
}

@end
