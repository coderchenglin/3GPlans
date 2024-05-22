//
//  main.m
//  Catagory
//
//  Created by chenglin on 2024/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+Reverse.h"

#import "Person.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//        NSString *originalString = @"Hello, Objective-C!";
//        NSString *reversedString = [originalString reverseString];
//        NSLog(@"Original String: %@", originalString);
//        NSLog(@"Reversed String: %@", reversedString);
        
        Person *person = [[Person alloc] initWithName:@"Alice" age:30];
        [person printGreeting];
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
