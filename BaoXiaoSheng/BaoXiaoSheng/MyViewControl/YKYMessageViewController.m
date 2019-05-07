//
//  YKYMessageViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMessageViewController.h"
#import "YKYMessageTableViewCell.h"
@interface YKYMessageViewController ()
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray *tabbleViewArray;
@end

@implementation YKYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(NSArray *)tabbleViewArray{
    if (!_tabbleViewArray) {
        _tabbleViewArray = [NSArray new];
    }
    return _tabbleViewArray;
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight-SafeAreaBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法 隐藏线
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
   
    return 2;
    return self.tabbleViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKYMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKYMessageTableViewCell"];
    if (cell==nil) {
        cell = [[YKYMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"YKYMessageTableViewCell"];
    }
//    cell.textLabel.font = KFont(16);
//    cell.textLabel.textColor = kColor(39, 39, 39);
//    cell.detailTextLabel.font = KFont(15);
 
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 45*RATIO;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 20*RATIO;
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
