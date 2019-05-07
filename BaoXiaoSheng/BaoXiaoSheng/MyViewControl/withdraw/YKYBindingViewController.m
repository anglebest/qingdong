//
//  YKYBindingViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYBindingViewController.h"

@interface YKYBindingViewController ()
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UITextField *numberField;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneNumberField;


@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation YKYBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定支付宝账号";
    
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setUI{
    
//    self.title = @"我的提现";
    self.view.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.headView];
    
    [self .headView addSubview:self.numberField];
    [self .headView addSubview:self.nameField];
    [self .headView addSubview:self.phoneNumberField];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth-30, 1)];
    line1.backgroundColor = kColor(230, 230, 230);
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth-30, 1)];
    line2.backgroundColor = kColor(230, 230, 230);
    
    [self.headView addSubview:line1];
    [self.headView addSubview:line2];
    
    
    [self.view addSubview:self.sureBtn];
    
    
    
    
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(15, 242, kScreenWidth - 30, 40)];
    
    tips.text = @"提示：请填写收款人的支付宝账户和真实的收款人姓名，否则将无法正常收款。";
    tips.font = KPFMFont(12);
    tips.numberOfLines =  0;
    [self.view addSubview:tips];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.frame = CGRectMake(15, 10, kScreenWidth- 30, 135);
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = 2;
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
    
}
-(UITextField *)numberField{
    if (!_numberField) {
        _numberField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-45, 44)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        lab.text = @"  支付宝账号";
        _numberField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _numberField.leftViewMode = UITextFieldViewModeAlways;
        _numberField.leftView = lab;
        lab.font = KPFMFont(14);
        _numberField.textAlignment = NSTextAlignmentRight;
        _numberField.placeholder = @"请输入要绑定的支付宝账号";
        _numberField.font = KPFFont(14);
    }
    return _numberField;
    
}

-(UITextField *)nameField{
    if (!_nameField) {
        _nameField = [[UITextField alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth-45, 44)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        lab.text = @"  收款人姓名";
        _nameField.leftViewMode = UITextFieldViewModeAlways;
        _nameField.leftView = lab;
        lab.font = KPFMFont(14);
        _nameField.textAlignment = NSTextAlignmentRight;
        _nameField.placeholder = @"请输入支付宝收款人姓名";
        _nameField.font = KPFFont(14);
    }
    return _nameField;
    
}

-(UITextField *)phoneNumberField{
    if (!_phoneNumberField) {
        _phoneNumberField = [[UITextField alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth-45, 44)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        lab.text = @"  手机号码";
        _phoneNumberField.leftViewMode = UITextFieldViewModeAlways;
        _phoneNumberField.leftView = lab;
        lab.font = KPFMFont(14);
        _phoneNumberField.textAlignment = NSTextAlignmentRight;
        _phoneNumberField.placeholder = @"请输入手机号码";
        _phoneNumberField.font = KPFFont(14);
    }
    return _phoneNumberField;
    
}

-(UIButton *)sureBtn{
    
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        _sureBtn.frame = CGRectMake(15, 167, kScreenWidth - 30, 45);
        _sureBtn.titleLabel.font = KPFFont(15);
        [_sureBtn setTitleColor:kColor(255, 255, 255) forState:0];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.backgroundColor = kColor(255, 87, 1);
        [_sureBtn setTitle:@"绑定" forState:0];
    }
    return _sureBtn;
    
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
