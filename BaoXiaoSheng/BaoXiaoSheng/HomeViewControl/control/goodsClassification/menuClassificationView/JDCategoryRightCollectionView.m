//
//  JDCategoryRightCollectionView.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionView.h"
#import "JDCategoryRightCollectionCell.h"

@interface JDCategoryRightCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) JDCategoryRightCollectionCell *SScell;
@end


@implementation JDCategoryRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[JDCategoryRightCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
-(void)scrollToTop{
 
    
    [self.SScell.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
    
}
#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    NSLog(@"00 section%ld",self.mutArray.count);
    return 1;
    return self.mutArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
    return [self.mutArray[section][@"shopInfo"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCategoryRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.sectionTitle = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    cell.sectionTitle = @"111";
    self.SScell = cell;
    __weak typeof(self) weakSelf = self;
    [cell setCellSelectedBlock:^(NSIndexPath *indexPath) {
        if (weakSelf.CellSelectedBlock) {
            weakSelf.CellSelectedBlock(indexPath);
        }
    }];
//    if (indexPath.row == 0) {
//        cell.count = 5;
//    }else if (indexPath.row == 1) {
//        cell.count = 20;
//    }else if (indexPath.row == 2) {
//        cell.count = 20;
//    }else if (indexPath.row == 3) {
//        cell.count = 7;
//    }else if (indexPath.row == 4) {
//        cell.count = 12;
//    }else {
//        cell.count = 10;
//    }
    
    cell.mutArray = self.mutArray;
    return cell;
}
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%ld---------------------%ld",indexPath.section,indexPath.row);
}

@end
