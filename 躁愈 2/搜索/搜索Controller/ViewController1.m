//
//  ViewController1.m
//  new
//
//  Created by mac on 2024/2/23.
//

#import "ViewController1.h"
#import "myView.h"
extern UIColor *colorOfBack;
@interface ViewController1 ()
@property (nonatomic, strong) myView* myview;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.myview = [[myView alloc] initWithFrame:CGRectMake(0, 50, 393, 44)];
    [self.myview.cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myview];
    
    
}

- (void) back {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
