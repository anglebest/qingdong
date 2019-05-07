//
//  YKYEarningChildTableViewCell.m
//  ShengYa
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYEarningChildTableViewCell.h"

@interface YKYEarningChildTableViewCell()
@property (nonatomic, strong) UIView *BGView;


@property (nonatomic, strong) YYLabel *storeNameLab;


@property (nonatomic, strong) UIImageView *leftImg;


@property (nonatomic, strong) YYLabel *titleLab;

@property (nonatomic, strong) YYLabel *timeLab;

@property (nonatomic, strong) UILabel *numberLab;

@property (nonatomic, strong) UILabel *rebateLab;

@property (nonatomic, strong) UIButton *copyBtn;

@property (nonatomic, strong) UIButton *statusBtn;



@end
@implementation YKYEarningChildTableViewCell

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
        _BGView.layer.masksToBounds = YES;
        _BGView.layer.cornerRadius = 10;
        _BGView.backgroundColor = [UIColor whiteColor];
    }
    return _BGView;
}
-(YYLabel *)storeNameLab{
    
    if (!_storeNameLab) {
        _storeNameLab = [YYLabel new];
        _storeNameLab.font = KPFFont(10);
        _storeNameLab.text = @"潮新旗舰店";
        _storeNameLab.textColor = kColor(83, 83, 83);
    }
    return _storeNameLab;
}
-(UIImageView *)leftImg{
    
    if (!_leftImg) {
        _leftImg = [UIImageView new];
        _leftImg.layer.masksToBounds = YES;
        _leftImg.layer.cornerRadius = 5;
        _leftImg.backgroundColor = [UIColor redColor];
        _leftImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImg;
}
-(YYLabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [YYLabel new];
        _titleLab.numberOfLines = 2;
        _titleLab.font = KPFFont(12);
        _titleLab.textColor = kColor(72, 72, 72);
        _titleLab.text = @"荣事达落地扇静音摇头荣事达静音摇头荣事达静音摇头";
        
    }
    return _titleLab;
}

-(YYLabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [YYLabel new];
        _timeLab.font = KPFFont(10);
        _timeLab.text = @"下单时间：2019-01-19 15:53:02";
        _timeLab.textColor = kColor(153, 153, 153);
    }
    return _timeLab;
}

-(UILabel *)numberLab{
    
    if (!_numberLab) {
        _numberLab = [UILabel new];
        _numberLab.font = KPFFont(10);
        _numberLab.textColor = kColor(153, 153, 153);
        _numberLab.text = @"订单编号：348247841156741";
    }
    return _numberLab;
}
-(UILabel *)rebateLab{
    
    if (!_rebateLab) {
        _rebateLab = [UILabel new];
        _rebateLab.font = KPFFont(10);
        _rebateLab.textColor = kColor(50, 50, 50);
        _rebateLab.text = @"返利¥5.4";
    }
    return _rebateLab;
}

-(UIButton *)copyBtn{
    
    if (!_copyBtn) {
        _copyBtn = [UIButton new];
        _copyBtn.titleLabel.font = KPFFont(6);
        [_copyBtn setTitle:@"复制" forState:0];
        _copyBtn.layer.borderWidth = 1;
        _copyBtn.layer.borderColor =kColor(153, 153, 153).CGColor;
        _copyBtn.layer.cornerRadius = 5;
        _copyBtn.layer.masksToBounds = YES;
        _copyBtn.titleLabel.textColor = kColor(153, 153, 153);
        [_copyBtn setTitleColor:kColor(153, 153, 153) forState:0];
    }
    return _copyBtn;
}
-(UIButton *)statusBtn{
    
    if (!_statusBtn) {
        _statusBtn = [UIButton new];
        _statusBtn.titleLabel.font = KPFFont(11);
        [_statusBtn setTitle:@"已到账" forState:0];
//        _statusBtn.layer.borderWidth = 1;
//        _statusBtn.layer.borderColor =kColor(153, 153, 153).CGColor;
//        _statusBtn.layer.cornerRadius = 5;
//        _statusBtn.layer.masksToBounds = YES;
        _statusBtn.titleLabel.textColor = kColor(153, 153, 153);
        [_statusBtn setTitleColor:kColor(255, 34, 34) forState:0];
    }
    return _statusBtn;
}
- (void)setupSubviews {
    self.contentView.backgroundColor = kColor(245, 245, 245);
    [self.contentView addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(8*RATIO);
        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.contentView).mas_offset(18*RATIO);
        make.right.equalTo(self.contentView).mas_offset(-18*RATIO);
    }];
    
    [self.BGView addSubview:self.storeNameLab];
    [self.storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).mas_offset(10*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.BGView).mas_offset(15*RATIO);
        //        make.right.equalTo(self.contentView).mas_offset(-18);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.leftImg];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeNameLab.mas_bottom).mas_offset(16*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.BGView).mas_offset(19*RATIO);
        //        make.right.equalTo(self.contentView).mas_offset(-18);
        make.width.mas_equalTo(86*RATIO);
        make.height.mas_equalTo(86*RATIO);
    }];
    
    
    [self.BGView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImg);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.leftImg.mas_right).mas_offset(16*RATIO);
        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(36*RATIO);
    }];
    
    [self.BGView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(20*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.titleLab);
        //        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).mas_offset(10);
        make.left.equalTo(self.timeLab);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.rebateLab];
    [self.rebateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImg.mas_bottom).mas_offset(11*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.storeNameLab);
        //        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(14*RATIO);
    }];
    
    [self.BGView addSubview:self.copyBtn];
    [self.copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLab);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.right.equalTo(self.BGView).mas_offset(-20);
        //        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.statusBtn];
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rebateLab);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        //        make.right.equalTo(self.BGView).mas_offset(5);
        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(17*RATIO);
    }];
    
}

@end
