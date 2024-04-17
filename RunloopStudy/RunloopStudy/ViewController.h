//
//  ViewController.h
//  RunloopStudy
//
//  Created by chenglin on 2024/4/15.
//

#import <UIKit/UIKit.h>
#import "HLThread.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HLThread *subThread;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

