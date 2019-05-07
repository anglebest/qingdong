//
//  YKYMyViewTableViewCell.m
//  ShengYa
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyViewTableViewCell.h"

@implementation YKYMyViewTableViewCell

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
        _BGView.frame = CGRectMake(15, 0, kScreenWidth- 30, 45*RATIO);
    }
    return  _BGView;
}

-(UIImageView *)leftImg{
    
    if (!_leftImg) {
        _leftImg = [UIImageView new];
    }
    
    return _leftImg;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = KPFFont(14);
        _titleLab.textColor = kColor(51, 51, 51);
    }
    
    return _titleLab;
}
- (void)setupSubviews {
    
    self.contentView.backgroundColor = kColor(245, 245, 245);
    [self.contentView addSubview:self.BGView];
//    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.contentView);
//        make.left.equalTo(self.contentView).mas_offset(15*RATIO);
//        make.right.equalTo(self.contentView).mas_offset(-15*RATIO);
//    }];
    
//    [self.BGView setNeedsLayout];
    
    [self.BGView addSubview:self.leftImg];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.BGView).mas_offset(16*RATIO);
        make.left.equalTo(self.BGView).mas_offset(16*RATIO);
        make.width.height.mas_equalTo(14*RATIO);
        make.centerY.mas_equalTo(self.BGView);
    }];
    
    
    [self.BGView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.BGView).mas_offset(16*RATIO);
        make.left.equalTo(self.leftImg.mas_right).mas_offset(10*RATIO);
        make.width.mas_equalTo(150*RATIO);
        make.height.mas_equalTo(16*RATIO);
        make.centerY.mas_equalTo(self.BGView);
    }];
    
    
    UIView  *line = [UIView new];
    line.backgroundColor = kColor(230, 230, 230);
    
    [self.BGView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        
        make.right.equalTo(self.BGView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.BGView).mas_offset(0);
    }];
    
}
@end
