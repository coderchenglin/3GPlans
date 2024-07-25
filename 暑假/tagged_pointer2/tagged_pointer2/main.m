//
//  main.m
//  tagged_pointer2
//
//  Created by chenglin on 2024/7/19.
//

#import <Foundation/Foundation.h>

int a = 10;
int b;
int main(int argc, char * argv[]) {
@autoreleasepool {
        static int c = 20;
        static int d;
        int e;
        int f = 20;
        NSString *str = @"123";
        NSObject *obj = [[NSObject alloc] init];
        NSLog(@"\n&a=%p\n&b=%p\n&c=%p\n&d=%p\n&e=%p\n&f=%p\nstr=%p\nobj=%p\n",
        &a, &b, &c, &d, &e, &f, str, obj);
    return 0;
    }
}

&b=0x100008014
&c=0x10000800c
&d=0x100008010
&e=0x16fdff20c
&f=0x16fdff208
str=0x100004030
obj=0x600000004050
