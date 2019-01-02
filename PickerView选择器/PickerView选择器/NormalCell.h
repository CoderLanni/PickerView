//
//  NormalCell.h
//  Test
//
//  Created by 小毅 on 2019/1/2.
//  Copyright © 2019 小毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"
@interface NormalCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lab1;
@property (strong, nonatomic) IBOutlet UILabel *lab2;

@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)InfoModel *info;

@end
