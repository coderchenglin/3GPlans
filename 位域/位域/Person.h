//
//  Person.h
//  位域
//
//  Created by chenglin on 2024/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    // 位域
    struct {
        char tall : 1;
        char rich : 1;
        char handsome : 1;
    } _tallRichHandsome;
}

- (void)setTall:(BOOL)tall;
- (BOOL)isTall;

- (void)setRich:(BOOL)rich;
- (BOOL)isRich;

- (void)setHandsome:(BOOL)handsome;
- (BOOL)isHandsome;
@end

NS_ASSUME_NONNULL_END
