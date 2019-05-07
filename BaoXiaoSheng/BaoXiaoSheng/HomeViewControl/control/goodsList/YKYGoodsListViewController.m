//
//  YKYGoodsListViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYGoodsListViewController.h"
#import "YKYHomeTableViewCell.h"

#import "YKYGoodsViewController.h"

@interface YKYGoodsListViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTf;

@property (nonatomic, strong) UIButton *searchBtn;


@property (nonatomic, strong) UIButton *uniqueBtn;

@property (nonatomic, strong) UIButton *saleCountBtn;

@property (nonatomic, strong) UIButton *newestBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic,strong) UIView *buttonLine;

@property (nonatomic,strong) UIView *headView;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isPriceASC;

@property (nonatomic, strong) NSMutableArray * tabArray;

//0.综合（最新），1.券后价(低到高)，2.券后价（高到低），3.券面额，4.销量，5.佣金比例，6.券面额（低到高），7.月销量（低到高），8.佣金比例（低到高），9.全天销量（高到低），10全天销量（低到高），11.近2小时销量（高到低），12.近2小时销量（低到高），13.优惠券领取量（高到低），14.好单库指数（高到低）
@property (nonatomic, copy) NSString  *sort;

@end

@implementation YKYGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sort = @"0";
    [self setupSubviews];
    [self bindEvents];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
//    YKYGoodsListViewController *vc = [[YKYGoodsListViewController alloc]init];
    //    self.navigationController.navigationBar  = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.searchTf];
    
    [self.navigationController.navigationBar addSubview:self.searchBtn];
    
    
    [[YKYUserInfor shared] saveSearchKeyword:self.tip];
    
    
    
    
//    [self getSearchGoodsListsRequest:1];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [self.searchBtn removeFromSuperview];
    
    [self.searchTf removeFromSuperview];
}
- (void)setupSubviews {
    
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(45*RATIO);
    }];
    
    
   
    UIView *line = [UIView new];
    
    line.backgroundColor = kCOLOR_RGBA(204, 204, 204, 0.5);
    [self.headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headView);
        make.width.equalTo(self.headView);
        make.left.equalTo(self.headView);
        make.height.equalTo(@(1));
    }];
    [self.headView addSubview:self.uniqueBtn];
    [self.uniqueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(7);
        make.width.equalTo(self.headView).multipliedBy(0.25);
        make.left.equalTo(self.headView);
        make.height.equalTo(@(38.f));
    }];
    
    [self.headView addSubview:self.buttonLine];
    
    
    [self.buttonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headView).mas_offset(-1);
        make.centerX.mas_equalTo(self.uniqueBtn);
        make.height.mas_equalTo(1*RATIO);
        make.width.mas_equalTo(40*RATIO);
    }];
    

    
    [self.headView addSubview:self.saleCountBtn];
    [self.saleCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.headView).multipliedBy(0.25);
        make.left.equalTo(self.uniqueBtn.mas_right).mas_offset(0);
        make.top.equalTo(self.uniqueBtn);
        make.height.equalTo(@(38.f));
    }];
    
    [self.headView addSubview:self.priceBtn];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.headView).multipliedBy(0.25);
        make.left.equalTo(self.saleCountBtn.mas_right).mas_offset(0);
        make.top.equalTo(self.uniqueBtn);
        make.height.equalTo(@(38.f));
    }];
    
    [self.headView addSubview:self.newestBtn];
    [self.newestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.headView).multipliedBy(0.25);
        make.left.equalTo(self.priceBtn.mas_right).mas_offset(0);
        make.top.equalTo(self.uniqueBtn);
        make.height.equalTo(@(38.f));
    }];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).mas_offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    

}
-(UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (UITextField *)searchTf {
    if (!_searchTf) {
        _searchTf = [[UITextField alloc] init];
        _searchTf.layer.cornerRadius = 15;
        _searchTf.clipsToBounds = YES;
        _searchTf.text = self.tip;
        _searchTf.font = KPFFont(13);
        _searchTf.frame = CGRectMake(50, 7, 270, 30);
        _searchTf.delegate = self;
        _searchTf.backgroundColor = kColor(245, 245, 245);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
        NSAttributedString *attachment = [NSAttributedString attachmentStringWithContent:[UIImage imageNamed:@"搜索灰"] contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(13.f, 13.f) alignToFont:KFont(13) alignment:YYTextVerticalAlignmentCenter];
        [attributedString appendAttributedString:attachment];
        [attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:@"粘贴宝贝标题  先领券再购物" attributes:@{NSForegroundColorAttributeName:kColor(153, 153, 153), NSFontAttributeName: KFont(13),NSBaselineOffsetAttributeName:@(-1.f)}]];
        _searchTf.attributedPlaceholder = attributedString;
        
        _searchTf.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索灰"]];
        
        
        //文本框左视图
        UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        leftView.backgroundColor = [UIColor clearColor];
        img.frame = CGRectMake(14, 10, 15, 15);
        
        [leftView addSubview:img];
        
        _searchTf.leftView = leftView;
        //        _searchTf.textAlignment = NSTextAlignmentLeft;
        
        //        _searchTf.leftView = self.typeBtn;
        //        _searchTf.rightViewMode = UITextFieldViewModeAlways;
        
        _searchTf.clearButtonMode = UITextFieldViewModeAlways;
        //        _searchTf.rightView = self.searchBtn;
        _searchTf.returnKeyType = UIReturnKeySearch;
        
        
        //设置左边视图的宽度(占位)
        //        _searchTf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
        //        _searchTf.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchTf;
}
//-(UIButton *)searchView{
//
//    if (!_searchView) {
//        _searchView = [[UIButton alloc] init];
//        _searchView.clipsToBounds = YES;
//        _searchView.frame = CGRectMake(50, 7, 270, 30);
//        _searchView.layer.cornerRadius = 10;
//        //        _searchView.layer.borderColor = UIColorFromRGB0X(0xF1F1F1).CGColor;
//        //        _searchView.layer.borderWidth = 1;
//        _searchView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
//        _searchView.backgroundColor = kColor(245, 245, 245);
//        [_searchView setImage:[UIImage imageNamed:@"搜索灰"] forState:UIControlStateNormal];
//        [_searchView setTitle:@"输入关键字查券，领取返利红包" forState:UIControlStateNormal];
//        _searchView.titleLabel.font = KPFFont(12);
//        [_searchView setTitleColor:kColor(149, 149, 149) forState:UIControlStateNormal];
//
//
//
//    }
//    return _searchView;
//}
-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
        
        _searchBtn.backgroundColor = [UIColor clearColor];
        //        [_searchView setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        
        _searchBtn.frame = CGRectMake(320*RATIO, 7, 40, 30);
        _searchBtn.titleLabel.font = KPFFont(13);
        [_searchBtn setTitleColor:kColor(50, 50, 50) forState:UIControlStateNormal];
        
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _searchBtn;
}

- (UIView *)buttonLine {
    if (!_buttonLine) {
        _buttonLine = [[UIView alloc] init];
//        _buttonLine.frame = CGRectMake(100, 45*RATIO, kWidth(30), 1);
        _buttonLine.hidden = NO;
        _buttonLine.backgroundColor = kColor(255, 85, 4);
        
//        _buttonLine.frame = CGRectMake((kScreenWidth/4 -kWidth(30))/2, 45*RATIO, kWidth(30), 1);
    }
    return _buttonLine;
}
- (UIButton *)uniqueBtn {
    if (!_uniqueBtn) {
        _uniqueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uniqueBtn setTitle:@"综合" forState:UIControlStateNormal];
        [_uniqueBtn setTitleColor:kColor(255, 85, 4) forState:UIControlStateNormal];
        _uniqueBtn.titleLabel.font = KPFFont(15);
        _uniqueBtn.tag = 100;
    }
    return _uniqueBtn;
}

- (UIButton *)saleCountBtn {
    if (!_saleCountBtn) {
        _saleCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saleCountBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_saleCountBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
        _saleCountBtn.titleLabel.font = KPFFont(15);
    }
    return _saleCountBtn;
}

- (UIButton *)newestBtn {
    if (!_newestBtn) {
        _newestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_newestBtn setTitle:@"最省钱" forState:UIControlStateNormal];
        [_newestBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
        _newestBtn.titleLabel.font = KPFMFont(15);
    }
    return _newestBtn;
}

- (UIButton *)priceBtn {
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
        [self.priceBtn setImage:[UIImage imageNamed:@"价格"] forState:UIControlStateNormal];
        _priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -70.f);
        _priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.f);
        _priceBtn.titleLabel.font = KPFMFont(15);
    }
    return _priceBtn;
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        _tableView.tableHeaderView = self.headview;
        _tableView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        
        
        
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 下拉刷新
            @strongify(self);
            [self getSearchGoodsListsRequest:1];
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
    return self.tabArray.count;
    //    return self.qiangModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (cell==nil) {
        cell = [[YKYHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YKYHomeModel *model= self.tabArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YKYHomeTableViewCell cellSize].height;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 70;
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
    //选中商品
    
    YKYGoodsViewController *detailController = [[YKYGoodsViewController alloc]init];
    detailController.model = self.tabArray[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}
/**
 绑定事件
 */
- (void)bindEvents {
    @weakify(self);
    [[self.uniqueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        
        self.uniqueBtn.tag = 100;
        self.priceBtn.tag = 0;
        self.saleCountBtn.tag = 0;
        self.newestBtn.tag = 0;
  
        
        self.sort = @"0";
      
            [self.uniqueBtn setTitleColor:kColor(255, 85, 4) forState:UIControlStateNormal];
            [self.saleCountBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.newestBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setImage:[UIImage imageNamed:@"价格"] forState:UIControlStateNormal];
        
        
        self.buttonLine.centerX = self.uniqueBtn.centerX;
        //        [self.uniqueBtn addSubview:self.buttonLine];
        //        [self.buttonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.uniqueBtn.mas_bottom).mas_offset(-1);
        //            make.width.mas_equalTo(30);
        //            make.centerX.equalTo(self.uniqueBtn);
        //            make.height.equalTo(@(1));
        //        }];
        
        //        [self loadData];
        [self.tableView.mj_header beginRefreshing];
    }];
    [[self.saleCountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
       
        self.uniqueBtn.tag = 0;
        self.priceBtn.tag = 0;
        self.saleCountBtn.tag = 100;
        self.newestBtn.tag = 0;
        
      self.sort = @"4";
        
            [self.uniqueBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.saleCountBtn setTitleColor:kColor(255, 85, 4) forState:UIControlStateNormal];
            [self.newestBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setImage:[UIImage imageNamed:@"价格"] forState:UIControlStateNormal];
       
        
        self.buttonLine.centerX = self.saleCountBtn.centerX;
        //        [self.saleCountBtn addSubview:self.buttonLine];
        //        [self.buttonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.saleCountBtn.mas_bottom).mas_offset(-1);
        //            make.width.mas_equalTo(30);
        //            make.centerX.equalTo(self.saleCountBtn);
        //            make.height.equalTo(@(1));
        //        }];
        [self.tableView.mj_header beginRefreshing];
    }];
    [[self.newestBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
       
        
        self.uniqueBtn.tag = 0;
        self.priceBtn.tag = 0;
        self.saleCountBtn.tag = 0;
        self.newestBtn.tag = 100;
        
      
        
        
        

        [self.uniqueBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.saleCountBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.newestBtn setTitleColor:kColor(255, 85, 4) forState:UIControlStateNormal];
            [self.priceBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setImage:[UIImage imageNamed:@"价格"] forState:UIControlStateNormal];

       
        
        self.buttonLine.centerX = self.newestBtn.centerX;
        
        
        self.sort = @"3";
        
        [self.tableView.mj_header beginRefreshing];
    }];
    [[self.priceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        //        if (CGColorEqualToColor([x titleColorForState:UIControlStateNormal].CGColor, kNormalColor.CGColor)) {
        self.isPriceASC = !self.isPriceASC;
        if (self.isPriceASC) {
            // 升序
            [self.priceBtn setImage:[UIImage imageNamed:@"价格上"] forState:UIControlStateNormal];
            self.sort = @"2";
        } else {
            // 降序
            [self.priceBtn setImage:[UIImage imageNamed:@"价格下"] forState:UIControlStateNormal];
            self.sort = @"1";
        }
        //            [self.collectionView.mj_header beginRefreshing];
        //            return;
        //        }
        //        self.isPriceASC = YES;
        
        self.uniqueBtn.tag = 0;
        self.priceBtn.tag = 100;
        self.saleCountBtn.tag = 0;
        self.newestBtn.tag = 0;
   
        
        
            [self.uniqueBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.saleCountBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.newestBtn setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
            [self.priceBtn setTitleColor:kColor(255, 85, 4) forState:UIControlStateNormal];
//            [self.priceBtn setImage:[UIImage imageNamed:@"jiage"] forState:UIControlStateNormal];
       
        
    
        self.buttonLine.centerX = self.priceBtn.centerX;
        [self.tableView.mj_header beginRefreshing];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}
- (nullable UIButton *)getSortBtn {
    if (self.uniqueBtn.tag == 100) {
        return self.uniqueBtn;
    }
    if (self.saleCountBtn.tag == 100) {
        return self.saleCountBtn;
    }
    if (self.newestBtn.tag == 100) {
        return self.newestBtn;
    }
    if (self.priceBtn.tag == 100) {
        return self.priceBtn;
    }
    return nil;
}

-(void)getSearchGoodsListsRequest:(NSUInteger) min_id {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(20) forKey:@"back"];
    [parameters setObject:@(min_id) forKey:@"min_id"];
    [parameters setObject:self.tip forKey:@"keyword"];
    [parameters setObject:self.sort forKey:@"sort"];
    
    
    
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeSearchKey param:parameters superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        if (!error) {
            if ([NSString isNULLString:data[@"data"]]) {
                [MBProgressHUD showMessage:data[@"msg"] toView:self.view];
                
            }else{
                NSArray<YKYHomeModel *> *models = [NSArray modelArrayWithClass:[YKYHomeModel classForCoder] json:data[@"data"][@"data"]];
                if (min_id == 1) {
                    [self.tabArray removeAllObjects];
                    @weakify(self);
                    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self getSearchGoodsListsRequest:self.min_id];
                    }];
                    
                }
                [self.tabArray addObjectsFromArray:models];
                
                self.min_id = [data[@"data"][@"min_id"] integerValue];
            }
            
        }
        //        NSLog(@"KAPIMobileHomeGetClassifyItemList %@",data);
        
        
        
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
    }];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([NSString isNULLString:textField.text]) {
        return YES;
    }
    self.tip = textField.text;
    
    
    [self.searchTf resignFirstResponder];
    [self.tableView.mj_header beginRefreshing];
//    [self getSearchGoodsListsRequest:1];
    
    return YES;
}
-(void)searchAction{
    if ([NSString isNULLString:self.searchTf.text]) {
        return;
    }
    self.tip = self.searchTf.text;
    [self.searchTf resignFirstResponder];
    [self.tableView.mj_header beginRefreshing];
}
-(NSMutableArray *)tabArray{
    if (!_tabArray) {
        _tabArray = [NSMutableArray new];
    }
    return _tabArray;
    
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
