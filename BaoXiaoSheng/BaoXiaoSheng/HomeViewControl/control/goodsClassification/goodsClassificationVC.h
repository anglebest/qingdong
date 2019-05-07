//
//  goodsClassificationVC.h
//  ClothingCreative
//
//  Created by 王开政 on 2018/11/13.
//  Copyright © 2018年 王开政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKYBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface goodsClassificationVC : YKYBaseViewController
@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, assign) NSInteger fromVC;

@property (nonatomic, strong) NSDictionary *shopDic;
@end

NS_ASSUME_NONNULL_END
