//
//  ViewController.m
//  storyBoard_practice
//
//  Created by chenglin on 2024/8/14.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)jump:(UIButton *)sender {
    [self performSegueWithIdentifier:@"second" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"second"]) {
        
        SecondViewController *secondVC = segue.destinationViewController;
        
        [secondVC passValueWithBlock:^(NSString *string) {
            self.label.text = string;
        }];
    }
}


@end
