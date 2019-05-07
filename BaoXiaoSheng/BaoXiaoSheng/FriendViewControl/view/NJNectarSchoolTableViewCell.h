//
//  NJNectarSchoolTableViewCell.h
//  Beesgarden
//
//  Created by 张阳 on 2018/6/15.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GeeNectarSchoolModel;

static NSString *nectarSchoolCellId = @"nectarSchoolCellId";

@interface NJNectarSchoolTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *nectarIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nectarNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nectarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nectarTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nectarContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nectarTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nectarShareButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) GeeNectarSchoolModel * model;

@end
