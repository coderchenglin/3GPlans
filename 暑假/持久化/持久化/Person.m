//
//  Person.m
//  持久化
//
//  Created by chenglin on 2024/7/31.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeDouble:self.weight forKey:@"weight"];
    [coder encodeObject:self.dog forKey:@"dog"];
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntForKey:@"age"];
        self.weight = [coder decodeDoubleForKey:@"weight"];
        self.dog = [coder decodeObjectForKey:@"dog"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end


