//
//  ViewController.m
//  FoldCell
//
//  Created by chenglin on 2023/12/15.
//

#import "ViewController.h"
#import "LabelTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self creatView];
}

- (void)creatView {
    self.openClose = 0;
    
    self.array = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"点击展开" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.frame = CGRectMake(50, 200, 300, 50);
    self.button.titleLabel.font = [UIFont systemFontOfSize:28];
    self.button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(50, 300, 300, 50);
    [self.tableView registerClass:[LabelTableViewCell class] forCellReuseIdentifier:@"show"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
    cell.showLabel.text = self.array[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.openClose == 0) {
        return 1;
    } else {
        return self.array.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)pressButton:(UIButton *)button {
    if (self.openClose == 0) {
        self.tableView.frame = CGRectMake(50, 300, 300, 50 * self.array.count);
        [self.button setTitle:@"点击收缩" forState:UIControlStateNormal];
        self.openClose = !self.openClose;
    } else {
        self.tableView.frame = CGRectMake(50, 300, 300, 50);
        [self.button setTitle:@"点击展开" forState:UIControlStateNormal];
        self.openClose = !self.openClose;
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tmp = self.array[0];
    if (self.openClose == 1) {
        [self.array replaceObjectAtIndex:0 withObject:self.array[indexPath.row]];
        [self.array removeObjectAtIndex:indexPath.row];
        [self.array insertObject:tmp atIndex:1];
        self.tableView.frame = CGRectMake(50, 300, 300, 50);
        [self.button setTitle:@"点击展开" forState:UIControlStateNormal];
        self.openClose = !self.openClose;
        [self.tableView reloadData];
    }
}

@end
