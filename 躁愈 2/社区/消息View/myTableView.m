//
//  myTableView.m
//  new
//
//  Created by mac on 2024/2/28.
//

#import "myTableView.h"
#import "myTableViewCell.h"
extern UIColor *colorOfBack;

@implementation myTableView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    self.backgroundColor = colorOfBack;
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[myTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    } else {
        return 0;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myTableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = UIColor.yellowColor;
    if (!cell) {
        cell = [[myTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
        for (int i = 0; i < 3; i++) {
            cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"i+6.png"]];
            cell.imageview.frame = CGRectMake(25+40*i, 15, 40, 40);
            
            [cell.contentView addSubview:cell.imageview];
        }
        
   
    
    return cell;
}
@end
