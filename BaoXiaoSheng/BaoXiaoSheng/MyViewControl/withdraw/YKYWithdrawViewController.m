//
//  YKYWithdrawViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYWithdrawViewController.h"

#import "YKYBindingViewController.h"

@interface YKYWithdrawViewController ()
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UITextField *moneyField;

@property (nonatomic, strong) UIButton *withdrawBtn;


@property (nonatomic, strong) UIButton *sureBtn;


@property (nonatomic, strong) UIView *secendView;

@property (nonatomic, strong) UIButton *nameBtn;

@property (nonatomic, strong) UIButton *changeBtn;

@end

@implementation YKYWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    
    self.title = @"我的提现";
    self.view.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.headView];
    
    
    
    
    [self.headView addSubview:self.moneyField];
    
    [self.headView addSubview:self.withdrawBtn];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 300, 16)];
    lab.text = @"提现金额（元）";
    lab.font = KPFMFont(15);
    lab.textColor = kColor(50, 50, 50);
    [self.headView addSubview:lab];
    
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 84, 300, 16)];
    lab1.text = @"可提现（元）：27.5元";
    lab1.font = KPFMFont(11);
    lab1.textColor = kColor(187, 187, 187);
    [self.headView addSubview:lab1];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 73, kScreenWidth - 20, 1)];
    line.backgroundColor = kColor(230, 230, 230);
    
    
    [self.headView addSubview:line];
    
    [self.view addSubview:self.secendView];
    
    
    [self.view addSubview:self.sureBtn];
    
    UILabel *numberLab = [UILabel new];
    numberLab.text = @"收款账号";
    numberLab.textColor = kColor(50, 50, 50);
    numberLab.font = KPFMFont(13);
    
    [self.secendView addSubview:numberLab];
    
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secendView).mas_offset(15);
        
        make.height.mas_equalTo(13);
        make.top.equalTo(self.secendView).mas_offset(17);
    }];
    
    [self.secendView addSubview:self.nameBtn];
    
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberLab.mas_right).mas_offset(10);
        
        make.height.mas_equalTo(13);
        make.top.equalTo(self.secendView).mas_offset(17);
    }];
    
    [self.secendView addSubview:self.changeBtn];
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameBtn.mas_right).mas_offset(10);
        
        make.height.mas_equalTo(13);
        make.top.equalTo(self.secendView).mas_offset(17);
    }];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.frame = CGRectMake(15, 10, kScreenWidth- 20, 105);
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = 2;
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
    
}
-(UITextField *)moneyField{
    
    if (!_moneyField) {
        _moneyField = [UITextField new];
        _moneyField.placeholder = @"最少不低于1元";
        _moneyField.frame = CGRectMake(15, 45, 250, 16);
        _moneyField.font = KPFFont(13);
        _moneyField.textColor = kColor(255, 87, 1);
//        _moneyField.text = @"¥999";
    }
    return _moneyField;
    
}

-(UIButton *)withdrawBtn{
    
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton new];
        _withdrawBtn.frame = CGRectMake(285, 84, 50, 12);
        _withdrawBtn.titleLabel.font = KPFFont(11);
        [_withdrawBtn setTitleColor:kColor(43, 80, 241) forState:0];
//        _withdrawBtn.layer.masksToBounds = YES;
//        _withdrawBtn.layer.cornerRadius = 8;
//        _withdrawBtn.backgroundColor = kColor(255, 87, 1);
        [_withdrawBtn setTitle:@"全部提现" forState:0];
    }
    return _withdrawBtn;
    
}

-(UIButton *)sureBtn{
    
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        _sureBtn.frame = CGRectMake(15, 190, kScreenWidth - 30, 45);
        _sureBtn.titleLabel.font = KPFFont(15);
        [_sureBtn setTitleColor:kColor(255, 255, 255) forState:0];
        //        _noMoneyBtn.layer.masksToBounds = YES;
        //        _noMoneyBtn.layer.cornerRadius = 8;
        _sureBtn.backgroundColor = kColor(255, 87, 1);
        [_sureBtn setTitle:@"确认提现" forState:0];
    }
    return _sureBtn;
    
}

-(UIView *)secendView{
    if (!_secendView) {
        _secendView = [UIView new];
        _secendView.frame = CGRectMake(15, 124, kScreenWidth- 20, 45);
        _secendView.layer.masksToBounds = YES;
        _secendView.layer.cornerRadius = 2;
        _secendView.backgroundColor = [UIColor whiteColor];
    }
    
    return _secendView;
    
}
-(UIButton *)nameBtn{
    
    if (!_nameBtn) {
        _nameBtn = [UIButton new];
//        _nameLabel.placeholder = @"最少不低于1元";
        _nameBtn.titleLabel.font = KPFFont(13);
        [_nameBtn setTitleColor:kColor(255, 48, 48) forState:0];
        
        [_nameBtn setTitle:@"遗失" forState:0];
//        _nameBtn.textColor = kColor(255, 87, 1);
        //        _moneyField.text = @"¥999";
    }
    return _nameBtn;
    
}

-(UIButton *)changeBtn{
    
    if (!_changeBtn) {
        _changeBtn = [UIButton new];
        //        _nameLabel.placeholder = @"最少不低于1元";
        _changeBtn.titleLabel.font = KPFFont(13);
        [_changeBtn setTitleColor:kColor(43, 80, 241) forState:0];
        
        [_changeBtn setTitle:@"修改" forState:0];
        
        [_changeBtn addTarget:self action:@selector(bindingAction) forControlEvents:UIControlEventTouchUpInside];
        //        _nameBtn.textColor = kColor(255, 87, 1);
        //        _moneyField.text = @"¥999";
    }
    return _changeBtn;
    
}

-(void)bindingAction{
    
    YKYBindingViewController*VC = [[YKYBindingViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
