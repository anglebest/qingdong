//
//  YKYHomeGoodsViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/24.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYHomeGoodsViewController.h"
#import "YKYHomeTableViewCell.h"

#import "YKYGoodsViewController.h"

#import "YKYHomeModel.h"
@interface YKYHomeGoodsViewController ()
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray * tabArray;
@end

@implementation YKYHomeGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"112");
    
    
//    [self getHomeGoodsListsRequest];
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法
//        _tableView.tableHeaderView = self.headview;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 下拉刷新
            @strongify(self);
            [self getHomeGoodsListsRequest:1];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
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
    detailController.model = self.tabArray[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}

-(void)getHomeGoodsListsRequest:(NSUInteger) min_id{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(20) forKey:@"back"];
    [parameters setObject:@(min_id) forKey:@"min_id"];
    [parameters setObject:@(9) forKey:@"type"];
    [parameters setObject:self.cid forKey:@"cid"];
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetClassifyItemList param:parameters superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        
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
                        [self getHomeGoodsListsRequest:self.min_id];
                    }];
                }
                [self.tabArray addObjectsFromArray:models];
                
                self.min_id = [data[@"data"][@"min_id"] integerValue];
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
