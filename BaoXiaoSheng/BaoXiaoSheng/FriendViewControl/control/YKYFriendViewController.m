//
//  YKYFriendViewController.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYFriendViewController.h"

#import "NJNectarTableViewCell.h"


@interface YKYFriendViewController ()


@property (nonatomic, strong) UITableView *tableView;



@end

@implementation YKYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
//    [[UINavigationBar appearance] setBarTintColor:kColor(251, 81, 3)];
    // Do any additional setup after loading the view.
}
- (void)setupSubviews {
    [self.view addSubview:self.tableView];
}

//-(void)viewWillAppear:(BOOL)animated{
//
//
//    [self.navigationController.navigationBar setBarTintColor:kColor(251, 81, 3)];
//}
//-(void)viewDidDisappear:(BOOL)animated{
//    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        _tableView.tableHeaderView = self.headview;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 520.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJNectarTableViewCell classForCoder]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:nectarCell];
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
    
    NJNectarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nectarCell forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.model = self.models[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    //    self.selectCellTag = indexPath.row;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 520;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    
    
   
    
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
