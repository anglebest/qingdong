//
//  YKYSearchViewViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/19.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYSearchViewViewController.h"

@interface YKYSearchViewViewController ()
@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation YKYSearchViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view.
}
-(UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [UITextField new];
        _searchTextField.frame = CGRectMake(15*RATIO, 6, 300*RATIO, 31);
        _searchTextField.backgroundColor = kColor(245, 245, 245);
        _searchTextField.layer.masksToBounds = YES;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索灰"]];
        _searchTextField.leftView = img;
        _searchTextField.layer.cornerRadius = 10;
    }
    return _searchTextField;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = myButton;
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    self.navigationController.navigationBar.tintColor = kColor(51, 51, 51);
//
    [self.navigationController.navigationBar addSubview:self.searchTextField];
    
//    [self.navigationController.navigationBar addSubview:self.searchBtn];
    
}
-(void)clickEvent{

   [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //        NJHomeFlowLayout *layout = [[NJHomeFlowLayout alloc]init];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.itemSize = [GeeHomeProductCell cellSize];
        layout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionReusableView classForCoder] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"firstheader"];
        [_collectionView registerClass:[UICollectionReusableView classForCoder] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lastheader"];
        [_collectionView registerClass:[UICollectionReusableView classForCoder] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        [_collectionView registerClass:[UICollectionReusableView classForCoder] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ffooter"];
//        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NJPlatformCell classForCoder]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:platformCell];
//        [_collectionView registerClass:[GeeRadioCell classForCoder] forCellWithReuseIdentifier:radioCell];
//        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NJAdvertiseCell classForCoder]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:advertiseCell];
//        [_collectionView registerClass:[GeeMarketKindCell classForCoder] forCellWithReuseIdentifier:marketKindCell];
//        [_collectionView registerClass:[GeeRealtimeSaleCell classForCoder] forCellWithReuseIdentifier:realtimeSaleCell];
//        [_collectionView registerClass:[GeeDaySaleCell classForCoder] forCellWithReuseIdentifier:daySaleCell];
//        [_collectionView registerClass:[GeeHomeProductCell classForCoder] forCellWithReuseIdentifier:homeProductCell];
//        [_collectionView registerClass:[GeeKindOneCell classForCoder] forCellWithReuseIdentifier:kindoneCell];
//        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NJEmptyCollectionCell classForCoder]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:emptyCollectionCell];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"fcellid"];
        
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UICollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
        _collectionView.contentInset = UIEdgeInsetsZero;
        
//        @weakify(self);
//
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            @strongify(self);
//            [self loadData];
//        }];
        //        _collectionView.mj_header.lastUpdatedTime = nil;
        
//        header.lastUpdatedTimeLabel.alpha = 0;
//        header.stateLabel.textColor = [UIColor whiteColor];
//        _collectionView.mj_header = header;
        self.collectionView.mj_footer.hidden = YES;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 高度不能直接设置为0或者CGFLOAT_MIN，会导致cellforitem方法不回调
    CGSize size = CGSizeMake(kScreenWidth/4, 40);
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 7) {
        return 15.f*RATIO;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDataSource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    
    
    UICollectionViewCell * hCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fcellid" forIndexPath:indexPath];
    //                [cell addSubview:self.scrollBar];
    hCell.backgroundColor = [UIColor redColor];
    cell = hCell;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 8;
    
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    

    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth, 20*RATIO);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];

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
