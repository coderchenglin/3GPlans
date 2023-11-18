//
//  ViewController.h
//  weather_forecast
//
//  Created by chenglin on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import "FirstTableViewCell.h"
#import "AddViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, AddViewControllerDelegte>
@property UITableView *tableView;


@end

