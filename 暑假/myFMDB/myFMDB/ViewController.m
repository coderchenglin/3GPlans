//
//  ViewController.m
//  myFMDB
//
//  Created by chenglin on 2024/7/31.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataBase = [FMDatabase databaseWithPath:@"/Users/chenglin/Desktop/3GPlans/暑假/myFMDB/fmDb.sqlite"];
    if (![_dataBase open]) {
        NSLog(@"打开数据库失败！");
    } else {
        NSLog(@"%@", _dataBase.databasePath);
    }
    
    //[_dataBase close];
    
    BOOL result = [_dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Student(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER NOT NULL, SCORE REAL)"];
    
    if (result) {
        NSLog(@"创建成功");
        
        for (int i = 0; i < 10; i++) {
            NSString *name = [NSString stringWithFormat:@"jaxon-%d", arc4random_uniform(100)];
            
            [_dataBase executeUpdate:@"INSERT INTO t_student (name, age) VALUES(?, ?)", name, @(arc4random_uniform(40))];
        }
    } else {
        NSLog(@"创表失败");
    }
    
    FMResultSet* resultSet = [_dataBase executeQuery: @"SELECT * FROM t_student"];
    
    //    遍历结果集
    while ([resultSet next]) {
        int ID = [resultSet intForColumn: @"ID"];
        NSString* name = [resultSet stringForColumn: @"NAME"];
        int age = [resultSet intForColumn: @"AGE"];
        NSLog(@"%d %@ %d", ID, name, age);
    }
    
    NSString* sql = @"INSERT INTO t_student (name, age) VALUES (?, ?)";
    [_dataBase executeUpdate: sql, @(arc4random_uniform(40))];
    
    NSString* path = NSHomeDirectory();
    NSLog(@"%@", path);
    
    NSString* path2 = [[NSBundle mainBundle] bundlePath];
    NSLog(@"%@", path2);
    
    
}




@end
