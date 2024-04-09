//
//  ARPetViewController.h
//  躁愈
//
//  Created by 夏楠 on 2024/3/22.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ARPetViewController : UIViewController<SCNPhysicsContactDelegate, SCNSceneRendererDelegate>
@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic) SCNScene* scene1;
@property (nonatomic) SCNView *sceneView;
@property (nonatomic) SCNView* subSceneView;
@property (nonatomic, strong) SCNNode* modelNode;
@property (nonatomic, copy)NSString *aRPetName;
@end

NS_ASSUME_NONNULL_END
