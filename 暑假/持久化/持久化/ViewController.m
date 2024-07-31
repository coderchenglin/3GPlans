//
//  ViewController.m
//  持久化
//
//  Created by chenglin on 2024/7/30.
//

#import "ViewController.h"

#import "Person.h"

static NSString * const kUserNameKey = @"username";
static NSString * const kUserAgeKey = @"age";
static NSString * const kUserEmailKey = @"email";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:kUserNameKey];
//    NSInteger userAge = [[NSUserDefaults standardUserDefaults] stringForKey:kUserAgeKey];
//    NSString *userEmail = [[NSUserDefaults standardUserDefaults] stringForKey:kUserEmailKey];
//
//    [[NSUserDefaults standardUserDefaults] setObject:@"john Doe" forKey:kUserNameKey];
//    [[NSUserDefaults standardUserDefaults] setInteger:30 forKey:kUserAgeKey];
//    [[NSUserDefaults standardUserDefaults] setObject:@"johndoe@example.com" forKey:kUserEmailKey];
//
//    [[NSUserDefaults standardUserDefaults] synchronize]; //确保数据立即保存
    
//    NSString *path = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"持久化"];
//    NSLog(@"%s", path);
//    NSString* path = NSHomeDirectory();
//    NSLog(@"%@", path);

//    //获取文件路径
//    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString* fileName = [path stringByAppendingPathComponent: @"filename.plist"];
//    NSLog(@"%@", path);
//
//    NSArray* array = @[@"ott", @"123", @"abc"];
//    [array writeToFile: fileName atomically: YES];
//
//    //提取plist数据
//    NSArray* result = [NSArray arrayWithContentsOfFile: fileName];
//    NSLog(@"%@", result);
    
//    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//
//    [userDefaults setObject:@"3G!!!" forKey:@"obj"];
//    [userDefaults setBool:YES forKey:@"isMale"];
//    [userDefaults setInteger:20 forKey:@"age"];
//
//    [userDefaults synchronize];
//
//    NSString *userName = [userDefaults objectForKey:@"obj"];
//    BOOL genderIsMale = [userDefaults boolForKey:@"isMale"];
//    NSInteger age = [userDefaults integerForKey:@"age"];
//    NSLog(@"%@ %d %ld", userName, genderIsMale, age);
//    //[userDefaults removeObjectForKey:@"isMale"];
    
//    Person *person = [[Person alloc] init];
//    person.name = @"XY";
//    person.age = 20;
//    person.weight = 125.0;
//
//    NSError *error;
//    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:person requiringSecureCoding:YES error:&error];
//    if (error) {
//        NSLog(@"归档错误： %@", error);
//        return;
//    }
//
//    [data1 writeToFile:@"/Users/chenglin/Desktop/3GPlans/暑假/archiver" atomically:YES];
//
//    error = nil;
//    NSData *data2 = [NSData dataWithContentsOfFile:@"/Users/chenglin/Desktop/3GPlans/暑假/archiver"];
//    Person *unarchiverPerson = (Person *)[NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:data2 error:&error];
//    if (error) {
//        NSLog(@"解档错误：%@", error);
//    }
//    //NSLog(@"unarchiverPerson: %@", unarchiverPerson);
    
    Person *person1 = [[Person alloc] init];
    person1.name = @"XY";
    person1.age = 20;
    person1.weight = 126.0;
    Dog* dog1 = [[Dog alloc] init];
    dog1.name = @"Bruce";
    person1.dog = dog1;
    
    Person* person2 = [[Person alloc] init];
    person2.name = @"Jacky";
    person2.age = 21;
    person2.weight = 130.0;
    Dog* dog2 = [[Dog alloc] init];
    dog2.name = @"Oudy";
    person2.dog = dog2;
    
    //创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:NO];
    
    //进行归档（编码）操作
    [archiver encodeObject:person1 forKey:@"personOne"];
    [archiver encodeObject:person2 forKey:@"personTwo"];
    
    //将归档（序列化）后的数据写入指定文件中
    [archiver.encodedData writeToFile:@"/Users/chenglin/Desktop/3GPlans/暑假/test.archiver" atomically:YES];
    
    //结束归档
    [archiver finishEncoding];
    
    //依次解档
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/chenglin/Desktop/3GPlans/暑假/test.archiver"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:nil];
    unarchiver.requiresSecureCoding = NO;
    
    Person *unarchiverPerson1 = [unarchiver decodeObjectForKey:@"personOne"];
    NSLog(@"%@ %d %lf %@", unarchiverPerson1.name, unarchiverPerson1.age, unarchiverPerson1.weight, unarchiverPerson1.dog.name);
    Person *unarchiverPerson2 = [unarchiver decodeObjectForKey:@"personTwo"];
    NSLog(@"%@ %d %lf %@", unarchiverPerson2.name, unarchiverPerson2.age, unarchiverPerson2.weight, unarchiverPerson2.dog.name);
    
    
    
}


@end
