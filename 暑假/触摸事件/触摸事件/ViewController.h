//
//  ViewController.h
//  触摸事件
//
//  Created by chenglin on 2024/8/11.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIView *backView; // 与手势绑定的底部视图
@property (nonatomic, strong) IBOutlet UITableView *tableMain; // 常规的表格视图
@property (nonatomic, strong) IBOutlet UIButton *button; // 和 tableView 同级的按钮

@end

