//
//  NJHomeDetailTableViewCell.h
//  Beesgarden
//
//  Created by YR on 2018/4/19.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKYHomeModel.h"

static NSString *homeDetailCell = @"homeDetailCell";

typedef void (^AddToCartsBlock) (void);
@interface NJHomeDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *quanBtn;

@property (nonatomic, strong) YKYHomeModel *model;

@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;


+ (CGFloat)cellHeight;

@end
