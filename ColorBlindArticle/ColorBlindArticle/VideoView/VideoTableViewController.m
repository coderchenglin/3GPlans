//
//  CommonTableViewController.m
//  ColorBlindArticle
//
//  Created by chenglin on 2024/4/3.
//

#import "VideoTableViewController.h"
#import "VideoCell.h"
#import "MYLabel.h"

@interface VideoTableViewController () <UITableViewDelegate, UITableViewDataSource, VideoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cellHeights; //存储Cell高度的字典

@end

@implementation VideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VideoCell class] forCellReuseIdentifier:@"VideoCell"];
    [self.view addSubview:self.tableView];
    
    self.cellHeights = [NSMutableDictionary dictionary]; //初始化高度字典
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.delegate = self; // 设置代理
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 假数据
    cell.avatarImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar%ld.jpeg", (long)indexPath.row + 1]];
    cell.avatarImageView.layer.cornerRadius = 10;
    cell.avatarImageView.layer.masksToBounds = YES;
    
    cell.videoPlayerView.backgroundColor = [UIColor grayColor]; //视频播放控件的背景颜色
    cell.videoPlayerView.layer.cornerRadius = 5;
    cell.videoPlayerView.layer.masksToBounds = YES;
    
    [cell.likesButton setTitle:@"点赞" forState:UIControlStateNormal];
    [cell.commentButton setTitle:@"收藏" forState:UIControlStateNormal];
    if (indexPath.row == 0) {
        cell.descriptionLabel.text = @"探索色盲的神秘世界，揭示其影响。深入了解这一视觉异常，发现可能潜藏于我们每个人身上的秘密。";
        cell.usernameLabel.text = @"莫博Mobo";
    } else if (indexPath.row == 1) {
        cell.descriptionLabel.text = @"挑战色盲与色弱测试！检验你的视力，探索你的色彩感知能力，看看你能达到哪个级别！";
        cell.usernameLabel.text = @"硬核派ThinkAhead";
    } else if (indexPath.row == 2) {
        cell.descriptionLabel.text = @"探索色盲的原理，揭示不同于想象的色盲世界。深入了解这一视觉异常，拓展视角与理解。";
        cell.usernameLabel.text = @"Topbook";
    } else {
        cell.descriptionLabel.text = @"学习如何确认自己是否患有色盲。了解简单的色盲测试方法，保护你的视力健康。";
        cell.usernameLabel.text = @"博物";
    }
    cell.descriptionLabel.font = [UIFont boldSystemFontOfSize:18.0];
    
    //Load video
    NSString *videoName = [NSString stringWithFormat:@"视频%ld", (long)indexPath.row + 1];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:videoName ofType:@"mp4"];

    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    cell.player = [AVPlayer playerWithURL:videoURL];
    cell.playerLayer = [AVPlayerLayer playerLayerWithPlayer:cell.player];
    cell.playerLayer.frame = cell.videoPlayerView.bounds;
    [cell.videoPlayerView.layer addSublayer:cell.playerLayer];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *key = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
//    NSNumber *height = self.cellHeights[key];
////    NSLog(@"key1 = %@",key);
////    NSLog(@"self.cellHeights[%@]1 = %@", key, self.cellHeights[key]);
//    if (height) {
//        return [height floatValue];
//    } else {
////        return UITableViewAutomaticDimension;
//        return 500;
//    }
//
////    return 400;
    ///- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取指定 indexPath 的单元格
    VideoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 动态计算 Label 的高度
    CGFloat padding = 10.0;
    CGFloat width = CGRectGetWidth(tableView.bounds) - 2 * padding;
    CGSize labelSize = [cell.descriptionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    
    // 返回单元格的高度
    return 280 + labelSize.height + padding * 2 + 30; // label高度 + 上下边距 + button高度
}

- (void)cellDidToggleExpansion:(VideoCell *)cell {
    //cell展开状态发生变化，刷新对应行高
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    NSString *key = [NSString stringWithFormat:@"%ld-%ld", indexPath.section,indexPath.row];
//    CGFloat newHeight = [self.tableView cellForRowAtIndexPath:indexPath].frame.size.height;
//    self.cellHeights[key] = @(newHeight);
//    NSLog(@"key = %@",key);
//    NSLog(@"self.cellHeights[key] = %@",self.cellHeights[key]);
    
    if (@available(iOS 11.0, *)) {
        [cell.contentView.superview layoutIfNeeded];
    } else {
        [cell.superview layoutIfNeeded];
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

//- (UITableView *)tableView {
//    UIView *view = self;
//    while (view != nil && ![view isKindOfClass:[UITableView class]]) {
//        view = view.superview;
//    }
//    return (UITableView *)view;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
