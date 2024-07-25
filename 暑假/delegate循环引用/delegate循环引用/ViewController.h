//
//  ViewController.h
//  delegate循环引用
//
//  Created by chenglin on 2024/7/23.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) CustomView *customView;

@end

