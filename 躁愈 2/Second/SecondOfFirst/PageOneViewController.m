//
//  PageOneViewController.m
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import "PageOneViewController.h"
#import "PageOneView.h"
#import "SecondModel.h"
#import "ScrollerTableViewCell.h"
#import "SecondOfFirstTableViewCell.h"
#import "SecondOfSecondTableViewCell.h"
#import "SecondOfThirdTableViewCell.h"
#import "ChaosViewController.h"
extern UIColor *colorOfBack;
@interface PageOneViewController ()

@end

@implementation PageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.secondView = [[PageOneView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_secondView];
    [self registeTableViewCell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(article:) name:@"article" object:nil];

}

- (void)article:(NSNotification *)send {
    ChaosViewController *chaosViewController = [[ChaosViewController alloc] init];
    NSString *url = send.userInfo[@"key"];
    chaosViewController.uRL = url;
    [self presentViewController:chaosViewController animated:YES completion:nil];

}

- (void)registeTableViewCell {
    self.secondView.tableView.dataSource = self;
    self.secondView.tableView.delegate = self;
    [self.secondView.tableView registerClass:[ScrollerTableViewCell class] forCellReuseIdentifier:@"scrollerTableViewCell"];
    [self.secondView.tableView registerClass:[SecondOfFirstTableViewCell class] forCellReuseIdentifier:@"secondOfFirstTableViewCell"];
    [self.secondView.tableView registerClass:[SecondOfSecondTableViewCell class] forCellReuseIdentifier:@"secondOfSecondTableViewCell"];
    [self.secondView.tableView registerClass:[SecondOfThirdTableViewCell class] forCellReuseIdentifier:@"secondOfThirdTableViewCell"];
}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 225;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScrollerTableViewCell *cell = [self.secondView.tableView dequeueReusableCellWithIdentifier:@"scrollerTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = colorOfBack;
        return cell;
    } else if (indexPath.section == 1){
        SecondOfFirstTableViewCell *cell = [self.secondView.tableView dequeueReusableCellWithIdentifier:@"secondOfFirstTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"晚安电台";
        cell.seeLabel.text = @"See All";
        return cell;
    } else if (indexPath.section == 2) {
        SecondOfSecondTableViewCell *cell = [self.secondView.tableView dequeueReusableCellWithIdentifier:@"secondOfSecondTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"改善睡眠";
        cell.seeLabel.text = @"See All";
        return cell;
    } else if (indexPath.section == 3) {
        SecondOfThirdTableViewCell *cell = [self.secondView.tableView dequeueReusableCellWithIdentifier:@"secondOfThirdTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"提升效能";
        cell.seeLabel.text = @"See All";
        return cell;
    } else {
        return 0;
    }
}




@end
