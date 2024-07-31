//
//  BaseDemo.h
//  线程安全
//
//  Created by chenglin on 2024/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject

- (void)moneyTest;
- (void)ticketTest;

#pragma mark - 暴露给子类去使用
- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTicket;

@end

NS_ASSUME_NONNULL_END
