//
//  main.m
//  test
//
//  Created by chenglin on 2024/5/7.
//

#import <Foundation/Foundation.h>
#import "NSNumber+fk.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSNumber* a = [NSNumber numberWithInt: 3];
        //测试jia:方法
        NSNumber* jia = [a jia: 3.14];
        NSLog(@"%@", jia);
        //测试jian:方法
        NSNumber* jian = [a jian: 1.1];
        NSLog(@"%@", jian);
        //测试cheng:方法
        NSNumber* cheng = [a cheng: 1.1];
        NSLog(@"%@", cheng);
        //测试chu:方法
        NSNumber* chu = [a chu: 2.0];
        NSLog(@"%@", chu);
    }
    return 0;
}
