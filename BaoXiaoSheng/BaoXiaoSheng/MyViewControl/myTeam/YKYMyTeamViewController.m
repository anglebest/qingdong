//
//  YKYMyTeamViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyTeamViewController.h"

#import "YKYMyTeamTableViewCell.h"

@interface YKYMyTeamViewController ()

@property (nonatomic, strong) UIView *BGView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *totalImg;

@property (nonatomic, strong) UIImageView *fansImg;

@property (nonatomic, strong) UILabel *fansLab;

@property (nonatomic, strong) UILabel *totalLab;

@property (nonatomic, strong) UILabel *todayLab;

@property (nonatomic, strong) UILabel *yestodayLab;

@property (nonatomic, strong) UILabel *directLab;

@property (nonatomic, strong) UILabel *indirectLab;

@property (nonatomic, strong) UITextField *searchField;

@end

@implementation YKYMyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(245, 245, 245);
    
    [self setUI];
    
    
    // Do any additional setup after loading the view.
}

-(void)setUI{
    [self.view addSubview:self.BGView];
    [self.view addSubview:self.headView];
    
    [self.headView addSubview:self.totalImg];
    [self.headView addSubview:self.fansImg];
    [self.headView addSubview:self.totalLab];
    [self.headView addSubview:self.fansLab];
    
    [self.headView addSubview:self.todayLab];
    [self.todayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.headView);
        make.width.equalTo(self.headView).multipliedBy(0.25);
//        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(50);
    }];
    
    
    
    [self.headView addSubview:self.yestodayLab];
    
    [self.yestodayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.todayLab.mas_right);
        make.width.equalTo(self.headView).multipliedBy(0.25);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(50);
    }];
    [self.headView addSubview:self.directLab];
    
    [self.directLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.yestodayLab.mas_right);
        make.width.equalTo(self.headView).multipliedBy(0.25);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(50);
    }];
    [self.headView addSubview:self.indirectLab];
    [self.indirectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.directLab.mas_right);
        make.width.equalTo(self.headView).multipliedBy(0.25);
        //        make.right.equalTo(self.headView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(50);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(245, 245, 245);
    [self.headView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.todayLab.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kColor(245, 245, 245);
    [self.headView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.yestodayLab.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = kColor(245, 245, 245);
    [self.headView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(130);
        make.left.equalTo(self.directLab.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    
    
    [self.view addSubview:self.searchView];
    
    [self.searchView addSubview:self.searchField];
    
    [self.view addSubview:self.tableView];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"我的团队";
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
}



-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
        _BGView.backgroundColor = kColor(255, 98, 27);
//        _BGView.layer.cornerRadius = 10;
//        _BGView.layer.masksToBounds = YES;
    }
    return _BGView;
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(15, 30, kScreenWidth-30, 185)];
        _headView.backgroundColor = kColor(255, 255, 255);
        _headView.layer.cornerRadius = 10;
        _headView.layer.masksToBounds = YES;
    }
    return _headView;
}

-(UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(15, 231, kScreenWidth-30, 56)];
        _searchView.backgroundColor = kColor(255, 255, 255);
        _searchView.layer.cornerRadius = 10;
        _searchView.layer.masksToBounds = YES;
    }
    return _searchView;
}
-(UIImageView *)totalImg{
    
    if (!_totalImg) {
        _totalImg = [[UIImageView alloc]initWithFrame:CGRectMake(41*RATIO, 15, 90, 90)];
        _totalImg.image = [UIImage imageNamed:@"圆橙"];
    }
    
    return _totalImg;
}

-(UIImageView *)fansImg{
    
    if (!_fansImg) {
        _fansImg = [[UIImageView alloc]initWithFrame:CGRectMake(214*RATIO, 15, 90, 90)];
        _fansImg.image = [UIImage imageNamed:@"圆红"];
    }
    
    return _fansImg;
}
-(UILabel *)totalLab{
    
    if (!_totalLab) {
        _totalLab = [[UILabel alloc]initWithFrame:CGRectMake(67*RATIO, 43, 39, 37)];
        _totalLab.text = @"总人数\n12人";
        _totalLab.numberOfLines = 0;
        _totalLab.font = KPFFont(13);
        _totalLab.textAlignment = NSTextAlignmentCenter;
    }
    return _totalLab;
}

-(UILabel *)fansLab{
    
    if (!_fansLab) {
        _fansLab = [[UILabel alloc]initWithFrame:CGRectMake(228*RATIO, 43, 59, 37)];
        _fansLab.text = @"粉丝贡献\n120元";
        _fansLab.numberOfLines = 0;
        _fansLab.font = KPFFont(13);
        _fansLab.textAlignment = NSTextAlignmentCenter;
    }
    return _fansLab;
}
-(UILabel *)todayLab{
    
    if (!_todayLab) {
        _todayLab = [UILabel new];
        _todayLab.textAlignment = NSTextAlignmentCenter;
        _todayLab.font = KPFFont(15);
        _todayLab.numberOfLines = 0;
        _todayLab.textColor = kColor(50, 50, 50);
        _todayLab.text = @"5人\n今日";
    }
    return _todayLab;
}

-(UILabel *)yestodayLab{
    
    if (!_yestodayLab) {
        _yestodayLab = [UILabel new];
        _yestodayLab.textAlignment = NSTextAlignmentCenter;
        _yestodayLab.font = KPFFont(15);
        _yestodayLab.textColor = kColor(50, 50, 50);
        _yestodayLab.text = @"5人\n昨日";
        _yestodayLab.numberOfLines = 0;
    }
    return _yestodayLab;
}

-(UILabel *)directLab{
    
    if (!_directLab) {
        _directLab = [UILabel new];
        _directLab.textAlignment = NSTextAlignmentCenter;
        _directLab.font = KPFFont(15);
        _directLab.textColor = kColor(50, 50, 50);
        _directLab.text = @"5人\n直属粉丝";
        _directLab.numberOfLines = 0;
    }
    return _directLab;
}

-(UILabel *)indirectLab{
    
    if (!_indirectLab) {
        _indirectLab = [UILabel new];
        _indirectLab.textAlignment = NSTextAlignmentCenter;
        _indirectLab.font = KPFFont(15);
        _indirectLab.textColor = kColor(50, 50, 50);
        _indirectLab.text = @"5人\n间接粉丝";
        _indirectLab.numberOfLines = 0;
    }
    return _indirectLab;
}

-(UITextField *)searchField{
    if (!_searchField) {
        _searchField = [[UITextField alloc]initWithFrame:CGRectMake(15, 13, kScreenWidth-60, 31)];
        _searchField.layer.masksToBounds = YES;
        _searchField.layer.cornerRadius = 8;
        _searchField.backgroundColor = kColor(245, 245, 245);

        
        _searchField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
                
        //设置显示模式为永远显示(默认不显示)
        _searchField.leftViewMode = UITextFieldViewModeAlways;

        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(270*RATIO, 15, 30, 13)];
        
        
        [btn setImage:[UIImage imageNamed:@"搜索灰"] forState:0];
        _searchField.rightViewMode = UITextFieldViewModeAlways;
        _searchField.rightView = btn;
        _searchField.placeholder = @"请输入昵称";
        _searchField.font = KPFFont(14);
    }
    return _searchField;
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,300, kScreenWidth, kScreenHeight-300)];
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
    
    YKYMyTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKYMyTeamTableViewCell"];
    if (cell==nil) {
        cell = [[YKYMyTeamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YKYMyTeamTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:cell.BGView.bounds   byRoundingCorners:UIRectCornerTopRight |    UIRectCornerTopLeft    cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
        maskLayer1.frame = cell.BGView.bounds;
        maskLayer1.path = maskPath1.CGPath;
        cell.BGView.layer.mask = maskLayer1;
        
    }else if (indexPath.row == 19){
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:cell.BGView.bounds   byRoundingCorners:UIRectCornerBottomRight |    UIRectCornerBottomLeft    cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
        maskLayer1.frame = cell.BGView.bounds;
        maskLayer1.path = maskPath1.CGPath;
        cell.BGView.layer.mask = maskLayer1;
    }
    //    NJHomeChoiceModel *model= self.qiangModels[indexPath.row];
    //    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    UIView *sheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    sheadView.backgroundColor = kColor(245, 245, 245);
    
    UILabel *lab1 = [UILabel new];
    lab1.text = @"用户昵称";
    lab1.textColor = kColor(153, 153, 153);
    lab1.font = KPFFont(13);
    lab1.textAlignment =  NSTextAlignmentCenter;
    [sheadView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sheadView).mas_offset(0);
        make.left.equalTo(sheadView);
        make.width.equalTo(sheadView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *lab2 = [UILabel new];
    lab2.text = @"粉丝来源";
    lab2.textColor = kColor(153, 153, 153);
    lab2.font = KPFFont(13);
    lab2.textAlignment =  NSTextAlignmentCenter;
    [sheadView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sheadView).mas_offset(0);
        make.left.equalTo(lab1.mas_right);
        make.width.equalTo(sheadView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *lab3 = [UILabel new];
    lab3.text = @"贡献收入";
    lab3.textColor = kColor(153, 153, 153);
    lab3.font = KPFFont(13);
    lab3.textAlignment =  NSTextAlignmentCenter;
    [sheadView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sheadView).mas_offset(0);
        make.left.equalTo(lab2.mas_right);
        make.width.equalTo(sheadView).multipliedBy(0.33);
        make.height.mas_equalTo(30);
    }];
    
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
