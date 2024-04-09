//
//  PageOneModel.m
//  躁愈
//
//  Created by 夏楠 on 2024/3/20.
//

#import "PageOneModel.h"

@implementation PageOneModel
- (NSMutableArray *)setSecondOfFirstTableViewCellArray {
    self.secondOfFirstTableViewCellArray = [[NSMutableArray alloc] init];
    self.secondOfFirstTableViewCellArray = [NSMutableArray arrayWithObjects:@"三步呼吸空间", @"唤醒自信", @"身心清理", @"疏解情绪", @"深度睡眠疗愈", nil];
    return _secondOfFirstTableViewCellArray;
}

- (NSMutableArray *)setSecondOfSecondTableViewCellArray {
    self.secondOfSecondTableViewCellArray = [[NSMutableArray alloc] init];
    self.secondOfSecondTableViewCellArray = [NSMutableArray arrayWithObjects:@"工作倦怠", @"YogaNidra睡眠冥想", @"学习前", @"失眠", @"提升幸福感", nil];
    return _secondOfSecondTableViewCellArray;
}

- (NSMutableArray *)setSecondOfThirdTableViewCellArray {
    self.secondOfThirdTableViewCellArray = [[NSMutableArray alloc] init];
    self.secondOfThirdTableViewCellArray = [NSMutableArray arrayWithObjects:@"晚安", @"呼吸入眠", @"挫败", @"慢性疼痛", @"好奇心", nil];
    return _secondOfThirdTableViewCellArray;
}

- (NSMutableArray *)setSecondOfSecondTableViewCellPicArray {
    self.secondOfSecondTableViewCellPicArray = [[NSMutableArray alloc] init];
    self.secondOfSecondTableViewCellPicArray = [NSMutableArray arrayWithObjects:@"SecondOfSecondTableViewCell1.png", @"SecondOfSecondTableViewCell2.png", @"SecondOfSecondTableViewCell3.png", @"SecondOfSecondTableViewCell4.png", @"SecondOfSecondTableViewCell5.jpeg", nil];
    return _secondOfSecondTableViewCellPicArray;
}

- (NSMutableArray *)setSecondOfThirdTableViewCellPicArray {
    self.secondOfThirdTableViewCellPicArray = [[NSMutableArray alloc] init];
    self.secondOfThirdTableViewCellPicArray = [NSMutableArray arrayWithObjects:@"SecondOfThirdTableViewCell1.png", @"SecondOfThirdTableViewCell2.png", @"SecondOfThirdTableViewCell3.jpeg", @"SecondOfThirdTableViewCell4.jpeg", @"SecondOfThirdTableViewCell5.jpeg", nil];
    return _secondOfThirdTableViewCellPicArray;
}

- (NSMutableArray *)setSecondOfFirstTableViewCellUrlArray {
    self.secondOfFirstTableViewCellUrlArray = [[NSMutableArray alloc] init];
    self.secondOfFirstTableViewCellUrlArray = [NSMutableArray arrayWithObjects:@"https://tide.fm/meditation/albums/656ece42d80e1f000168b8a4/", @"https://tide.fm/meditation/albums/61b2c680b81a3400019b5b29/", @"https://tide.fm/meditation/albums/657ff395d5f02f0001d27d59/", @"https://tide.fm/meditation/albums/654637a6d9a3b00001d47f23/", @"https://tide.fm/meditation/albums/65853605bd68200001b5c86e/", nil];
    return _secondOfFirstTableViewCellUrlArray;
}
@end
