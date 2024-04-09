//
//  TestModel.h
//  OC_瀑布流
//
//  Created by 优优有车 on 2017/7/11.
//  Copyright © 2017年 优优有车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TestModel : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
