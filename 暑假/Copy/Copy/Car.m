//
//  Car.m
//  Copy
//
//  Created by chenglin on 2024/8/2.
//

#import "Car.h"

@implementation Car

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
