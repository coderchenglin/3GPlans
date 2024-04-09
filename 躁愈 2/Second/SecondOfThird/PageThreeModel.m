//
//  PageThreeModel.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/22.
//

#import "PageThreeModel.h"
#import "ARPet.h"
@implementation PageThreeModel
- (NSMutableArray *)setARPetArray {
    self.aRPetArray = [[NSMutableArray alloc] init];
    self.aRPetArray = [NSMutableArray arrayWithObjects:@"Bird_Orange", @"Shiba", @"An_Animated_Cat", @"Dinosaur", @"Concerto", nil];
    return _aRPetArray;
}

- (NSMutableArray *)setARPetModelArray {
    self.aRPetModelArray = [[NSMutableArray alloc] init];
    self.aRPetModelArray = [NSMutableArray arrayWithObjects:@"Bird_Orange.usdz", @"Shiba.usdz", @"An_Animated_Cat.usdz", @"Dinosaur.usdz", @"Concerto.usdz", nil];
    return _aRPetModelArray;
}

- (NSMutableArray *)setARPetPngArray {
    self.aRPetPngArray = [[NSMutableArray alloc] init];
    self.aRPetPngArray = [NSMutableArray arrayWithObjects:@"Bird_Orange.png", @"Shiba.png", @"An_Animated_Cat.png", @"Dinosaur.png", @"Concerto.png", nil];
    return _aRPetModelArray;
}

- (NSMutableArray *)setPetsPointsArray {
    ARPet *Bird_Orange = [[ARPet alloc] init];
    Bird_Orange.name = @"Bird_Orange";
    Bird_Orange.unlockPoints = 10;
    
    ARPet *Shiba = [[ARPet alloc] init];
    Shiba.name = @"Shiba";
    Shiba.unlockPoints = 20;
    
    ARPet *An_Animated_Cat = [[ARPet alloc] init];
    An_Animated_Cat.name = @"An_Animated_Cat";
    An_Animated_Cat.unlockPoints = 30;
    
    ARPet *Dinosaur = [[ARPet alloc] init];
    Dinosaur.name = @"Dinosaur";
    Dinosaur.unlockPoints = 40;
    
    ARPet *Concerto = [[ARPet alloc] init];
    Concerto.name = @"Concerto";
    Concerto.unlockPoints = 50;
    
    self.petsPointsArray = [NSMutableArray array];
    [_petsPointsArray addObject:Bird_Orange];
    [_petsPointsArray addObject:Shiba];
    [_petsPointsArray addObject:An_Animated_Cat];
    [_petsPointsArray addObject:Dinosaur];
    [_petsPointsArray addObject:Concerto];

    return _petsPointsArray;
}
@end
