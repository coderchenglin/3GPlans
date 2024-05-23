//
//  ViewController.m
//  KVO
//
//  Created by chenglin on 2024/5/22.
//

#import "ViewController.h"
#import "MJPerson.h"

@interface ViewController ()
@property (nonatomic, strong) MJPerson *person;
 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[MJPerson alloc] init];
    self.person.age = 10;
    // Do any additional setup after loading the view.
    NSKeyValueObservingOptions *options =NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.age = 20;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //NSLog(@"111");
    NSLog(@"监听到%@的%@属性值改变了 - %@", object, keyPath, change);
    //
    //    监听到<MJPerson: 0x600000f2c840>的age属性值改变了 - {
    //    kind = 1;
    //    new = 20;
    //    old = 10;
    //    }
}

//kind:
//NSKeyValueChangeSetting = 1：表示属性值被设置了新值（包括初始化）。
//NSKeyValueChangeInsertion = 2：表示元素被插入到一个集合属性（如数组）中。
//NSKeyValueChangeRemoval = 3：表示元素从一个集合属性中被移除。
//NSKeyValueChangeReplacement = 4：表示一个集合属性中的元素被替换。

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"]; //给age属性移除self这个监听器
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
