//
//  YKYShoppingCartTableViewCell.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/15.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYShoppingCartTableViewCell.h"
@interface YKYShoppingCartTableViewCell()
@property (nonatomic, strong) UIView *BGView;


@property (nonatomic, strong) YYLabel *storeNameLab;


@property (nonatomic, strong) UIImageView *leftImg;


@property (nonatomic, strong) YYLabel *titleLab;

@property (nonatomic, strong) YYLabel *priceLab;

@property (nonatomic, strong) UILabel *numberLab;

@property (nonatomic, strong) UILabel *rebateLab;

@property (nonatomic, strong) UIButton *rebateBtn;

@property (nonatomic, strong) UIButton *couponBtn;



@end
@implementation YKYShoppingCartTableViewCell

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
        _BGView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"购物车背景"]];
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

-(YYLabel *)priceLab{
    
    if (!_priceLab) {
        _priceLab = [YYLabel new];
        _priceLab.font = KPFFont(10);
        _priceLab.text = @"券后价¥65.00";
        _priceLab.textColor = kColor(251, 81, 3);
    }
    return _priceLab;
}

-(UILabel *)numberLab{
    
    if (!_numberLab) {
        _numberLab = [UILabel new];
        _numberLab.font = KPFFont(9);
        _numberLab.textColor = kColor(149, 149, 149);
        _numberLab.text = @"已售2.3万";
    }
    return _numberLab;
}
-(UILabel *)rebateLab{
    
    if (!_rebateLab) {
        _rebateLab = [UILabel new];
        _rebateLab.font = KPFFont(10);
        _rebateLab.textColor = kColor(149, 149, 149);
        _rebateLab.text = @"收货后:";
    }
    return _rebateLab;
}

-(UIButton *)rebateBtn{
    
    if (!_rebateBtn) {
        _rebateBtn = [UIButton new];
        _rebateBtn.titleLabel.font = KPFFont(10);
        _rebateBtn.titleLabel.textColor = kColor(255, 255, 255);
    }
    return _rebateBtn;
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
        make.top.equalTo(self.BGView).mas_offset(13*RATIO);
//        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.BGView).mas_offset(19*RATIO);
//        make.right.equalTo(self.contentView).mas_offset(-18);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.leftImg];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeNameLab.mas_bottom).mas_offset(16*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.storeNameLab);
        //        make.right.equalTo(self.contentView).mas_offset(-18);
        make.width.mas_equalTo(80*RATIO);
        make.height.mas_equalTo(80*RATIO);
    }];
    
    
    [self.BGView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImg);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.leftImg.mas_right).mas_offset(37*RATIO);
        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(34*RATIO);
    }];
    
    [self.BGView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(23*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.titleLab);
//        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab);
        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.rebateLab];
    [self.rebateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab.mas_bottom).mas_offset(11*RATIO);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.titleLab);
        //        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.rebateBtn];
    [self.rebateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rebateLab);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
        make.left.equalTo(self.rebateLab.mas_right).mas_offset(5);
        //        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(10*RATIO);
    }];
    
    [self.BGView addSubview:self.couponBtn];
    [self.couponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rebateLab);
        //        make.bottom.equalTo(self.contentView).mas_offset(0);
//        make.right.equalTo(self.BGView).mas_offset(5);
        make.right.equalTo(self.BGView).mas_offset(-12);
        make.height.mas_equalTo(17*RATIO);
    }];
    
}
@end
