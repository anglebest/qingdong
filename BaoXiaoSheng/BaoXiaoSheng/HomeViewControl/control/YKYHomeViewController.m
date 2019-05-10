//
//  YKYHomeViewController.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYHomeViewController.h"
#import "YKYHomeTableViewCell.h"
#import "YKYbarView.h"

#import "goodsClassificationVC.h"
#import "YKYGoodsListViewController.h"
#import "YKYGoodsViewController.h"
#import "YKYSearchViewViewController.h"
#import "GeeHomeSearchViewController.h"
#import "YNSuspendCenterPageVC.h"
#import "YKYHomeGoodsViewController.h"
#import "YKYWebViewViewController.h"


@interface YKYHomeViewController ()<YKYScrollBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headview;

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIImageView *logoImg;

@property (nonatomic, strong) UIImageView *smilingaceImg;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIButton *searchView;

@property (nonatomic, strong) UIButton *searchBtn;


@property (nonatomic, strong) UILabel *stepLab;

@property (nonatomic, strong) UIButton *courseBtn;

@property (nonatomic, strong) UIImageView *stepImg;

@property (nonatomic, strong) YKYbarView *scrollBar;

@property (nonatomic, strong) NSMutableArray *categorys;

@property (nonatomic, strong)YNSuspendCenterPageVC *vc;
@end

@implementation YKYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  getClassRequest];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
}
-(UIView *)headview{
    
    if (!_headview) {
        _headview = [UIView new];
        _headview.frame = CGRectMake(0, 0, kScreenWidth, 280*RATIO);
        
    }
    return _headview;
}

-(UIView *)navView{
    
    if (!_navView) {
        _navView = [UIView new];
        _navView.frame = CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight);
        _navView.hidden = YES;
        [self setBackGroundGradientColor:_navView];
    }
    return _navView;
}

-(UIImageView *)logoImg{
    
    if (!_logoImg) {
        _logoImg = [UIImageView new];
        _logoImg.image = [UIImage imageNamed:@"home_name_icon"];
    }
    return _logoImg;
}

-(UIImageView *)smilingaceImg{
    
    if (!_smilingaceImg) {
        _smilingaceImg = [UIImageView new];
        _smilingaceImg.image = [UIImage imageNamed:@"home_logo"];
    }
    return _smilingaceImg;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"淘宝隐藏优惠券搜索平台";
        _titleLab.font = KFont(13);
        _titleLab.textColor = kColor(255, 255, 255);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(UIButton *)searchView{
    
    if (!_searchView) {
        _searchView = [[UIButton alloc] init];
        _searchView.clipsToBounds = YES;
//        _searchView.layer.cornerRadius = 17.f;
        //        _searchView.layer.borderColor = UIColorFromRGB0X(0xF1F1F1).CGColor;
        //        _searchView.layer.borderWidth = 1;
        _searchView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
        _searchView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        [_searchView setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_searchView setTitle:@"复制商品链接领取返利红包" forState:UIControlStateNormal];
        _searchView.titleLabel.font = KPFFont(15);
        [_searchView setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
        [_searchView addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}
-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];

        _searchBtn.backgroundColor = kColor(255, 228, 0);
//        [_searchView setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜券" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = KPFFont(15);
        [_searchBtn setTitleColor:kColor(83, 83, 83) forState:UIControlStateNormal];
        
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _searchBtn;
}

-(UILabel *)stepLab{
    
    if (!_stepLab) {
        _stepLab = [UILabel new];
        _stepLab.text = @"三步省钱";
        _stepLab.font = KPFMFont(17);
        _stepLab.textColor = kColor(255, 255, 255);
//        _stepLab.textAlignment = NSTextAlignmentCenter;
    }
    return _stepLab;
}

-(UIButton *)courseBtn{
    
    if (!_courseBtn) {
        _courseBtn = [[UIButton alloc] init];
        
        _courseBtn.backgroundColor = [UIColor clearColor];
          [_courseBtn setImage:[UIImage imageNamed:@"视频教程"] forState:UIControlStateNormal];
        
        [_courseBtn addTarget:self action:@selector(courseAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _courseBtn;
}
-(UIImageView *)stepImg{
    
    if (!_stepImg) {
        _stepImg = [UIImageView new];
        _stepImg.image = [UIImage imageNamed:@"文字"];
        _stepImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stepImg;
}

- (YKYbarView *)scrollBar {
    if (!_scrollBar) {
        _scrollBar = [[YKYbarView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth , 60)];
        _scrollBar.njDelegate = self;
        _scrollBar.generalColor = kColor(51, 51, 51);
        _scrollBar.selectedColor = kColor(255, 34, 98);
        _scrollBar.becomeBigger = YES;
    }
    return _scrollBar;
}
- (void)setupSubviews {
//    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.navView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(0);
//        make.left.right.bottom.equalTo(self.view);
//    }];
    
   
//    [self.headview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(0);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(264*RATIO);
//    }];
//
    
    [self setBackGroundGradientColor:self.headview];
    [self.headview addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headview);
        make.top.equalTo(self.headview).mas_offset(44*RATIO);
        make.size.mas_equalTo(CGSizeMake(86*RATIO, 30*RATIO));
    }];

    
    [self.headview addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).mas_offset(15*RATIO);
        make.left.equalTo(self.headview).mas_offset(0*RATIO);
        make.right.equalTo(self.headview).mas_offset(0*RATIO);
        make.height.mas_equalTo(13*RATIO);
    }];
    
    [self.headview addSubview:self.smilingaceImg];
    
    [self.headview addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(35*RATIO);
        make.left.equalTo(self.headview).mas_offset(15*RATIO);
        make.right.equalTo(self.headview).mas_offset(-110*RATIO);
        make.height.mas_equalTo(45*RATIO);
    }];
    [self.searchView layoutIfNeeded];
    //这里设置的是左上和左下角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.searchView.bounds   byRoundingCorners:UIRectCornerBottomLeft |    UIRectCornerTopLeft    cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.searchView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.searchView.layer.mask = maskLayer;
    
    [self.smilingaceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchView.mas_left).mas_offset(12*RATIO);
        make.bottom.equalTo(self.searchView.mas_top).mas_offset(12*RATIO);
        make.size.mas_offset(CGSizeMake(67*RATIO, 64*RATIO));
    }];
    
    [self.headview addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView);
        make.left.equalTo(self.searchView.mas_right).mas_offset(0 *RATIO);
        make.right.equalTo(self.headview).mas_offset(-15*RATIO);
        make.height.mas_equalTo(45*RATIO);
    }];
    [self.searchBtn layoutIfNeeded];
    //这里设置的是左上和左下角
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.searchBtn.bounds   byRoundingCorners:UIRectCornerBottomRight |    UIRectCornerTopRight    cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.searchBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.searchBtn.layer.mask = maskLayer1;
    
    
    
    
    [self.headview addSubview:self.stepLab];
    [self.stepLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).mas_offset(25*RATIO);
        make.left.equalTo(self.searchView);
        make.right.equalTo(self.headview).mas_offset(-15*RATIO);
        make.height.mas_equalTo(17*RATIO);
    }];
    
    [self.headview addSubview:self.stepImg];
    [self.stepImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepLab.mas_bottom).mas_offset(20*RATIO);
        make.left.equalTo(self.headview).mas_offset(15 *RATIO);
        make.right.equalTo(self.headview).mas_offset(-15*RATIO);
        make.height.mas_equalTo(17*RATIO);
    }];
    
    [self.headview addSubview:self.courseBtn];
    [self.courseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(107*RATIO);
//        make.left.equalTo(self.headview).mas_offset(15 *RATIO);
        make.right.equalTo(self.headview).mas_offset(-15*RATIO);
        make.height.mas_equalTo(18*RATIO);
        make.width.mas_equalTo(73*RATIO);
    }];
    //    [self.view bringSubviewToFront:shadowLine];
//        [self.view bringSubviewToFront:self.navView];
}
- (UITableView *)tableView {
    if (!_tableView) {
 
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法
        _tableView.tableHeaderView = self.headview;
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
    return 10;
//    return self.qiangModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (cell==nil) {
        cell = [[YKYHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NJHomeChoiceModel *model= self.qiangModels[indexPath.row];
//    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YKYHomeTableViewCell cellSize].height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    
    
    NSMutableArray<NSString *> *categoryNames = [NSMutableArray array];
    NSMutableArray<NSString *> *categorydescs = [NSMutableArray array];
    //            [categoryNames addObject:@"全部"];
    NSMutableArray<NSNumber *> *categoryIds = [NSMutableArray array];
    
//    NSMutableArray<NSDictionary *> *categorys =[NSMutableArray array];
//    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"全部",@"name",@"0",@"id",@"为你推荐 ",@"label_desc", nil];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
//    [categorys addObject:dic];
    
    
    
    [self.categorys enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull category, NSUInteger idx, BOOL * _Nonnull stop) {
        [categoryNames addObject:category[@"cname"]];
        [categoryIds addObject:category[@"cid"]];
//        [categorydescs addObject:category[@"label_desc"]];
        
    }];
    
    self.scrollBar.descs = categorydescs;
    self.scrollBar.titles = categoryNames;
//    [self didSelect:0];
    [headView addSubview:self.scrollBar];
    
    
    return headView;
    
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
    YKYGoodsViewController *detailController = [[YKYGoodsViewController alloc]init];
//    detailController.productId = self.qiangModels[indexPath.row].productId;
//    detailController.sku = self.qiangModels[indexPath.row].taobaoItemId;
//    detailController.shop = self.qiangModels[indexPath.row].shop.integerValue;
//    detailController.model = self.qiangModels[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}


//- (void)setBackGroundGradientColor{
//    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
//
//    gradientLayer.colors = @[(__bridge id)[UIColor format_colorWithHex:0xFF2262 Withalpha:1].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
//
//    gradientLayer.startPoint = CGPointMake(0, 0.7);
//
//    gradientLayer.endPoint = CGPointMake(0, 1);
//
//    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 118);
//
//    [self.backImgView.layer addSublayer:gradientLayer];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"111");
//        NSLog(@"%f",self.tableView.contentOffset.y);
    if (self.tableView.contentOffset.y > 100) {
        
        self.navView.hidden = NO;
        [self.navView addSubview:self.searchView];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navView).mas_offset(20*RATIO);
            make.left.equalTo(self.navView).mas_offset(15*RATIO);
            make.right.equalTo(self.navView).mas_offset(-110*RATIO);
            make.height.mas_equalTo(36*RATIO);
        }];
        [self.navView addSubview:self.searchBtn];
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navView).mas_offset(20*RATIO);
            make.left.equalTo(self.searchView.mas_right).mas_offset(0 *RATIO);
            make.right.equalTo(self.navView).mas_offset(-15*RATIO);
            make.height.mas_equalTo(36*RATIO);
        }];
    }else{
        self.navView.hidden = YES;
        [self.headview addSubview:self.searchView];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).mas_offset(37*RATIO);
            make.left.equalTo(self.headview).mas_offset(15*RATIO);
            make.right.equalTo(self.headview).mas_offset(-110*RATIO);
            make.height.mas_equalTo(36*RATIO);
        }];
        [self.headview addSubview:self.searchBtn];
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).mas_offset(37*RATIO);
            make.left.equalTo(self.searchView.mas_right).mas_offset(0 *RATIO);
            make.right.equalTo(self.headview).mas_offset(-15*RATIO);
            make.height.mas_equalTo(36*RATIO);
        }];
        
    }
    
}
#pragma mark - NJScrollBarDelegate

- (void)didSelect:(NSInteger)idx {
//    [self.scrollView setContentOffset:CGPointMake(kScreenWidth * idx, 0) animated:YES];
  
    
    goodsClassificationVC *detailController = [[goodsClassificationVC alloc]init];
//    YKYGoodsListViewController *detailController = [[YKYGoodsListViewController alloc]init];
    
    [self.navigationController pushViewController:detailController animated:YES];
    

}

-(void)searchAction{
    GeeHomeSearchViewController *detailController = [[GeeHomeSearchViewController alloc]init];
    [self.navigationController pushViewController:detailController animated:YES];
}
-(void)courseAction{
    YKYWebViewViewController *VC = [[YKYWebViewViewController alloc]init];
    VC.urlString = @"http://47.98.132.55:86/video";
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)setBackGroundGradientColor:(UIView *)view{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    gradientLayer.colors = @[(__bridge id)kColor(255, 137, 1).CGColor,(__bridge id)kColor(255, 83, 1).CGColor];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), view.size.height);
    
    [view.layer addSublayer:gradientLayer];
}
-(void)getClassRequest{
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetClassify param:nil superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
//        NSLog(@"data %@",data);
        
        if (!error) {
            self.categorys = data[@"data"];
            NSMutableArray<NSString *> *categoryNames = [NSMutableArray array];
            NSMutableArray<YKYHomeGoodsViewController *> *categoryVC = [NSMutableArray array];
            //            [categoryNames addObject:@"全部"];
            NSMutableArray<NSNumber *> *categoryIds = [NSMutableArray array];
            [self.categorys enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull category, NSUInteger idx, BOOL * _Nonnull stop) {
                [categoryNames addObject:category[@"cname"]];
                [categoryIds addObject:category[@"cid"]];
                
                YKYHomeGoodsViewController *vc = [[YKYHomeGoodsViewController alloc]init];
                //            vc.view = self.tableView;
                vc.cid = category[@"cid"];
                [categoryVC addObject:vc];
                
            }];
            
            //        [categoryVC removeLastObject];
            self.vc = [YNSuspendCenterPageVC suspendCenterPageVC:categoryVC title:categoryNames];
            
            [self addChildViewController:self.vc];
            
            
            self.vc.headerView = self.headview;
            [self.view addSubview:self.vc.view];
            
            [self setupSubviews];
        }
       
        

    }];
    
}

-(void)getHomeGoodsListsRequest{
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetClassify param:nil superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
//        NSLog(@"data %@",data);
        self.categorys = data[@"data"];
        
        
        [self.tableView reloadData];
    }];
    
}
-(NSMutableArray *)categorys{
    if (!_categorys) {
        _categorys = [[NSMutableArray alloc]init];
    }
    return _categorys;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
