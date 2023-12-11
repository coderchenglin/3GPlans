//
//  ViewController.m
//  SDWebImage
//
//  Created by chenglin on 2023/12/9.
//

#import "ViewController.h"
//#import "UIImageView+WebCache.h"
#import "SDWebImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //1.初始化
//    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
//    //2.添加上视图
//    [self.view addSubview:self.imageView1];
//
//    NSURL *imageUrl = [NSURL URLWithString:@"https://www.google.com.hk/imgres?imgurl=https%3A%2F%2Fimg.linux.net.cn%2Fdata%2Fattachment%2Falbum%2F201509%2F25%2F101458liq8pgjp558gp59m.jpg&tbnid=g8w60q5Nn16JDM&vet=12ahUKEwiey-qikIKDAxWtplYBHesYAagQMygTegQIARBz..i&imgrefurl=https%3A%2F%2Flinux.cn%2Farticle-6293-1.html&docid=m8dzlmWoaqDmWM&w=600&h=391&q=%E5%A6%82%E4%BD%95%E7%9F%A5%E9%81%93%E5%9B%BE%E7%89%87%E7%9A%84URL&ved=2ahUKEwiey-qikIKDAxWtplYBHesYAagQMygTegQIARBz"];
//
//    [self.imageView1 sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 200)];
    [self.view addSubview:self.imageView1];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"1.png"];
    self.imageView1.image = image;
    
}


@end
