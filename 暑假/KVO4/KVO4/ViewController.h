//
//  ViewController.h
//  KVO4
//
//  Created by chenglin on 2024/8/3.
//

#import <UIKit/UIKit.h>
#import "MyArrayManager.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) MyArrayManager *arrayManager;

@property (nonatomic, strong) NSMutableArray *mutableArray;

@end

