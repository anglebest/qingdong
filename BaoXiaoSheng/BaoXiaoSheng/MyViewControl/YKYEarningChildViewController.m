//
//  YKYEarningChildViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYEarningChildViewController.h"
#import "YKYEarningChildTableViewCell.h"
#import "YKYHomeTableViewCell.h"
@interface YKYEarningChildViewController ()
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray * tabArray;

@end

@implementation YKYEarningChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
    [self getLikesDatas];
    // Do any additional setup after loading the view.
}
- (id)initWithTitle:(NSString *)title andColumDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        //        _title = title;
        NSLog(@"");
    }
    return self;
}
-(id)initWithTitle:(NSString *)title andType:(NSString *)type{
    
    if (self = [super init]) {
  
    }
    return self;
}

- (void)setupSubviews {
    
    //    self.navigationBar.backgroundColor = kColor(251, 81, 3);
    //    YKYShoppingCartViewController *shopVC = [[YKYShoppingCartViewController alloc]init];
    //    shopVC.navigationItem.title = @"购物车";
    
//    self.title = @"购物车";
    
//    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
//    self.navigationItem.rightBarButtonItem = myButton;
    
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight-SafeAreaBottomHeight)];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    return self.tabArray.count;
    //    return self.qiangModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YKYEarningChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKYEarningChildTableViewCell"];
        if (cell==nil) {
            cell = [[YKYEarningChildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YKYShoppingCartTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    NJHomeChoiceModel *model= self.qiangModels[indexPath.row];
        //    cell.model = model;
        return cell;
    }
    YKYHomeTableViewCell *Hcell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (Hcell==nil) {
        Hcell = [[YKYHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    Hcell.selectionStyle = UITableViewCellSelectionStyleNone;
    YKYHomeModel *model= self.tabArray[indexPath.row];
    Hcell.model = model;
    return Hcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 164*RATIO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 400;
    }
    return 30;
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


-(void)getLikesDatas{
    
    
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:deviceUUID forKey:@"deviceValue"];
    [parameters setObject:@"MD5" forKey:@"deviceEncrypt"];
    [parameters setObject:@"IMEI" forKey:@"deviceType"];
    [parameters setObject:@(20) forKey:@"pageSize"];
    [parameters setObject:@(1) forKey:@"pageNo"];
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetSimilarInfo2 param:parameters superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        
        if (!error) {
            if ([NSString isNULLString:data[@"data"]]) {
                [MBProgressHUD showMessage:data[@"msg"] toView:self.view];
                
            }else{
                NSArray<YKYHomeModel *> *models = [NSArray modelArrayWithClass:[YKYHomeModel classForCoder] json:data[@"data"][@"data"]];
                
                [self.tabArray addObjectsFromArray:models];
                
            }
            
        }
        
        
        
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
    }];
    
    
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
