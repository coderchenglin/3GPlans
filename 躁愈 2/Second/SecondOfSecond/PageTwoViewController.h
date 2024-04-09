//
//  PageTwoViewController.h
//  segment
//
//  Created by 夏楠 on 2024/3/7.
//

#import <UIKit/UIKit.h>
@class PageTwoView;
@class PageTwoModel;
@class QuestionAnalysisViewController;
NS_ASSUME_NONNULL_BEGIN

@interface PageTwoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PageTwoView *pageTwoView;
@property (nonatomic, strong) PageTwoModel *pageTwoModel;
- (void)selectPhotoFromLibrary;
@property (nonatomic, copy) NSDictionary *modelDictionary;
@property (nonatomic, strong) QuestionAnalysisViewController *questionAnalysisViewController;
@property (strong, nonatomic) NSMutableDictionary *heightCache;

@end

NS_ASSUME_NONNULL_END
