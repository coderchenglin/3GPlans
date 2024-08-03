//
//  DDPerson.m
//  Copy
//
//  Created by chenglin on 2024/8/2.
//

#import "DDPerson.h"

@implementation DDPerson

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeObject:self.car forKey:@"car"];
    [coder encodeObject:self.cars forKey:@"cars"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self.age = [coder decodeIntForKey:@"age"];
    self.car = [coder decodeObjectForKey:@"car"];
    self.cars = [coder decodeObjectForKey:@"cars"];
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
