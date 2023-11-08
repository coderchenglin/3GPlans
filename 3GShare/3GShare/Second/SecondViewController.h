//
//  SecondViewController.h
//  3GShare
//
//  Created by chenglin on 2023/11/5.
//

#import <UIKit/UIKit.h>
#import "BigWhiteViewController.h"
#import "UploadViewController.h"

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController<UISearchBarDelegate>

@property (nonatomic, strong) UIView *falseView;
@property (nonatomic, strong) UIButton *uploadButton;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIColor *goodColor;


@end

NS_ASSUME_NONNULL_END
