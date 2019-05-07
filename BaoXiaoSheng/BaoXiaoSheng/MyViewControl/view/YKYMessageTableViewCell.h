//
//  YKYMessageTableViewCell.h
//  ShengYa
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKYMessageTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BGView;

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *contentLab;
@end

NS_ASSUME_NONNULL_END
