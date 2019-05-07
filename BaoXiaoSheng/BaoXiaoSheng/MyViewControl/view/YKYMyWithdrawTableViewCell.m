//
//  YKYMyWithdrawTableViewCell.m
//  ShengYa
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyWithdrawTableViewCell.h"

@implementation YKYMyWithdrawTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupSubviews];
        
    }
    
    return self;
}
- (void)setupSubviews {
    self.contentView.backgroundColor = kColor(245, 245, 245);
    [self.contentView addSubview:self.headView];
  
    
    [self.headView addSubview:self.titleLabel];
   
    
    [self.headView addSubview:self.secendTitleLabel];
    
    [self.headView addSubview:self.timeLabel];
    
    
    [self.headView addSubview:self.moneyLabel];
    [self.headView addSubview:self.statusLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth - 30, 1)];
    line.backgroundColor = kColor(230, 230, 230);
    
    [self.headView addSubview:line];
    
    
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.frame = CGRectMake(15, 0, kScreenWidth- 30, 113);
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = 2;
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 300, 16)];
        
        _titleLabel.text = @"提现明细";
        _titleLabel.font = KPFMFont(15);
        
    }
    return _titleLabel;
}

-(UILabel *)secendTitleLabel{
    if (!_secendTitleLabel) {
        _secendTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 300, 16)];
        
        _secendTitleLabel.text = @"提现";
        _secendTitleLabel.font = KPFMFont(15);
        
    }
    return _secendTitleLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 300, 16)];
        
        _timeLabel.text = @"2019-04-05 09:10:23";
        _timeLabel.font = KPFMFont(12);
        _timeLabel.textColor = kColor(153, 153, 153);
        
    }
    return _timeLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 18)];
        
        _moneyLabel.text = @"-100.00";
        _moneyLabel.font = KPFMFont(21);
//        _moneyLabel.textColor = kColor(153, 153, 153);
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}

-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 88, 200, 16)];
        
        _statusLabel.text = @"提现中";
        _statusLabel.font = KPFMFont(12);
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = kColor(153, 153, 153);
        
    }
    return _statusLabel;
}
@end
