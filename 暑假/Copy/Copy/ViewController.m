//
//  ViewController.m
//  Copy
//
//  Created by chenglin on 2024/8/2.
//

#import "ViewController.h"
#import "Car.h"
#import "DDPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Car *car = [[Car alloc] init];
    car.name = @"奥迪";
    DDPerson *p = [[DDPerson alloc] init];
    p.age = 18;
    p.car = car;
    
    Car *car1 = [[Car alloc] init];
    car1.name = @"car1";
    Car *car2 = [[Car alloc] init];
    car2.name = @"car2";
    Car *car3 = [[Car alloc] init];
    car3.name = @"car3";
    p.cars = [NSMutableArray arrayWithObjects:car1, car2, car3, nil];
    
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:p requiringSecureCoding:YES error:&error];
    
    if (error) {
        NSLog(@"Archiving error: %@", error);
        return;
    }
    
    DDPerson *p1 = [NSKeyedUnarchiver unarchivedObjectOfClass:[DDPerson class] fromData:data error:&error];
    
    if (error) {
        NSLog(@"Unarchiving error: %@", error);
        return;
    }
    
    p.car.name = @"a6";
    p.cars[0].name = @"a8";
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


@end
