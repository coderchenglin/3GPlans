//
//  ARPet.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARPet : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger unlockPoints;
@property (nonatomic, assign) BOOL isUnlocked;
@end

NS_ASSUME_NONNULL_END
