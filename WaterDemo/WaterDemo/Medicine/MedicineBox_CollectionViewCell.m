//
//  MedicineBox_CollectionViewCell.m
//  WaterDemo
//
//  Created by chenglin on 2024/4/6.
//

#import "MedicineBox_CollectionViewCell.h"
#import "Masonry.h"

@implementation MedicineBox_CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame] ;
    if (self) {
        //初始化头视图
        UIView* view = [[UIView alloc] init] ;
        view.backgroundColor = UIColor.whiteColor ;
        [self.contentView addSubview:view] ;
        view.layer.cornerRadius = 8.0 ;
        view.layer.masksToBounds = YES ;
        view.layer.borderWidth = 2.0 ;
        view.layer.borderColor = UIColor.lightGrayColor.CGColor ;
        //布局
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0) ;
            make.left.mas_offset(0) ;
            make.height.mas_equalTo (50) ;
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 2 - 40) ;
        }] ;
        
        //初始化头标题
        self.namelabel = [[UILabel alloc] init] ;
//        self.namelabel.text = @"药箱" ;
        self.namelabel.textAlignment = NSTextAlignmentLeft ;
        self.namelabel.textColor = UIColor.blackColor ;
        [self.contentView addSubview:self.namelabel] ;
        //标题布局
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(3) ;
            make.left.mas_offset(10) ;
            make.height.mas_equalTo(40) ;
            make.width.mas_equalTo(100) ;
        }] ;
        
        //初始化药瓶添加按钮
        self.addbutton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [self.addbutton setBackgroundImage:[UIImage imageNamed:@"addition.png"] forState:UIControlStateNormal] ;
        self.addbutton.layer.cornerRadius = self.addbutton.frame.size.width / 2 ;
        self.addbutton.layer.masksToBounds = YES ;
        self.addbutton.layer.borderWidth = 2.0 ;
        self.addbutton.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor) ;
        [self.contentView addSubview:self.addbutton] ;
        
        //按钮布局
        [self.addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8) ;
            make.left.mas_offset(110) ;
            make.height.mas_equalTo(30) ;
            make.width.mas_equalTo(30) ;
        }] ;
        
        //初始化药箱信息按钮
        self.addbutton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [self.addbutton setBackgroundImage:[UIImage imageNamed:@"tishi_o.png"] forState:UIControlStateNormal] ;
        self.addbutton.layer.cornerRadius = self.addbutton.frame.size.width / 2 ;
        self.addbutton.layer.masksToBounds = YES ;
        self.addbutton.layer.borderWidth = 2.0 ;
        self.addbutton.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor) ;
        [self.contentView addSubview:self.addbutton] ;
        
        //按钮布局
        [self.addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8) ;
            make.left.mas_offset(80) ;
            make.height.mas_equalTo(30) ;
            make.width.mas_equalTo(30) ;
        }] ;
        
    }
    return self;
}




@end
