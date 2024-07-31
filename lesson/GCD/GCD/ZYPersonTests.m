//
//  ZYPersonTests.m
//  GCD
//
//  Created by chenglin on 2024/7/26.
//

#import "ZYPersonTests.h"

//#import <XCTest/XCTest.h>
#import "ZYPerson.h"

@implementation ZYPersonTests

- (void)testReadAndWrite {
    ZYPerson *person = [[ZYPerson alloc] init];

    // 读3次
    [self readNameOnce:person];
    [self readNameOnce:person];
    [self readNameOnce:person];

    // 写1次
    [self writeName:person newName:@"John"];

    // 再读3次
    [self readNameOnce:person];
    [self readNameOnce:person];
    [self readNameOnce:person];
}

- (void)readNameOnce:(ZYPerson *)person {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *name = person.name;
        NSLog(@"Read name: %@, current thread: %@", name, [NSThread currentThread]);
    });
}

- (void)writeName:(ZYPerson *)person newName:(NSString *)newName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [person setName:newName];
        NSLog(@"Write name: %@, current thread: %@", newName, [NSThread currentThread]);
    });
}

@end


