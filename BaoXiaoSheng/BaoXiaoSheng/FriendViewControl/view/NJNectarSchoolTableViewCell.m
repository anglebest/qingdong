//
//  NJNectarSchoolTableViewCell.m
//  Beesgarden
//
//  Created by 张阳 on 2018/6/15.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJNectarSchoolTableViewCell.h"
//#import "GeeNectarSchoolModel.h"
//#import "UIColor+NJUniteColor.h"

@implementation NJNectarSchoolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nectarShareButton.layer.cornerRadius = 10;
    self.nectarShareButton.layer.masksToBounds = YES;
    
    self.nectarIconImageView.layer.cornerRadius = 20;
    self.nectarIconImageView.layer.masksToBounds = YES;
    
    self.nectarImageView.layer.cornerRadius = 5;
    self.nectarImageView.layer.masksToBounds = YES;
    
    self.nectarTitleLabel.layer.cornerRadius = 5;
    self.nectarTitleLabel.layer.masksToBounds = YES;
    self.nectarTitleLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    
   
}

- (void)setModel:(GeeNectarSchoolModel *)model
{
    if (model == nil) {
        return;
    }
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.masksToBounds= YES;
    
//    [self.nectarShareButton setBackgroundColor:[UIColor format_colorWithHex:0xFFE8E8  Withalpha:1]];
//    [self.nectarShareButton setTitleColor:[UIColor format_colorWithHex:0xC7627F Withalpha:1] forState:UIControlStateNormal];
//    [self.nectarImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
//    self.nectarNameLabel.text = model.nickname;
//    self.nectarTitleLabel.text = model.title;
//    self.nectarContentLabel.text = model.introduce;
//    self.nectarTimeLabel.text = [NSString stringWithTimeString:[model.createtime doubleValue]];
//    
//    [self.nectarIconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
