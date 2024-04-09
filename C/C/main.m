//
//  main.m
//  C
//
//  Created by chenglin on 2024/3/29.
//

#import <Foundation/Foundation.h>

//int main(int argc, const char * argv[]) {
//
//    for (unsigned int i = 3; i >= 0; i--) {
//        putchar('=');
//    }
//
//    return 0;
//}


#include "stdio.h"
#define MAX(A,B) A > B ? A : B
#define max(a,b) ((a) > (b)) ? (a) : (b))
int main(int argc, const char * argv[]) {
    int x = 12, y = 10;
    int z = 15;
    printf("MAX = %d\n", MAX(MAX(x, y), MAX(MAX(y,z), MAX(z,x)))); //12
    printf("MAX = %d\n", MAX(x, MAX(MAX(y,z), MAX(z,x))));
    printf("MAX = %d\n", MAX(x > y ? x : y, MAX(y > z ? y : z, z > x ? z : x)));
    printf("max = %d\n", max(x++, y++);  //13
    printf("x = %d, y = %d\n", x, y);  //x=14,y=11
    return 0;
}
