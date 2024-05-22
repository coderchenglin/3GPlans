//
//  main.m
//  KVC_KVO
//
//  Created by chenglin on 2024/5/20.
//
//#import <Foundation/Foundation.h>
//
//@interface Book : NSObject
//@property (nonatomic, copy)  NSString* name;
//@property (nonatomic, assign)  CGFloat price;
//@end
//
//@implementation Book
//@end
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        Book *book1 = [Book new];
//        book1.name = @"The Great Gastby";
//        book1.price = 40;
//        Book *book2 = [Book new];
//        book2.name = @"Time History";
//        book2.price = 20;
//        Book *book3 = [Book new];
//        book3.name = @"Wrong Hole";
//        book3.price = 30;
//
//        Book *book4 = [Book new];
//        book4.name = @"Wrong Hole";
//        book4.price = 40;
//
//        NSArray* arrBooks = @[book1,book2,book3,book4];
//
//        NSLog(@"distinctUnionOfObjects");
//        NSArray* arrDistinct = [arrBooks valueForKeyPath:@"@distinctUnionOfObjects.price"];
//        for (NSNumber *price in arrDistinct) {
//            NSLog(@"%f",price.floatValue);
//        }
//        NSLog(@"unionOfObjects");
//        NSArray* arrUnion = [arrBooks valueForKeyPath:@"@unionOfObjects.price"];
//        for (NSNumber *price in arrUnion) {
//            NSLog(@"%f",price.floatValue);
//        }
//
//    }
//    return 0;
//}

//
//#import <Foundation/Foundation.h>
//
//@interface Address : NSObject
//
//@end
//
//@interface Address()
//
//@property (nonatomic, copy)NSString* country;
//@property (nonatomic, copy)NSString* province;
//@property (nonatomic, copy)NSString* city;
//@property (nonatomic, copy)NSString* district;
//
//@end
//
//@implementation Address
//
//@end
//
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//
//        //模型转字典
//        Address* add = [Address new];
//        add.country = @"China";
//        add.province = @"Guang Dong";
//        add.city = @"Shen Zhen";
//        add.district = @"Nan Shan";
//        NSArray* arr = @[@"country",@"province",@"city",@"district"];
//        NSDictionary* dict = [add dictionaryWithValuesForKeys:arr]; //把对应key所有的属性全部取出来
//        NSLog(@"%@",dict);
//
//        //字典转模型
//        NSDictionary* modifyDict = @{@"country":@"USA",@"province":@"california",@"city":@"Los angle"};
//        [add setValuesForKeysWithDictionary:modifyDict];            //用key Value来修改Model的属性
//        NSLog(@"country:%@  province:%@ city:%@",add.country,add.province,add.city);
//
//
//    }
//    return 0;
//}



//
//#import <Foundation/Foundation.h>
//
//// 定义 Book 类
//@interface Book : NSObject
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, assign) NSInteger price;
//@end
//
//@implementation Book
//@end
//
//// 定义 Target 类
//@interface Target : NSObject
//{
//    int age;
//}
//
//// for manual KVO - age
//- (int)age;
//- (void)setAge:(int)theAge;
//
//@end
//
//@implementation Target
//
//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        age = 10;
//    }
//    return self;
//}
//
//// for manual KVO - age
//- (int)age
//{
//    return age;
//}
//
//- (void)setAge:(int)theAge
//{
//    [self willChangeValueForKey:@"age"];
//    age = theAge;
//    [self didChangeValueForKey:@"age"];
//}
//
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"age"]) {
//        return NO;
//    }
//    return [super automaticallyNotifiesObserversForKey:key];
//}
//
//@end
//
//// Observer 类用于监听 age 属性的变化
//@interface Observer : NSObject
//@end
//
//@implementation Observer
//
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
//                       context:(void *)context
//{
//    if ([keyPath isEqualToString:@"age"]) {
//        NSLog(@"Age changed to: %@", [change objectForKey:NSKeyValueChangeNewKey]);
//    }
//}
//
//@end
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // 创建 Book 对象
//        Book *book1 = [Book new];
//        book1.name = @"Book1";
//        book1.price = 10;
//
//        Book *book2 = [Book new];
//        book2.name = @"Book2";
//        book2.price = 20;
//
//        Book *book3 = [Book new];
//        book3.name = @"Book3";
//        book3.price = 30;
//
//        Book *book4 = [Book new];
//        book4.name = @"Book3";
//        book4.price = 40;
//
//        NSArray *arrBooks = @[book1, book2, book3, book4];
//
//        // 使用 @distinctUnionOfObjects 和 @unionOfObjects
//        NSArray *distinctPrices = [arrBooks valueForKeyPath:@"@distinctUnionOfObjects.price"];
//        NSArray *allPrices = [arrBooks valueForKeyPath:@"@unionOfObjects.price"];
//
//        NSLog(@"Distinct Prices: %@", distinctPrices); // 输出：Distinct Prices: (10, 20, 30, 40)
//        NSLog(@"All Prices: %@", allPrices); // 输出：All Prices: (10, 20, 30, 40)
//
//        // 创建 Target 和 Observer 对象
//        Target *target = [[Target alloc] init];
//        Observer *observer = [[Observer alloc] init];
//
//        // 添加观察者
//        [target addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
//
//        // 修改 age 属性
//        [target setAge:20];
//        [target setAge:30];
//
//        // 移除观察者
//        [target removeObserver:observer forKeyPath:@"age"];
//    }
//    return 0;
//}




#import <Foundation/Foundation.h>

@interface Target : NSObject
{
    int age;
}

// for manual KVO - age
- (int) age;
- (void) setAge:(int)theAge;

@end

@implementation Target

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        age = 10;
    }
    
    return self;
}

// for manual KVO - age
- (int) age
{
    return age;
}

- (void) setAge:(int)theAge
{
    [self willChangeValueForKey:@"age"];
    age = theAge;
    [self didChangeValueForKey:@"age"];
}

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"age"]) {
        return NO;
    }

    return [super automaticallyNotifiesObserversForKey:key];
}

@end


#import <XCTest/XCTest.h>
#import "Target.h"

@interface TargetTests : XCTestCase
@property (nonatomic, strong) Target *target;
@property (nonatomic, strong) NSMutableArray *observedChanges;
@end

@implementation TargetTests

- (void)setUp {
    [super setUp];
    self.target = [[Target alloc] init];
    self.observedChanges = [NSMutableArray array];
    [self.target addObserver:self
                  forKeyPath:@"age"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
}

- (void)tearDown {
    [self.target removeObserver:self forKeyPath:@"age"];
    self.target = nil;
    [super tearDown];
}

- (void)testManualKVO {
    // 修改 age 属性
    self.target.age = 20;
    self.target.age = 30;
    
    // 验证观察到的值是否正确
    NSArray *expectedChanges = @[@20, @30];
    XCTAssertEqualObjects(self.observedChanges, expectedChanges, @"The observed changes do not match the expected changes");
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"age"]) {
        NSNumber *newAge = change[NSKeyValueChangeNewKey];
        [self.observedChanges addObject:newAge];
    }
}

@end
