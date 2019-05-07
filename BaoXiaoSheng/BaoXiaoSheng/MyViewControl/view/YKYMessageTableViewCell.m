//
//  YKYMessageTableViewCell.m
//  ShengYa
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMessageTableViewCell.h"

@implementation YKYMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupSubviews];
        
    }
    
    return self;
}
-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [UIView new];
        _BGView.backgroundColor = [UIColor whiteColor];
        _BGView.layer.masksToBounds = YES;
        _BGView.layer.cornerRadius = 10*RATIO;
//        _BGView.frame = CGRectMake(15, 0, kScreenWidth- 30, 45*RATIO);
    }
    return  _BGView;
}

-(UIImageView *)leftImg{
    
    if (!_leftImg) {
        _leftImg = [UIImageView new];
        _leftImg.layer.masksToBounds = YES;
        _leftImg.layer.cornerRadius = 22.5*RATIO;
        _leftImg.backgroundColor = [UIColor redColor];
    }
    
    return _leftImg;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = KPFMFont(12);
        _titleLab.textColor = kColor(83, 83, 83);
        _titleLab.text = @"二级下线付费通知";
    }
    
    return _titleLab;
}

-(UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = KPFFont(12);
        _contentLab.textColor = kColor(83, 83, 83);
        _contentLab.text = @"用户：XXX\n预计提成：预计提成不计入推广余额\n需下级收货后计入金额";
        _contentLab.numberOfLines = 0;
    }
    
    return _contentLab;
}

-(UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = KPFFont(10);
        _timeLab.text = @"2019年1月4日  14：24";
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.textColor = kColor(149, 149, 149);
    }
    
    return _timeLab;
}
- (void)setupSubviews {
    
    self.contentView.backgroundColor = kColor(245, 245, 245);
    
    
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(16*RATIO);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(12*RATIO);
    }];
    
    
    [self.contentView addSubview:self.leftImg];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(42*RATIO);
        make.left.equalTo(self.contentView).mas_offset(22*RATIO);
        make.width.height.mas_equalTo(43*RATIO);
    }];
    
    
    
  
    
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(39*RATIO);
        make.left.equalTo(self.contentView).mas_offset(90*RATIO);
        make.width.mas_equalTo(150*RATIO);
        make.right.mas_equalTo(self.contentView);
    }];
    
    
    UIView  *line = [UIView new];
    line.backgroundColor = kColor(230, 230, 230);
    
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        
        make.right.equalTo(self.contentView).mas_offset(-96*RATIO);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.contentView).mas_offset(57*RATIO);
    }];
    
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(90*RATIO);
        
        make.right.equalTo(self.contentView).mas_offset(-86*RATIO);
        make.top.equalTo(self.contentView).mas_offset(64*RATIO);
        make.bottom.equalTo(self.contentView).mas_offset(0*RATIO);
    }];
    
    
    [self.contentView addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).mas_offset(7*RATIO);
        make.left.equalTo(self.leftImg.mas_right).mas_offset(15*RATIO);
        make.right.equalTo(self.contentView).mas_offset(-88*RATIO);
//        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.contentView);
    }];
//
    [self.contentView sendSubviewToBack:self.BGView];
    
}

@end
