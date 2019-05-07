//
//  SuspendCenterPageVC.h
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNPageViewController.h"
#import "YNPageConfigration.h"

@interface YNSuspendCenterPageVC : YNPageViewController

+ (instancetype)suspendCenterPageVC:(NSArray *)VCArray title:(NSArray *)titleArray;

+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config VC:(NSArray *)VCArray title:(NSArray *)titleArray;


@property(nonatomic, strong) NSArray *getArrayVCs;


@property(nonatomic, strong) NSArray *getArrayTitles;

@end
