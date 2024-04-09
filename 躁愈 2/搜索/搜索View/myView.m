//
//  myView.m
//  new
//
//  Created by mac on 2024/2/23.
//

#import "myView.h"

@implementation myView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // 创建 UISearchBar 对象
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, 320, 44)];
    searchBar.placeholder = @"Search";
    searchBar.barTintColor = [UIColor whiteColor]; // 设置背景色
    searchBar.layer.cornerRadius = 10; // 设置圆角
    searchBar.layer.borderWidth = 1; // 设置边框宽度
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.cancelButton.frame = CGRectMake(335, 0, 50, 44);
    
    // 将搜索栏添加到视图中
    [self addSubview:searchBar];
    [self addSubview:self.cancelButton];
    
    return self;
}

@end
