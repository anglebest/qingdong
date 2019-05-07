//
//  YKYMyWithdrawViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyWithdrawViewController.h"
#import "YKYWithdrawViewController.h"

#import "YKYMyWithdrawTableViewCell.h"

@interface YKYMyWithdrawViewController ()

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *moneyField;

@property (nonatomic, strong) UIButton *withdrawBtn;

@property (nonatomic, strong) UIButton *noMoneyBtn;
@end

@implementation YKYMyWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的提现";
    self.view.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.headView];
    
    
    
    
    [self.headView addSubview:self.moneyField];
    
    [self.headView addSubview:self.withdrawBtn];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 300, 16)];
    lab.text = @"可提现";
    lab.font = KPFMFont(15);
    lab.textColor = kColor(50, 50, 50);
    [self.headView addSubview:lab];
    
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 84, 300, 16)];
    lab1.text = @"提示：提现金额10元以内24小时到账，10元以上15天后到账！";
    lab1.font = KPFMFont(11);
    lab1.textColor = kColor(187, 187, 187);
    [self.headView addSubview:lab1];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 73, kScreenWidth - 20, 1)];
    line.backgroundColor = kColor(230, 230, 230);
    
    
    [self.headView addSubview:line];
    
    
    
//    [self.view addSubview:self.noMoneyBtn];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.frame = CGRectMake(15, 10, kScreenWidth- 30, 105);
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = 2;
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
    
}
-(UILabel *)moneyField{
    
    if (!_moneyField) {
        _moneyField = [UILabel new];
        _moneyField.frame = CGRectMake(15, 45, 250, 16);
        _moneyField.font = KPFFont(18);
        _moneyField.textColor = kColor(255, 87, 1);
        _moneyField.text = @"¥999";
    }
    return _moneyField;
    
}

-(UIButton *)withdrawBtn{
    
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton new];
        _withdrawBtn.frame = CGRectMake(285, 38, 45, 20);
        _withdrawBtn.titleLabel.font = KPFFont(13);
        [_withdrawBtn setTitleColor:kColor(255, 255, 255) forState:0];
        _withdrawBtn.layer.masksToBounds = YES;
        _withdrawBtn.layer.cornerRadius = 8;
        _withdrawBtn.backgroundColor = kColor(255, 87, 1);
        [_withdrawBtn setTitle:@"提现" forState:0];
        [_withdrawBtn addTarget:self action:@selector(withdrawAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawBtn;
    
}

-(UIButton *)noMoneyBtn{
    
    if (!_noMoneyBtn) {
        _noMoneyBtn = [UIButton new];
        _noMoneyBtn.frame = CGRectMake(103, 260, 170, 45);
        _noMoneyBtn.titleLabel.font = KPFFont(12);
        [_noMoneyBtn setTitleColor:kColor(255, 255, 255) forState:0];
//        _noMoneyBtn.layer.masksToBounds = YES;
//        _noMoneyBtn.layer.cornerRadius = 8;
        _noMoneyBtn.backgroundColor = kColor(255, 87, 1);
        [_noMoneyBtn setTitle:@"当前无可提现额度！" forState:0];
    }
    return _noMoneyBtn;
    
}
-(void)withdrawAction{
    
    YKYWithdrawViewController*VC = [[YKYWithdrawViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,135, kScreenWidth, kScreenHeight - SafeAreaBottomHeight-135)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法
        //        _tableView.tableHeaderView = self.headview;
        _tableView.backgroundColor = [UIColor whiteColor];
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
    
   
    return 20;
    //    return self.qiangModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        YKYMyWithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKYMyWithdrawTableViewCell"];
        if (cell==nil) {
            cell = [[YKYMyWithdrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YKYMyWithdrawTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    NJHomeChoiceModel *model= self.qiangModels[indexPath.row];
        //    cell.model = model;
        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
        headView.backgroundColor = kColor(245, 245, 245);
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        View.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, 300, 10)];
        lab.text = @"已经下单，没有看到订单？";
        lab.textColor = kColor(187, 187, 187);
        lab.font = KPFFont(13);
        [View addSubview:lab];
        
        
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(353*RATIO, 10*RATIO, 7*RATIO, 15*RATIO)];
        rightImg.image = [UIImage imageNamed:@"右箭头"];
        [View addSubview:rightImg];
        
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(153*RATIO, 110*RATIO, 70*RATIO, 80*RATIO)];
        img.image = [UIImage imageNamed:@"无记录"];
        [View addSubview:img];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, kScreenWidth, 10)];
        lab1.text = @"您还没有相关的订单";
        lab1.textColor = kColor(50, 50, 50);
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = KPFFont(15);
        [View addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 255, kScreenWidth, 10)];
        lab2.text = @"可以去看看哪些想买的";
        lab2.textColor = kColor(153, 153, 153);
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.font = KPFFont(13);
        [View addSubview:lab2];
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(123*RATIO, 290, 130*RATIO, 35*RATIO)];
        [btn setTitle:@"随便逛逛" forState:0];
        [btn setTitleColor:kColor(255, 255, 255) forState:0];
        //    [btn setImage:[UIImage imageNamed:@"圆角矩形"] forState:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:0];
        
        btn.titleLabel.font = KPFFont(13);
        [View addSubview:btn];
        
        
        [headView addSubview:View];
        return headView;
    }
    UIView *sheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    sheadView.backgroundColor = kColor(245, 245, 245);
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, 300, 10)];
    lab.text = @"您可能还会喜欢";
    lab.textColor = kColor(255, 87, 1);
    lab.font = KPFFont(15);
    [sheadView addSubview:lab];
    
    
    return sheadView;
    
}
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
    //选中商品
    //    GeeHomeDetailViewController *detailController = [[GeeHomeDetailViewController alloc]init];
    //    detailController.productId = self.qiangModels[indexPath.row].productId;
    //    detailController.sku = self.qiangModels[indexPath.row].taobaoItemId;
    //    detailController.shop = self.qiangModels[indexPath.row].shop.integerValue;
    //    detailController.model = self.qiangModels[indexPath.row];
    //    [self.navigationController pushViewController:detailController animated:YES];
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
