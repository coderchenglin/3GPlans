//
//  User.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import "User.h"
static User *userSington = nil;

@implementation User
+ (instancetype)shareUser {
    if (!userSington) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            userSington = [[User alloc] init];
            userSington.points = 10;
        });
    }
    return userSington;
}
@end
