//
//  ViewController.h
//  KVO
//
//  Created by chenglin on 2024/4/21.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Playlist.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) Playlist *playlist;
@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) UILabel *nameLabel;

@end

