//
//  ViewController.h
//  FoldCell
//
//  Created by chenglin on 2023/12/15.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITableView *tableView;
@property BOOL openClose;
@property (nonatomic, strong) NSMutableArray *array;


@end

