//
//  YKYMyTeamTableViewCell.m
//  ShengYa
//
//  Created by apple on 2019/4/24.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyTeamTableViewCell.h"

@implementation YKYMyTeamTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupSubviews];
        
    }
    
    return self;
}
- (void)setupSubviews {
    self.contentView.backgroundColor = kColor(245, 245, 245);
    [self.contentView addSubview:self.BGView];
    
    
    [self.BGView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).mas_offset(10);
        make.left.equalTo(self.BGView);
        make.width.equalTo(self.BGView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];
    
    [self.BGView addSubview:self.fansLab];
    [self.fansLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).mas_offset(10);
        make.left.equalTo(self.nameLab.mas_right);
        make.width.equalTo(self.BGView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];
    
    [self.BGView addSubview:self.moneyLabel];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).mas_offset(10);
        make.left.equalTo(self.fansLab.mas_right);
        make.width.equalTo(self.BGView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];

    
}
-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [UIView new];
        _BGView.frame = CGRectMake(15, 0, kScreenWidth- 30, 40);
//        _BGView.layer.masksToBounds = YES;
//        _BGView.layer.cornerRadius = 2;
        _BGView.backgroundColor = [UIColor whiteColor];
    }
    
    return _BGView;
    
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = kColor(153, 153, 153);
        _nameLab.text = @"小白";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = KPFMFont(13);
    }
    return _nameLab;
}

-(UILabel *)fansLab{
    if (!_fansLab) {
        _fansLab = [UILabel new];
        _fansLab.textColor = kColor(153, 153, 153);
        _fansLab.text = @"直属粉丝";
        _fansLab.textAlignment = NSTextAlignmentCenter;
        _fansLab.font = KPFMFont(13);
    }
    return _fansLab;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = kColor(255, 87, 1);
        _moneyLabel.text = @"1.72";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = KPFMFont(13);
    }
    return _moneyLabel;
}
@end
