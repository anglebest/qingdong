//
//  YKYHomeTableViewCell.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKYHomeModel.h"
@interface YKYHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) YKYHomeModel *model;
+ (CGSize)cellSize;

@end
