//
//  NJHomeShopDetailsCell.h
//  Beesgarden
//
//  Created by 张阳 on 2018/5/25.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *shopDetailsCell = @"ShopDetailsCell";

@interface NJHomeShopDetailsCell : UITableViewCell

@property (nonatomic, strong) NSNumber *shop;

- (void)addStrePinJiaDic:(NSDictionary*)dic;

@end
