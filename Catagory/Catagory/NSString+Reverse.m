//
//  NSString+Reverse.m
//  Catagory
//
//  Created by chenglin on 2024/5/20.
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)

- (NSString *)reverseString {
    NSInteger length = [self length];
    unichar *buffer = malloc(length * sizeof(unichar));
    
    if (buffer == NULL)
        return nil;
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    for (NSUInteger i = 0; i < length / 2; i++) {
        unichar temp = buffer[i];
        buffer[i] = buffer[length - i - 1];
        buffer[length - i - 1] = temp;
    }
    
    NSString *result = [NSString stringWithCharacters:buffer length:length];
    free(buffer);
    
    return result;
}


@end
