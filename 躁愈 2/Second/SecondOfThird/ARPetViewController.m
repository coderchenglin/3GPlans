//
//  ARPetViewController.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/22.
//

#import "ARPetViewController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
extern UIColor *colorOfBack;

@interface ARPetViewController ()

@end

@implementation ARPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scene = [SCNScene sceneNamed:_aRPetName]; // 替换为你的模型文件名
    self.scene1 = [SCNScene sceneNamed:_aRPetName];
    // 创建一个SceneKit视图
    self.sceneView = [[SCNView alloc] initWithFrame:self.view.frame];
    self.subSceneView = [[SCNView alloc] init];
    self.subSceneView.frame = CGRectMake(Width - 200, 50, 190, 200);
    
    SCNNode *node = self.scene.rootNode;
    //素材放大5倍（由于我们素材的尺寸太小了）
    node.transform = SCNMatrix4MakeScale(0.5, 0.5, 0.5);
    
    self.sceneView.delegate = self;
    self.subSceneView.delegate = self;
    // 将场景设置到SceneKit视图中
    self.sceneView.scene = self.scene;
    self.sceneView.backgroundColor = colorOfBack;
    
    self.subSceneView.scene = self.scene1;
    self.subSceneView.backgroundColor = colorOfBack;
    
    // 配置SceneKit视图
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.allowsCameraControl =YES;
    
    self.subSceneView.autoenablesDefaultLighting = YES;
    self.subSceneView.allowsCameraControl =YES;
    
    // 将SceneKit视图添加到视图控制器的视图中
    [self.view addSubview:self.sceneView];
    [self.sceneView addSubview:self.subSceneView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
