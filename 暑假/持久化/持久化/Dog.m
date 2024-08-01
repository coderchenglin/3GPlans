//
//  Dog.m
//  持久化
//
//  Created by chenglin on 2024/7/31.
//

#import "Dog.h"

@implementation Dog

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"dogName"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"dogName"];
    }
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}


@end
