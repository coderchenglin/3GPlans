//
//  ViewController.m
//  KVO
//
//  Created by chenglin on 2024/4/21.
//
// ViewController.m



//#import "ViewController.h"
//#import "Person.h"
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    NSArray *strings = @[@"Hello", @"World", @"Objective-C", @"Programming", @"Key-Value Coding"];
//
//    // 使用 valueForKeyPath 和 @sum 操作符计算字符串总长度
//    NSNumber *totalLength = [strings valueForKeyPath:@"@sum.length"];
//
//    NSLog(@"Total length of all strings: %@", totalLength);
//
//
//    NSArray *numbers = @[@10, @20, @30, @40, @50];
//
//    // 使用 @sum 操作符计算数组中数字的总和
//    NSNumber *totalSum = [numbers valueForKeyPath:@"@sum.self"];
//
//    NSLog(@"Total sum of numbers: %@", totalSum);
////    // 创建 Person 对象
////    Person *person = [[Person alloc] init];
////
////    // 使用 KVC 设置属性值
////    [person setValue:@"John" forKey:@"name"];
////    [person setValue:@30 forKey:@"age"];
////
////    // 使用 KVC 获取属性值
////    NSString *name = [person valueForKey:@"name"];
////    NSInteger age = [[person valueForKey:@"age"] integerValue];
////
////    // 打印属性值
////    NSLog(@"Name: %@", name);
////    NSLog(@"Age: %ld", (long)age);
//}


//#import "ViewController.h"
//
//@interface ViewController ()
//
//@property (nonatomic, strong) NSArray *hwcarray;
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.hwcarray = @[@"hello", @"hwc", @"hellohwc"];
//
//    dispatch_apply(3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        NSString *expObject = self.hwcarray[index];
//        NSLog(@"%lu", (unsigned long)expObject.length);
//    });
//
//    NSLog(@"Dispatch_after is over");
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end

//
//#import "ViewController.h"
//
//@interface ViewController ()
//
//@property (nonatomic, strong) dispatch_group_t hwcGroup;
//@property (nonatomic, strong) dispatch_queue_t globalQueueDefault;
//@property (nonatomic, strong) dispatch_queue_t userCreateQueue;
//
//- (void)downLoadTask1WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
//- (void)downLoadTask2WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
//- (void)downLoadTask3WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    self.hwcGroup = dispatch_group_create(); // Create a dispatch group
//    self.globalQueueDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // Global queue (concurrent)
//    self.userCreateQueue = dispatch_queue_create("com.test.helloHwc", DISPATCH_QUEUE_SERIAL); // User-created queue (serial)
//
//    [self downLoadTask1WithGroup:self.hwcGroup queue:self.globalQueueDefault];
//    [self downLoadTask2WithGroup:self.hwcGroup queue:self.userCreateQueue];
//    [self downLoadTask3WithGroup:self.hwcGroup queue:self.userCreateQueue];
//
//    dispatch_group_notify(self.hwcGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"Group tasks are done");
//    });
//
//    NSLog(@"Now viewDidLoad is done");
//}
//
//- (void)downLoadTask1WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue
//{
//    dispatch_group_async(group, queue, ^{
//        sleep(3);
//        NSLog(@"Task1 is done");
//    });
//}
//
//- (void)downLoadTask2WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue
//{
//    dispatch_group_async(group, queue, ^{
//        sleep(3);
//        NSLog(@"Task2 is done");
//    });
//}
//
//- (void)downLoadTask3WithGroup:(dispatch_group_t)group queue:(dispatch_queue_t)queue
//{
//    dispatch_group_async(group, queue, ^{
//        sleep(3);
//        NSLog(@"Task3 is done");
//    });
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//
//@end


//
//#pragma mark runtime - 消息转发
//
//#import "ViewController.h"
//#include "objc/runtime.h"
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
////    [self fun];
//    // 执行 fun 函数
//    [self performSelector:@selector(fun)];
//}
//
//// 重写 resolveInstanceMethod: 添加对象方法实现
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(fun)) { // 如果是执行 fun 函数，就动态解析，指定新的 IMP
//        class_addMethod([self class], sel, (IMP)funMethod, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//void funMethod(id obj, SEL _cmd) {
//    NSLog(@"funMethod"); //新的 fun 函数
//}
//
//@end



//#import "ViewController.h"
//#include "objc/runtime.h"
//#import "Person.h"
//
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 执行 fun 方法
//    [self performSelector:@selector(fun)];
//}
//
//////如果这里实现了，就不会进行消息转发了
////- (void)fun {
////    NSLog(@"ViewController");
////}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES; // 为了进行下一步 消息接受者重定向
//}
//
//// 消息接受者重定向
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(fun)) {
//        return [[Person alloc] init];
//        // 返回 Person 对象，让 Person 对象接收这个消息
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//@end





//
//#import "ViewController.h"
//#include "objc/runtime.h"
//
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
////    [self fun];
//    // 执行 fun 函数
//    [self performSelector:@selector(fun)];
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES; // 为了进行下一步 消息接受者重定向
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return nil; // 为了进行下一步 消息重定向
//}
//
//// 获取函数的参数和返回值类型，返回签名
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"fun"]) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//
//    return [super methodSignatureForSelector:aSelector];
//}
//
//// 消息重定向
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL sel = anInvocation.selector;   // 从 anInvocation 中获取消息
//
//    Person *p = [[Person alloc] init];
//
//    if([p respondsToSelector:sel]) {   // 判断 Person 对象方法是否可以响应 sel
//        [anInvocation invokeWithTarget:p];  // 若可以响应，则将消息转发给其他对象处理
//    } else {
//        [self doesNotRecognizeSelector:sel];  // 若仍然无法响应，则报错：找不到响应方法
//    }
//}
//@end


//
//#pragma mark 方法交换 - Method Swizzling
//
//#import "ViewController.h"
//#import <objc/runtime.h>
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//
//    [self SwizzlingMethod];  // 实现方法交换
//    [self originalFunction];
//    [self swizzledFunction];
//}
//
//
//// 交换 原方法 和 替换方法 的方法实现
//- (void)SwizzlingMethod {
//    // 当前类
//    Class class = [self class];
//
//    // 原方法名 和 替换方法名
//    SEL originalSelector = @selector(originalFunction);
//    SEL swizzledSelector = @selector(swizzledFunction);
//
//    // 原方法结构体 和 替换方法结构体
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//    // 调用交换两个方法的实现
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}
//
//// 原始方法
//- (void)originalFunction {
//    NSLog(@"originalFunction");
//}
//
//// 替换方法
//- (void)swizzledFunction {
//    NSLog(@"swizzledFunction");
//}
//
//@end




//
//#import "ViewController.h"
//#import "Person.h"
//#import <objc/runtime.h>
//
//@interface ViewController ()
//
//
//
//@end
//
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //instacne-isKindOfClass
//    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
//    BOOL res3 = [[Person class] isKindOfClass:[Person class]];
//    BOOL res10 = [[NSString class] isKindOfClass:[NSObject class]];
//
//    NSLog(@"%d %d %d",res1, res3, res10);
//
//
//    Person *person = [[Person alloc] init];
//   //        BOOL res5 = [[Person class] isKindOfClass:[NSObject class]];
//   //        BOOL res6 = [person isKindOfClass:[NSObject class]];
//   //        NSLog(@"%d %d", res5, res6);
//   //
//           //instance-isMemberOfClass
////           BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
////           BOOL res7 = [person isMemberOfClass:[NSObject class]];
////           BOOL res8 = [[Person class] isMemberOfClass:[NSObject class]];
////           BOOL res9 = [person isMemberOfClass:[Person class]];
////           NSLog(@"%d %d %d %d" ,res2, res7, res8, res9);
//
//
//
////    [self printIvarList];
////    [self printPropertyList];
////    [self printMethodList];
////    [self printUITextFieldList];
//
////    [self createLoginTextField];
//
//}
//
//// 打印 UITextfield 的所有属性和成员变量
////- (void)printUITextFieldList {
////    unsigned int count;
////
////    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
////    for (unsigned int i = 0; i < count; i++) {
////        Ivar myIvar = ivarList[i];
////        const char *ivarName = ivar_getName(myIvar);
////        NSLog(@"ivar(%d) : %@", i, [NSString stringWithUTF8String:ivarName]);
////    }
////
////    free(ivarList);
////
////    objc_property_t *propertyList = class_copyPropertyList([UITextField class], &count);
////    for (unsigned int i = 0; i < count; i++) {
////        const char *propertyName = property_getName(propertyList[i]);
////        NSLog(@"propertyName(%d) : %@", i, [NSString stringWithUTF8String:propertyName]);
////    }
////
////    free(propertyList);
////}
//
//// 通过修改 UITextfield 的私有属性更改占位颜色和字体
////- (void)createLoginTextField {
////    UITextField *loginTextField = [[UITextField alloc] init];
////    loginTextField.frame = CGRectMake(15,(self.view.bounds.size.height-52-50)/2, self.view.bounds.size.width-60-18,52);
////    loginTextField.delegate = self;
////    loginTextField.font = [UIFont systemFontOfSize:14];
////    loginTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
////    loginTextField.textColor = [UIColor blackColor];
////
////    loginTextField.placeholder = @"用户名/邮箱";
////    [loginTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
////    [loginTextField setValue:[UIColor lightGrayColor]forKeyPath:@"_placeholderLabel.textColor"];
////
////    [self.view addSubview:loginTextField];
////}
//
//
//
////- (void)printIvarList {
////
////    unsigned int count;
////
////    //打印成员变量列表
////    //Ivar是一个结构体类型，里面存放了：
//////    const char *ivar_name：实例变量的名称。
//////    const char *ivar_type：实例变量的类型编码字符串。
//////    int ivar_offset：实例变量在对象内存布局中的偏移量。
////
////    Ivar *ivarList = class_copyIvarList([self class], &count);
////    for (unsigned int i = 0; i < count; i++) {
////        Ivar myIvar = ivarList[i];
////        const char *ivarName = ivar_getName(myIvar);
////        NSLog(@"ivar(%d) : %@", i, [NSString stringWithUTF8String:ivarName]);
////    }
////
////    free(ivarList);
////}
////
////// 打印属性列表
////- (void)printPropertyList {
////    unsigned int count;
////
////    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
////    for (unsigned int i = 0; i < count; i++) {
////        const char *propertyName = property_getName(propertyList[i]);
////        NSLog(@"propertyName(%d) : %@", i, [NSString stringWithUTF8String:propertyName]);
////    }
////
////    free(propertyList);
////}
////
////// 打印方法列表
////- (void)printMethodList {
////    unsigned int count;
////
////    Method *methodList = class_copyMethodList([self class], &count);
////    for (unsigned int i = 0; i < count; i++) {
////        Method method = methodList[i];
////        NSLog(@"method(%d) : %@", i, NSStringFromSelector(method_getName(method)));
////    }
////
////    free(methodList);
////}
//
//
//@end






