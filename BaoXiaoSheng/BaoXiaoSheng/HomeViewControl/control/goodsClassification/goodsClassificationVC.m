//
//  goodsClassificationVC.m
//  ClothingCreative
//
//  Created by 王开政 on 2018/11/13.
//  Copyright © 2018年 王开政. All rights reserved.
//

#import "goodsClassificationVC.h"
#import "JDCategoryLeftTabelView.h"
#import "JDCategoryRightCollectionView.h"
#import "GeeHomeSearchViewController.h"
#import "YKYGoodsListViewController.h"

//#import "bannerH5.h"
@interface goodsClassificationVC ()<UIScrollViewDelegate, UICollectionViewDelegate>
@property(nonatomic, strong) UITableView *Tab;

@property (nonatomic, strong) JDCategoryLeftTabelView *leftView;
@property (nonatomic, strong) JDCategoryRightCollectionView *rightView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) BOOL didEndDecelerating;

@property (nonatomic, strong) UIButton *searchView;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) NSMutableArray *collectionArray;

@end

@implementation goodsClassificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionArray = [[NSMutableArray alloc]init];
    
//    NSLog(@"ttt%@",self.tableArray[0][@"data"]);
//    self.tableArray = [[NSMutableArray alloc]init];
    
    
//    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"女装",@"name",@"0",@"id",@"为你推荐 ",@"label_desc", nil];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
//    [self.tableArray addObject:dic];
    
//    NSLog(@"self.sss = %@",self.tableArray);
    [self setupLeftViews];
    
    self.collectionArray = self.tableArray[0][@"data"];
    
    
    [self setupRightViews];
    
//    if (self.fromVC == 2) {
//        [self getFindAllGoodsLists:self.tableArray[0][@"id"]];
//    }else{
//
//        [self getGoodsLists:self.tableArray[0][@"id"]];
//
//    }
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    
//    self.navigationController.navigationBar  = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.searchView];
    
    [self.navigationController.navigationBar addSubview:self.searchBtn];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.searchView removeFromSuperview];
    
    [self.searchBtn removeFromSuperview];
}
-(UIButton *)searchView{
    
    if (!_searchView) {
        _searchView = [[UIButton alloc] init];
        _searchView.clipsToBounds = YES;
        _searchView.frame = CGRectMake(50, 7, 270, 30);
        _searchView.layer.cornerRadius = 10;
        //        _searchView.layer.borderColor = UIColorFromRGB0X(0xF1F1F1).CGColor;
        //        _searchView.layer.borderWidth = 1;
        _searchView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
        _searchView.backgroundColor = kColor(245, 245, 245);
        [_searchView setImage:[UIImage imageNamed:@"搜索灰"] forState:UIControlStateNormal];
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
        
        _searchBtn.backgroundColor = [UIColor clearColor];
        //        [_searchView setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        
        _searchBtn.frame = CGRectMake(320, 7, 60, 30);
        _searchBtn.titleLabel.font = KPFFont(13);
        [_searchBtn setTitleColor:kColor(50, 50, 50) forState:UIControlStateNormal];
        
        
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _searchBtn;
}

-(void)searchAction{
   
    GeeHomeSearchViewController *detailController = [[GeeHomeSearchViewController alloc]init];
    [self.navigationController pushViewController:detailController animated:YES];
}

/**
 *思路1
 *使用CollectionView,每个cell添加一个collectionView
 */
#pragma mark -------UI设置-------
- (void)setupLeftViews {
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationController.navigationBar.translucent = NO;
    JDCategoryLeftTabelView *leftView = [[JDCategoryLeftTabelView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.bounds.size.height-SafeAreaTopHeight) style:UITableViewStylePlain];
    leftView.backgroundColor = kColor(244, 244, 244);
    leftView.separatorStyle = UITableViewCellSeparatorStyleNone;//推荐该方法
    self.leftView = leftView;
    self.leftView.mutArray = self.tableArray;
    [self.view addSubview:leftView];
    __weak typeof(self) weakSelf = self;
    [leftView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        
        self.collectionArray = self.tableArray[indexPath.row][@"data"];
        
//        NSLog(@"collectionArray == %@",self.collectionArray);
        

        self.rightView.mutArray = self.collectionArray;
        [weakSelf.rightView reloadData];
////        if (weakSelf.leftView.numberOfSections) {
//            [weakSelf.leftView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition: UITableViewScrollPositionTop animated:NO];
////        }
//        [weakSelf.leftView setContentOffset:CGPointMake(0,0) animated:NO];
//
       
        [weakSelf.rightView scrollToTop];
        
//        [weakSelf.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }];
    
    //    CGFloat rightWidth = KScreenWidth - 100;
  
    
}
- (void)setupRightViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenWidth - 100, kScreenHeight - SafeAreaTopHeight);
    JDCategoryRightCollectionView *rightView = [[JDCategoryRightCollectionView alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 100, kScreenHeight - SafeAreaTopHeight) collectionViewLayout:flowLayout];
    self.rightView = rightView;
//    self.rightView.count = 4;
    self.rightView.mutArray = self.collectionArray;
    __weak typeof(self) weakSelf = self;
    [rightView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        
//        NSLog(@"%ld-----///----%ld",indexPath.section,indexPath.row);
//        NSLog(@"%@",weakSelf.collectionArray[indexPath.section][@"info"][indexPath.row][@"sonName"]);
        
        YKYGoodsListViewController *resultController = [[YKYGoodsListViewController alloc]init];
        resultController.tip = weakSelf.collectionArray[indexPath.section][@"info"][indexPath.row][@"sonName"];
        [weakSelf.navigationController pushViewController:resultController animated:YES];
  
        
    }];
    rightView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    rightView.delegate = self;
    rightView.pagingEnabled = YES;
    [self.view addSubview:rightView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.didEndDecelerating = YES;
    // 调用方法A，传scrollView.contentOffset
    [self scrollViewWithScrollView:scrollView];
    NSLog(@"停止滑动");
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    CGFloat height = self.rightView.height;
    NSLog(@"高度%f", height);
    NSInteger index = offsetY/height;
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    //    [self.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    //    [self.leftView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
//    self.leftView.selectedRow = index;
}
- (void)scrollViewWithScrollView:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //    NSLog(@"%f", offsetY);
    if (offsetY < _lastContentOffset) {
        //        NSLog(@"上");
        
    }else {
        //        NSLog(@"下");
    }
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
