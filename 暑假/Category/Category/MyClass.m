//
//  MyClass.m
//  Category
//
//  Created by chenglin on 2024/7/23.
//

#import "MyClass.h"

#import "MyClass+Extension.h"


@implementation MyClass

- (void)extensionMethod {
    NSLog(@"%s", __func__);
}

@end
