//
//  ViewController.m
//  懒加载
//
//  Created by chenglin on 2024/7/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (UILabel *)t {
    if (!_t) {
        _t = [[UILabel alloc] init];
    }
    return _t;
}

//- (UILabel *)t {
//    return _t;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载网络数据
    self.t = [[UILabel alloc] init];

    
}


@end
