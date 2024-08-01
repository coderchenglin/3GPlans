//
//  ViewController.m
//  FileManageTest
//
//  Created by chenglin on 2024/7/31.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController () {
    sqlite3* _sqlite;
    
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *const dataBaseName = @"MyFirstDB.sqlite";
    
    //将数据库存到沙盒中的Documents路径
    //获取Documents路径
    NSString *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"%@", sandBoxPath);
    //拼接得到数据库文件地址
    NSString *filePath = [sandBoxPath stringByAppendingPathComponent:dataBaseName];
    
    //打开指定数据库
    NSInteger status = sqlite3_open(filePath.UTF8String, &_sqlite);
    if (status == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        
        //创建表SQL语句
        NSString *SQLString = @"CREATE TABLE IF NOT EXISTS t_Student(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER NOT NULL, SCORE REAL)";
        
        //保存错误信息
        char *errorMsg = NULL;
        NSInteger result = sqlite3_exec(_sqlite, SQLString.UTF8String, NULL, NULL, &errorMsg);
        if (result == SQLITE_OK) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败 -》 errorMessage: %s", errorMsg);
        }

    } else {
        NSLog(@"打开数据库失败");
    }
        
    sqlite3_stmt *stmt = NULL;
    
    
    
    
    
    
}


@end
