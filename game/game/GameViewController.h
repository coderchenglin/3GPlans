//
//  GameViewController.h
//  game
//
//  Created by chenglin on 2024/4/24.
//

#import <UIKit/UIKit.h>
#import "NewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *characterImageView;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic) BOOL isFirstStepCompleted;


@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UIImageView *messageBox;

@end

NS_ASSUME_NONNULL_END
