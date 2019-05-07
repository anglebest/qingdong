//
//  NJNectarTableViewCell.h
//  Beesgarden
//
//  Created by YR on 2018/4/21.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GeeNectarModel;

static NSString *nectarCell = @"nectarCell";

@protocol NJNectarTableViewCellDelegate<NSObject>

/**
 分享

 @param model 数据
 */
- (void)share:(GeeNectarModel *)model;

- (void)copyData:(GeeNectarModel *)model;
/**
 预览图片

 @param model 数据
 @param idx 索引
 */
- (void)preview:(GeeNectarModel *)model index:(NSInteger)idx imageArray:(NSArray<UIButton *> *)imageArray superView:(UIView*)superView;

/**
 点击头像跳转个人中心

 @param uid 用户id
 */
- (void)personCenter:(NSNumber *)uid;

@end

@interface NJNectarTableViewCell : UITableViewCell

@property (nonatomic, strong) GeeNectarModel *model;

@property (nonatomic, weak) id<NJNectarTableViewCellDelegate> delegate;

@end
