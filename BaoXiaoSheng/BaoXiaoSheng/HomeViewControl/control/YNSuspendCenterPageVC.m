//
//  SuspendCenterPageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendCenterPageVC.h"
#import "SDCycleScrollView.h"
#import "BaseTableViewVC.h"

#import "YKYSearchViewViewController.h"

#import "GeeHomeSearchViewController.h"

#import "goodsClassificationVC.h"

@interface YNSuspendCenterPageVC () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, copy) NSArray *imagesURLs;

@property (nonatomic, copy) NSArray *cacheKeyArray;

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIButton *searchView;

@property (nonatomic, strong) UIButton *searchBtn;


@property (nonatomic, strong) NSMutableArray *tableArray;

@end

@implementation YNSuspendCenterPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [YNSuspendCenterPageVC suspendCenterPageVC];
    
    [self.view addSubview:self.navView];
    
    
    [self.navView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).mas_offset(-5*RATIO);
        make.left.equalTo(self.navView).mas_offset(15*RATIO);
        make.right.equalTo(self.navView).mas_offset(-110*RATIO);
        make.height.mas_equalTo(36*RATIO);
    }];
    [self.searchView layoutIfNeeded];
    //这里设置的是左上和左下角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.searchView.bounds   byRoundingCorners:UIRectCornerBottomLeft |    UIRectCornerTopLeft    cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.searchView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.searchView.layer.mask = maskLayer;
    
    
    [self.navView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).mas_offset(-5*RATIO);
        make.left.equalTo(self.searchView.mas_right).mas_offset(0 *RATIO);
        make.right.equalTo(self.navView).mas_offset(-15*RATIO);
        make.height.mas_equalTo(36*RATIO);
    }];
    [self.searchBtn layoutIfNeeded];
    //这里设置的是左上和左下角
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.searchBtn.bounds   byRoundingCorners:UIRectCornerBottomRight |    UIRectCornerTopRight    cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1= [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.searchBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.searchBtn.layer.mask = maskLayer1;
    
    
    [self getSuperClassifyRequest];
}

#pragma mark - Public Function
+ (instancetype)suspendCenterPageVC:(NSArray *)VCArray title:(NSArray *)titleArray{
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    //    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = YES;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = true;
    configration.showBottomLine = NO;
    configration.showScrollLine= NO;
    configration.showConver = YES;
    configration.coverCornerRadius = 14;
    configration.itemMargin = 30;
    configration.normalItemColor = kColor(83, 83, 83);
    /// 设置悬浮停顿偏移量
    configration.suspenOffsetY = SafeAreaTopHeight;
    configration.selectedItemColor = kColor(251, 81, 3);
//    configration.showAddButton = YES;
    return [self suspendCenterPageVCWithConfig:configration VC:VCArray title:titleArray];
}
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
        _navView.backgroundColor = kColor(251, 83, 1);
        _navView.hidden = YES;
    }
    return _navView;
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
        [_searchView setTitle:@"输入关键字查券，领取返利红包" forState:UIControlStateNormal];
        _searchView.titleLabel.font = KPFFont(12);
        [_searchView setTitleColor:kColor(149, 149, 149) forState:UIControlStateNormal];
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
+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config VC:(NSArray *)VCArray title:(NSArray *)titleArray {
    YNSuspendCenterPageVC *vc = [YNSuspendCenterPageVC pageViewControllerWithControllers:VCArray
                                                                                  titles:titleArray
                                                                                  config:config];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageURLStringsGroup:vc.imagesURLs];
    autoScrollView.delegate = vc;
    
    vc.headerView = autoScrollView;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    
    
    return vc;
}

+ (NSArray *)getArrayVCs {
//    BaseTableViewVC *firstVC = [[BaseTableViewVC alloc] init];
////    firstVC.cellTitle = @"鞋子";
//
//    BaseTableViewVC *secondVC = [[BaseTableViewVC alloc] init];
////    secondVC.cellTitle = @"衣服";
//
//    BaseTableViewVC *thirdVC = [[BaseTableViewVC alloc] init];
    return self;
}
//
//+ (NSArray *)getArrayTitles {
//    return @[@"推荐"];
//}

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSArray *)imagesURLs {
    if (!_imagesURLs) {
        _imagesURLs = @[
                        @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                        @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                        @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    return _imagesURLs;
}

- (NSArray *)cacheKeyArray {
    if (!_cacheKeyArray) {
        _cacheKeyArray = @[@"1", @"2", @"3"];
    }
    return _cacheKeyArray;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
//    if (index == pageViewController.controllersM.count-1) {
//
//        index =1;
//    }
    UIViewController *vc = pageViewController.controllersM[index];
    return [(BaseTableViewVC *)vc tableView];
    
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
    //        NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
    
    NSLog(@"--- contentOffset = %f, progress = %f", contentOffset, progress);
    if (progress >= 0.53) {
//        self.navView.backgroundColor = kCOLOR_RGBA(251, 83, 1, 1);
        self.navView.hidden = NO;
    }else{
        
        self.navView.hidden = YES;
    }
    
}

/// 返回列表的高度 默认是控制器的高度大小
//- (CGFloat)pageViewController:(YNPageViewController *)pageViewController heightForScrollViewAtIndex:(NSInteger)index {
//    return 400;
//}

//#pragma mark - SDCycleScrollViewDelegate
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"----click 轮播图 index %ld", index);
//}

//- (NSString *)pageViewController:(YNPageViewController *)pageViewController customCacheKeyForIndex:(NSInteger)index {
//    return self.cacheKeyArray[index];
//}

- (void)pageViewController:(YNPageViewController *)pageViewController didScrollMenuItem:(UIButton *)itemButton index:(NSInteger)index {
    NSLog(@"didScrollMenuItem index %ld", (long)index);
    if (index ==pageViewController.controllersM.count-1 ) {
        NSLog(@"最后一个");
        
//        pageViewController.pageIndex = 0;
        goodsClassificationVC *detailController = [[goodsClassificationVC alloc]init];
        //    YKYGoodsListViewController *detailController = [[YKYGoodsListViewController alloc]init];
        detailController.tableArray = self.tableArray;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}


-(void)searchAction{
    GeeHomeSearchViewController *detailController = [[GeeHomeSearchViewController alloc]init];
    [self.navigationController pushViewController:detailController animated:YES];
}
-(void)getSuperClassifyRequest{
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetSuperClassify param:nil superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        NSLog(@"data %@",data);
       
        self.tableArray = data[@"data"];
        
//        [self.tableView reloadData];
    }];
    
}

-(NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [NSMutableArray new];
    }
    return _tableArray;
    
}
@end
