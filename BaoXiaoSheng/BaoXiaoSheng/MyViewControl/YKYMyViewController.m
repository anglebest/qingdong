//
//  YKYMyViewController.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYMyViewController.h"
#import "YKYMyViewTableViewCell.h"

#import "YKYSettingViewController.h"
#import "YKYMessageViewController.h"

#import "YKYMyEarningViewController.h"

#import "YKYMyWithdrawViewController.h"

#import "YKYMyTeamViewController.h"

#import "YKYWebViewViewController.h"

#import "YKYLoginViewController.h"

#import "YKYUserInforModel.h"

@interface YKYMyViewController ()
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *BGView;

@property (nonatomic, strong) UIImageView *photoImg;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *idLab;

@property (nonatomic, strong) UIView *earningsView;

//@property (nonatomic, strong) UIImageView *myEaringsImg;

@property (nonatomic, strong) UILabel *EaringsLab1;

@property (nonatomic, strong) UILabel *EaringsLab2;

@property (nonatomic, strong) UILabel *EaringsLab3;



@property (nonatomic, strong) NSArray *tabbleViewArray;

@property (nonatomic, strong) YKYUserInforModel *userModel;





@end

@implementation YKYMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabbleViewArray = @[@"我的订单",@"邀请赚钱",@"我的团队",@"团队订单",@"我的客服",@"设置",@"软件使用及服务协议"];
    
    [self setupSubviews];
    // Do any additional setup after loading the view.
}

-(NSArray *)tabbleViewArray{
    if (!_tabbleViewArray) {
        _tabbleViewArray = [NSArray new];
    }
    return _tabbleViewArray;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = kColor(245, 245, 245);
        _headView.frame = CGRectMake(0, 0, kScreenWidth,SafeAreaTopHeight + 219*RATIO);
        [_headView addSubview:self.BGView];
    
    }
    return  _headView;
    
}
-(UIImageView *)BGView{
    if (!_BGView) {
        _BGView = [UIImageView new];
        _BGView.image = [UIImage imageNamed:@"我的背景"];
        
    }
    return  _BGView;
    
}
-(UIImageView *)photoImg{
    
    if (!_photoImg) {
        _photoImg = [UIImageView new];
        _photoImg.layer.masksToBounds = YES;
        _photoImg.layer.cornerRadius = 30*RATIO;
        _photoImg.backgroundColor = [UIColor whiteColor];
        _photoImg.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginlPress)];
        [_photoImg addGestureRecognizer:tapBgView];
    }
    return  _photoImg;
}
-(UILabel *)nameLab{
    
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = KPFFont(14);
        _nameLab.textColor = kColor(255, 255, 255);
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text = @"";
    }
    return  _nameLab;
}

-(UILabel *)idLab{
    
    if (!_idLab) {
        _idLab = [UILabel new];
        _idLab.font = KPFFont(11);
        _idLab.textColor = kColor(255, 255, 255);
        _idLab.textAlignment = NSTextAlignmentCenter;
        _idLab.text = @"ID:-------";
    }
    return  _idLab;
}
-(UIView *)earningsView{
    if (!_earningsView) {
        _earningsView = [UIView new];
        _earningsView.backgroundColor = kColor(255, 255, 255);
        _earningsView.layer.masksToBounds = YES;
        _earningsView.layer.cornerRadius = 5;
        
//        _earningsView.frame = CGRectMake(0, 0, kScreenWidth,SafeAreaTopHeight + 219*RATIO);
//        [_earningsView addSubview:self.BGView];
        
    }
    return  _earningsView;
    
}
-(UILabel *)EaringsLab1{
    
    if (!_EaringsLab1) {
        _EaringsLab1 = [UILabel new];
        _EaringsLab1.font = KPFFont(14);
        _EaringsLab1.textColor = kColor(255, 106, 1);
        _EaringsLab1.textAlignment = NSTextAlignmentCenter;
        _EaringsLab1.text = @"12.1";
    }
    return  _EaringsLab1;
}
-(UILabel *)EaringsLab2{
    
    if (!_EaringsLab2) {
        _EaringsLab2 = [UILabel new];
        _EaringsLab2.font = KPFFont(14);
        _EaringsLab2.textColor = kColor(255, 106, 1);
        _EaringsLab2.textAlignment = NSTextAlignmentCenter;
        _EaringsLab2.text = @"12.1";
    }
    return  _EaringsLab2;
}

-(UILabel *)EaringsLab3{
    
    if (!_EaringsLab3) {
        _EaringsLab3 = [UILabel new];
        _EaringsLab3.font = KPFFont(14);
        _EaringsLab3.textColor = kColor(255, 106, 1);
        _EaringsLab3.textAlignment = NSTextAlignmentCenter;
        _EaringsLab3.text = @"12.1";
    }
    return  _EaringsLab3;
}
- (void)setupSubviews {
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.headView addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView);
        make.left.right.equalTo(self.headView);
        make.height.mas_equalTo(SafeAreaTopHeight+120*RATIO);
    }];
    
    [self.headView addSubview:self.photoImg];
    [self.photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(30*RATIO);
        make.left.equalTo(self.headView).mas_offset(158*RATIO);
        make.height.width.mas_equalTo(60*RATIO);
    }];
    
    [self.headView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoImg.mas_bottom).mas_offset(10*RATIO);
        make.left.right.equalTo(self.headView);
        make.width.mas_equalTo(15*RATIO);
    }];
    
    [self.headView addSubview:self.idLab];
    [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(10*RATIO);
        make.left.right.equalTo(self.headView);
        make.width.mas_equalTo(10*RATIO);
    }];
    
    [self.headView addSubview:self.earningsView];
    [self.earningsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idLab.mas_bottom).mas_offset(17*RATIO);
        make.left.equalTo(self.headView).mas_offset(15*RATIO);
        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(113*RATIO);
    }];
    
    [self.earningsView addSubview:self.EaringsLab1];
    [self.EaringsLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(86*RATIO);
        make.left.equalTo(self.earningsView);
//        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(11*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    [self.earningsView addSubview:self.EaringsLab2];
    [self.EaringsLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(86*RATIO);
        make.left.equalTo(self.EaringsLab1.mas_right);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(11*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    [self.earningsView addSubview:self.EaringsLab3];
    [self.EaringsLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(86*RATIO);
        make.left.equalTo(self.EaringsLab2.mas_right);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(11*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    
    UILabel *myearingLab = [UILabel new];
    myearingLab.font = KPFFont(15);
    myearingLab.textColor = kColor(255, 106, 1);
    myearingLab.textAlignment = NSTextAlignmentCenter;
    myearingLab.text = @"我的收益";
    
    UIImageView *myearingImg = [UIImageView new];
    myearingImg.image = [UIImage imageNamed:@"我的收益"];
    
    UILabel *Lab1 = [UILabel new];
    Lab1.font = KPFFont(14);
    Lab1.textColor = kColor(153, 153, 153);
    Lab1.textAlignment = NSTextAlignmentCenter;
    Lab1.text = @"累计收入";
    
    UILabel *Lab2 = [UILabel new];
    Lab2.font = KPFFont(14);
    Lab2.textColor = kColor(153, 153, 153);
    Lab2.textAlignment = NSTextAlignmentCenter;
    Lab2.text = @"入账中";
    
    UILabel *Lab3 = [UILabel new];
    Lab3.font = KPFFont(14);
    Lab3.textColor = kColor(153, 153, 153);
    Lab3.textAlignment = NSTextAlignmentCenter;
    Lab3.text = @"可提现金额";
    
    
    UIView *line0 = [UIView new];
    line0.backgroundColor = kColor(230, 230, 230);
    
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(230, 230, 230);
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kColor(230, 230, 230);
    
    
    [self.earningsView addSubview:myearingImg];
    [myearingImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(15*RATIO);
        make.left.equalTo(self.earningsView).mas_offset(17*RATIO);
        make.height.mas_equalTo(14*RATIO);
        make.width.mas_equalTo(16*RATIO);
    }];
    
    [self.earningsView addSubview:myearingLab];
    [myearingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(15*RATIO);
        make.left.equalTo(myearingImg.mas_right).mas_offset(5*RATIO);
        make.height.mas_equalTo(15*RATIO);
//        make.width.mas_equalTo(16*RATIO);
    }];
    
    
    
    [self.earningsView addSubview:Lab1];
    [Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(64*RATIO);
        make.left.equalTo(self.earningsView);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(14*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    [self.earningsView addSubview:Lab2];
    [Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(64*RATIO);
        make.left.equalTo(Lab1.mas_right);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(14*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    [self.earningsView addSubview:Lab3];
    [Lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(64*RATIO);
        make.left.equalTo(Lab2.mas_right);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(14*RATIO);
        make.width.mas_equalTo((kScreenWidth-30*RATIO)/3);
    }];
    
    
    [self.earningsView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(69*RATIO);
        make.left.equalTo(self.earningsView).mas_offset((kScreenWidth-30*RATIO)/3);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(20*RATIO);
        make.width.mas_equalTo(1);
    }];
    
    [self.earningsView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(69*RATIO);
        make.left.equalTo(self.earningsView).mas_offset(2*(kScreenWidth-30*RATIO)/3);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(20*RATIO);
        make.width.mas_equalTo(1);
    }];
    
    [self.earningsView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(44*RATIO);
        make.left.equalTo(self.earningsView).mas_offset(17*RATIO);
        make.right.equalTo(self.earningsView).mas_offset(-17*RATIO);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(1*RATIO);
    }];
    
    
    
    UIButton *btn1  = [UIButton new];
    btn1.backgroundColor = [UIColor clearColor];
    btn1.tag = 1000;
    [self.earningsView addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(44*RATIO);
        make.left.equalTo(self.earningsView).mas_offset(0*RATIO);
        make.width.equalTo(self.earningsView).multipliedBy(0.33);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(65*RATIO);
    }];
    
    [btn1 addTarget:self action:@selector(earningAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2  = [UIButton new];
    btn2.backgroundColor = [UIColor clearColor];
    [self.earningsView addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(44*RATIO);
        make.left.equalTo(btn1.mas_right).mas_offset(0*RATIO);
        make.width.equalTo(self.earningsView).multipliedBy(0.33);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(65*RATIO);
    }];
    
    UIButton *btn3  = [UIButton new];
    btn3.backgroundColor = [UIColor clearColor];
    [self.earningsView addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningsView).mas_offset(44*RATIO);
        make.left.equalTo(btn2.mas_right).mas_offset(0*RATIO);
        make.width.equalTo(self.earningsView).multipliedBy(0.33);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(65*RATIO);
    }];
    
    btn2.tag = 1001;
    btn3.tag = 1002;
    [btn2 addTarget:self action:@selector(earningAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(withdraw) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight -SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = kColor(245, 245, 245);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 下拉刷新
            //            [self loadData];
        }];
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabbleViewArray.count;
    //    return self.qiangModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKYMyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKYMyViewTableViewCell"];
    if (cell==nil) {
        cell = [[YKYMyViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YKYMyViewTableViewCell"];
    }
    
    if (indexPath.row == 0) {
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:cell.BGView.bounds   byRoundingCorners:UIRectCornerTopRight |    UIRectCornerTopLeft    cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
        maskLayer1.frame = cell.BGView.bounds;
        maskLayer1.path = maskPath1.CGPath;
        cell.BGView.layer.mask = maskLayer1;
        
    }else if (indexPath.row == self.tabbleViewArray.count-1){
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:cell.BGView.bounds   byRoundingCorners:UIRectCornerBottomRight |    UIRectCornerBottomLeft    cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
        maskLayer1.frame = cell.BGView.bounds;
        maskLayer1.path = maskPath1.CGPath;
        cell.BGView.layer.mask = maskLayer1;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftImg.image = [UIImage imageNamed:self.tabbleViewArray[indexPath.row]];
    cell.titleLab.text = self.tabbleViewArray[indexPath.row];
    //    NJHomeChoiceModel *model= self.qiangModels[indexPath.row];
    //    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45*RATIO;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return SafeAreaTopHeight + 219*RATIO;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
//        YKYMyTeamViewController *VC = [[YKYMyTeamViewController alloc]init];
//
//        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 2) {
        YKYMyTeamViewController *VC = [[YKYMyTeamViewController alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 3) {
        
    }
   else if (indexPath.row == 4) {
       
       YKYWebViewViewController *VC = [[YKYWebViewViewController alloc]init];
       VC.urlString = @"http://47.98.132.55:86/services";
       [self.navigationController pushViewController:VC animated:YES];
//        YKYMessageViewController *VC = [[YKYMessageViewController alloc]init];
//
//        //        ((NJBaseViewController *)self.parentViewController).navigationBarHideAnimated = NO;
//        [self.navigationController pushViewController:VC animated:YES];
    }
 
   else if (indexPath.row == 5) {
        YKYSettingViewController *VC = [[YKYSettingViewController alloc]init];
       
//        ((NJBaseViewController *)self.parentViewController).navigationBarHideAnimated = NO;
        [self.navigationController pushViewController:VC animated:YES];
   }else if (indexPath.row == 6) {
       YKYWebViewViewController *VC = [[YKYWebViewViewController alloc]init];
       VC.urlString = @"http://47.98.132.55:86/agreement";
       [self.navigationController pushViewController:VC animated:YES];
   }
}

-(void)earningAction:(UIButton *)sender{
    
    NSInteger tag = sender.tag-1000;
    YKYMyEarningViewController *VC = [[YKYMyEarningViewController alloc]init];
    VC.PageIndex = tag;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)withdraw{
    
     YKYMyWithdrawViewController*VC = [[YKYMyWithdrawViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
    self.userModel = [YKYUserInfor shared].userInfo;
    [self.photoImg sd_setImageWithURL:[NSURL URLWithString:self.userModel.headimgurl]];
    
    self.nameLab.text = self.userModel.nickname;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
}
-(void)LoginlPress{
    
    YKYLoginViewController*VC = [[YKYLoginViewController alloc]init];
    VC.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(YKYUserInforModel *)userModel{
    
    if (!_userModel) {
        _userModel = [YKYUserInforModel new];
    }
    return _userModel;
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
